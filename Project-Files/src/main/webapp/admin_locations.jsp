<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*"%>

<%!
String cleanErrorMessage(Exception e) {
    String msg = e.getMessage();
    if (msg == null) return "Something went wrong. Please try again.";
    if (msg.contains("foreign key constraint fails")) return "This record cannot be changed because it is still connected to other records.";
    if (msg.contains("Duplicate entry")) return "This record already exists.";
    if (msg.contains("doesn't have a default value")) return "A required value is missing. Please check the form and try again.";
    if (msg.contains("Data truncation")) return "One of the values entered is not valid. Please check the form and try again.";
    return "Something went wrong while processing your request.";
}
%>

<%
/* ===== Auth ===== */
String currentRole = (String) session.getAttribute("role");
if (!"admin".equals(currentRole)) {
    response.sendRedirect("login.jsp");
    return;
}

/* ===== Action handling (must run BEFORE any HTML output for redirect to work) ===== */
String dbUser = "root";
String dbPassword = "CS157ALG";
String dbUrl = "jdbc:mysql://localhost:3306/project?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC&characterEncoding=UTF-8";

request.setCharacterEncoding("UTF-8");
String action = request.getParameter("action");

String flashSuccess = null;
String flashError = null;

if ("addBuilding".equals(action)) {
    String building = request.getParameter("Building");
    if (building != null && !building.trim().isEmpty()) {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
            ps = con.prepareStatement("INSERT INTO Building (BuildingName) VALUES (?)");
            ps.setString(1, building.trim());
            int result = ps.executeUpdate();
            if (result > 0) flashSuccess = "Successfully added building: " + building.trim() + ".";
            else flashError = "Failed to add building.";
        } catch (Exception e) {
            flashError = cleanErrorMessage(e);
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}

if ("addRoom".equals(action)) {
    String building = request.getParameter("RoomBuilding");
    String room = request.getParameter("Room");
    if (building != null && room != null && !building.trim().isEmpty() && !room.trim().isEmpty()) {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            int roomID = Integer.parseInt(room);
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
            ps = con.prepareStatement("INSERT INTO Room (BuildingName, RoomID) VALUES (?, ?)");
            ps.setString(1, building.trim());
            ps.setInt(2, roomID);
            int result = ps.executeUpdate();
            if (result > 0) flashSuccess = "Successfully added room " + roomID + " in " + building.trim() + ".";
            else flashError = "Failed to add room.";
        } catch (NumberFormatException e) {
            flashError = "Room ID must be a valid number.";
        } catch (Exception e) {
            flashError = cleanErrorMessage(e);
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}

if ("deleteBuilding".equals(action)) {
    String building = request.getParameter("Building");
    if (building != null && !building.trim().isEmpty()) {
        Connection con = null;
        PreparedStatement check = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
            check = con.prepareStatement("SELECT COUNT(*) FROM Room WHERE BuildingName = ?");
            check.setString(1, building.trim());
            rs = check.executeQuery();
            int roomCount = 0;
            if (rs.next()) roomCount = rs.getInt(1);
            if (roomCount > 0) {
                flashError = "Cannot delete this building because it still has " + roomCount + " room(s). Delete its rooms first.";
            } else {
                ps = con.prepareStatement("DELETE FROM Building WHERE BuildingName = ?");
                ps.setString(1, building.trim());
                int result = ps.executeUpdate();
                if (result > 0) flashSuccess = "Successfully deleted building: " + building.trim() + ".";
                else flashError = "Building not found.";
            }
        } catch (Exception e) {
            flashError = cleanErrorMessage(e);
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (check != null) check.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}

if ("deleteRoom".equals(action)) {
    String building = request.getParameter("RoomBuilding");
    String room = request.getParameter("Room");
    if (building != null && room != null && !building.trim().isEmpty() && !room.trim().isEmpty()) {
        Connection con = null;
        PreparedStatement check = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            int roomID = Integer.parseInt(room);
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
            check = con.prepareStatement("SELECT COUNT(*) FROM TakesPlaceIn WHERE RoomID = ? AND BuildingName = ?");
            check.setInt(1, roomID);
            check.setString(2, building.trim());
            rs = check.executeQuery();
            int sessionCount = 0;
            if (rs.next()) sessionCount = rs.getInt(1);
            if (sessionCount > 0) {
                flashError = "Cannot delete this room because " + sessionCount + " study session(s) still use it.";
            } else {
                ps = con.prepareStatement("DELETE FROM Room WHERE RoomID = ? AND BuildingName = ?");
                ps.setInt(1, roomID);
                ps.setString(2, building.trim());
                int result = ps.executeUpdate();
                if (result > 0) flashSuccess = "Successfully deleted room " + roomID + " in " + building.trim() + ".";
                else flashError = "Room not found.";
            }
        } catch (NumberFormatException e) {
            flashError = "Room ID must be a valid number.";
        } catch (Exception e) {
            flashError = cleanErrorMessage(e);
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (check != null) check.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}

/* If we just processed a POST, stash the message and redirect to a clean GET */
if (action != null) {
    if (flashSuccess != null) session.setAttribute("flashSuccess", flashSuccess);
    if (flashError != null)   session.setAttribute("flashError", flashError);
    response.sendRedirect("admin_locations.jsp");
    return;
}

/* On a GET, pull and clear the flash messages */
String successMessage = (String) session.getAttribute("flashSuccess");
String errorMessage   = (String) session.getAttribute("flashError");
if (successMessage != null) session.removeAttribute("flashSuccess");
if (errorMessage != null)   session.removeAttribute("flashError");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Locations</title>
<link rel="stylesheet" href="css/global.css">
<style>
  .tab-btn { cursor: pointer; }
  .tab-btn.active { box-shadow: 0 0 0 2px rgba(15,118,110,0.35); }
</style>
</head>
<body>

<%@ include file="navbar.jsp"%>

<div class="page-shell">
  <div class="container">

    <div class="card" style="margin-bottom:24px;">
      <h1 class="form-title" style="margin-bottom:8px;">Manage Locations</h1>
      <p class="form-subtitle" style="margin-bottom:0;">
        Add, view, or delete buildings and rooms.
      </p>
    </div>

    <% if (successMessage != null) { %>
      <div style="margin-bottom:24px; padding:12px 14px; border-radius:14px; background:#f4f8f6; color:#0f766e; border:1px solid rgba(15,118,110,0.18);">
        <%= successMessage %>
      </div>
    <% } %>

    <% if (errorMessage != null) { %>
      <div style="margin-bottom:24px; padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);">
        <%= errorMessage %>
      </div>
    <% } %>

    <div class="card">
      <div style="display:flex; gap:12px; flex-wrap:wrap; margin-bottom:24px;">
        <button type="button" id="tabBtn-building" class="btn btn-primary tab-btn active" onclick="showTab('buildingTab')">Buildings</button>
        <button type="button" id="tabBtn-room" class="btn btn-secondary tab-btn" onclick="showTab('roomTab')">Rooms</button>
      </div>

      <!-- ========== BUILDINGS TAB ========== -->
      <div id="buildingTab">
        <h2 style="margin-top:0; margin-bottom:6px;">Building Actions</h2>
        <p class="form-subtitle" style="margin-top:0; margin-bottom:22px;">Add or delete a building.</p>

        <div class="grid grid-2" style="margin-bottom:24px;">
          <form method="post" style="padding:18px; border:1px solid rgba(0,0,0,0.08); border-radius:16px;">
            <input type="hidden" name="action" value="addBuilding">
            <h3 style="margin-top:0; margin-bottom:16px;">Add Building</h3>
            <div class="field">
              <label for="Building">Building Name</label>
              <input type="text" id="Building" name="Building" required>
            </div>
            <button type="submit" class="btn btn-primary" style="margin-top:14px;">Add Building</button>
          </form>

          <form method="post" onsubmit="return confirm('Delete this building? This only works if the building has no rooms.');" style="padding:18px; border:1px solid rgba(180,35,24,0.18); border-radius:16px;">
            <input type="hidden" name="action" value="deleteBuilding">
            <h3 style="margin-top:0; margin-bottom:16px;">Delete Building</h3>
            <div class="field">
              <label for="DelBuilding">Building Name</label>
              <input type="text" id="DelBuilding" name="Building" required>
            </div>
            <button type="submit" class="btn btn-primary" style="margin-top:14px;">Delete Building</button>
          </form>
        </div>

        <h3 style="margin-bottom:12px;">All Buildings</h3>
        <div style="overflow-x:auto;">
          <table class="table">
            <thead>
              <tr><th>Building Name</th><th>Rooms</th><th>Action</th></tr>
            </thead>
            <tbody>
<%
{
Connection con = null;
Statement stmt = null;
ResultSet rs = null;
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
    stmt = con.createStatement();
    rs = stmt.executeQuery(
        "SELECT b.BuildingName, COUNT(r.RoomID) AS RoomCount "
        + "FROM Building b LEFT JOIN Room r ON b.BuildingName = r.BuildingName "
        + "GROUP BY b.BuildingName ORDER BY b.BuildingName"
    );
    boolean any = false;
    while (rs.next()) {
        any = true;
        String b = rs.getString("BuildingName");
        int count = rs.getInt("RoomCount");
%>
              <tr>
                <td><%= b %></td>
                <td><%= count %></td>
                <td>
                  <form method="post" onsubmit="return confirm('Delete building <%= b %>? This only works if it has no rooms.');" style="margin:0;">
                    <input type="hidden" name="action" value="deleteBuilding">
                    <input type="hidden" name="Building" value="<%= b %>">
                    <button type="submit" class="btn btn-secondary" <%= count > 0 ? "disabled style=\"opacity:0.5; cursor:not-allowed;\"" : "" %>>Delete</button>
                  </form>
                </td>
              </tr>
<%
    }
    if (!any) {
%>
              <tr><td colspan="3"><span class="muted">No buildings yet. Add one above.</span></td></tr>
<%
    }
} catch (Exception e) {
%>
              <tr><td colspan="3"><%= cleanErrorMessage(e) %></td></tr>
<%
} finally {
    try { if (rs != null) rs.close(); } catch (Exception e) {}
    try { if (stmt != null) stmt.close(); } catch (Exception e) {}
    try { if (con != null) con.close(); } catch (Exception e) {}
}
}
%>
            </tbody>
          </table>
        </div>
      </div>

      <!-- ========== ROOMS TAB ========== -->
      <div id="roomTab" style="display:none;">
        <h2 style="margin-top:0; margin-bottom:6px;">Room Actions</h2>
        <p class="form-subtitle" style="margin-top:0; margin-bottom:22px;">Add or delete a room.</p>

        <div class="grid grid-2" style="margin-bottom:24px;">
          <form method="post" style="padding:18px; border:1px solid rgba(0,0,0,0.08); border-radius:16px;">
            <input type="hidden" name="action" value="addRoom">
            <h3 style="margin-top:0; margin-bottom:16px;">Add Room</h3>
            <div class="field">
              <label for="RoomBuilding">Building Name</label>
              <input type="text" id="RoomBuilding" name="RoomBuilding" required>
            </div>
            <div class="field">
              <label for="Room">Room ID</label>
              <input type="number" id="Room" name="Room" required>
            </div>
            <button type="submit" class="btn btn-primary" style="margin-top:14px;">Add Room</button>
          </form>

          <form method="post" onsubmit="return confirm('Delete this room? This only works if no study sessions use it.');" style="padding:18px; border:1px solid rgba(180,35,24,0.18); border-radius:16px;">
            <input type="hidden" name="action" value="deleteRoom">
            <h3 style="margin-top:0; margin-bottom:16px;">Delete Room</h3>
            <div class="field">
              <label for="DelRoomBuilding">Building Name</label>
              <input type="text" id="DelRoomBuilding" name="RoomBuilding" required>
            </div>
            <div class="field">
              <label for="DelRoom">Room ID</label>
              <input type="number" id="DelRoom" name="Room" required>
            </div>
            <button type="submit" class="btn btn-primary" style="margin-top:14px;">Delete Room</button>
          </form>
        </div>

        <h3 style="margin-bottom:12px;">All Rooms</h3>
        <div style="overflow-x:auto;">
          <table class="table">
            <thead>
              <tr><th>Building Name</th><th>Room ID</th><th>Action</th></tr>
            </thead>
            <tbody>
<%
{
Connection con = null;
Statement stmt = null;
ResultSet rs = null;
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
    stmt = con.createStatement();
    rs = stmt.executeQuery("SELECT * FROM Room ORDER BY BuildingName, RoomID");
    boolean any = false;
    while (rs.next()) {
        any = true;
        String b = rs.getString("BuildingName");
        int r = rs.getInt("RoomID");
%>
              <tr>
                <td><%= b %></td>
                <td><%= r %></td>
                <td>
                  <form method="post" onsubmit="return confirm('Delete room <%= r %> in <%= b %>?');" style="margin:0;">
                    <input type="hidden" name="action" value="deleteRoom">
                    <input type="hidden" name="RoomBuilding" value="<%= b %>">
                    <input type="hidden" name="Room" value="<%= r %>">
                    <button type="submit" class="btn btn-secondary">Delete</button>
                  </form>
                </td>
              </tr>
<%
    }
    if (!any) {
%>
              <tr><td colspan="3"><span class="muted">No rooms yet. Add one above.</span></td></tr>
<%
    }
} catch (Exception e) {
%>
              <tr><td colspan="3"><%= cleanErrorMessage(e) %></td></tr>
<%
} finally {
    try { if (rs != null) rs.close(); } catch (Exception e) {}
    try { if (stmt != null) stmt.close(); } catch (Exception e) {}
    try { if (con != null) con.close(); } catch (Exception e) {}
}
}
%>
            </tbody>
          </table>
        </div>
      </div>
    </div>

  </div>
</div>

<script>
function showTab(tabId) {
  document.getElementById("buildingTab").style.display = (tabId === "buildingTab") ? "block" : "none";
  document.getElementById("roomTab").style.display = (tabId === "roomTab") ? "block" : "none";
  var bb = document.getElementById("tabBtn-building");
  var rb = document.getElementById("tabBtn-room");
  bb.classList.remove("btn-primary","btn-secondary","active");
  rb.classList.remove("btn-primary","btn-secondary","active");
  if (tabId === "buildingTab") {
    bb.classList.add("btn-primary","active");
    rb.classList.add("btn-secondary");
  } else {
    bb.classList.add("btn-secondary");
    rb.classList.add("btn-primary","active");
  }
}
</script>

</body>
</html>