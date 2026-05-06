<%@ page import="java.sql.*"%>
<%
String role = (String) session.getAttribute("role");
if (!"admin".equals(role)) {
    response.sendRedirect("login.jsp");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Manage Locations</title>
  <link rel="stylesheet" href="css/global.css">
</head>
<body>

<%@ include file="navbar.jsp" %>

<%
String user = "root";
String password = "CS157ALG";

String successMessage = null;
String errorMessage = null;

String action = request.getParameter("action");

/* ===== ADD BUILDING ===== */
if ("addBuilding".equals(action)) {
    String building = request.getParameter("Building");

    if (building != null && !building.trim().isEmpty()) {
        Connection con = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/project?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC",
                user,
                password
            );

            ps = con.prepareStatement("INSERT INTO Building (BuildingName) VALUES (?)");
            ps.setString(1, building.trim());

            int result = ps.executeUpdate();

            if (result > 0) {
                successMessage = "Successfully added building: " + building;
            } else {
                errorMessage = "Failed to add building.";
            }

        } catch (Exception e) {
            errorMessage = e.getMessage();
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}

/* ===== ADD ROOM ===== */
if ("addRoom".equals(action)) {
    String building = request.getParameter("RoomBuilding");
    String room = request.getParameter("Room");

    if (building != null && room != null && !building.trim().isEmpty() && !room.trim().isEmpty()) {
        Connection con = null;
        PreparedStatement ps = null;

        try {
            int roomID = Integer.parseInt(room);

            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/project?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC",
                user,
                password
            );

            ps = con.prepareStatement("INSERT INTO Room (BuildingName, RoomID) VALUES (?, ?)");
            ps.setString(1, building.trim());
            ps.setInt(2, roomID);

            int result = ps.executeUpdate();

            if (result > 0) {
                successMessage = "Successfully added room " + roomID + " in " + building;
            } else {
                errorMessage = "Failed to add room.";
            }

        } catch (NumberFormatException e) {
            errorMessage = "Room ID must be a valid number.";
        } catch (Exception e) {
            errorMessage = e.getMessage();
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}

/* ===== DELETE BUILDING ===== */
if ("deleteBuilding".equals(action)) {
    String building = request.getParameter("Building");

    if (building != null && !building.trim().isEmpty()) {
        Connection con = null;
        PreparedStatement check = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/project?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC",
                user,
                password
            );

            check = con.prepareStatement("SELECT COUNT(*) FROM Room WHERE BuildingName = ?");
            check.setString(1, building.trim());
            rs = check.executeQuery();
            int roomCount = 0;
            if (rs.next()) roomCount = rs.getInt(1);

            if (roomCount > 0) {
                errorMessage = "Cannot delete '" + building + "' because it still has " + roomCount + " room(s). Delete its rooms first.";
            } else {
                ps = con.prepareStatement("DELETE FROM Building WHERE BuildingName = ?");
                ps.setString(1, building.trim());
                int result = ps.executeUpdate();

                if (result > 0) {
                    successMessage = "Successfully deleted building: " + building;
                } else {
                    errorMessage = "Building not found: " + building;
                }
            }

        } catch (Exception e) {
            errorMessage = e.getMessage();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (check != null) check.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}

/* ===== DELETE ROOM ===== */
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
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/project?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC",
                user,
                password
            );

            check = con.prepareStatement("SELECT COUNT(*) FROM TakesPlaceIn WHERE RoomID = ? AND BuildingName = ?");
            check.setInt(1, roomID);
            check.setString(2, building.trim());
            rs = check.executeQuery();
            int sessionCount = 0;
            if (rs.next()) sessionCount = rs.getInt(1);

            if (sessionCount > 0) {
                errorMessage = "Cannot delete room " + roomID + " in " + building + " because " + sessionCount + " session(s) still use it.";
            } else {
                ps = con.prepareStatement("DELETE FROM Room WHERE RoomID = ? AND BuildingName = ?");
                ps.setInt(1, roomID);
                ps.setString(2, building.trim());
                int result = ps.executeUpdate();

                if (result > 0) {
                    successMessage = "Successfully deleted room " + roomID + " in " + building;
                } else {
                    errorMessage = "Room not found: " + roomID + " in " + building;
                }
            }

        } catch (NumberFormatException e) {
            errorMessage = "Room ID must be a valid number.";
        } catch (Exception e) {
            errorMessage = e.getMessage();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (check != null) check.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}

/* ===== UPDATE BUILDING (rename) ===== */
if ("updateBuilding".equals(action)) {
    String oldName = request.getParameter("OldBuilding");
    String newName = request.getParameter("NewBuilding");

    if (oldName != null && newName != null && !oldName.trim().isEmpty() && !newName.trim().isEmpty()) {
        Connection con = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;
        PreparedStatement ps3 = null;
        PreparedStatement ps4 = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/project?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC",
                user,
                password
            );
            con.setAutoCommit(false);

            ps1 = con.prepareStatement("INSERT INTO Building (BuildingName) VALUES (?)");
            ps1.setString(1, newName.trim());
            ps1.executeUpdate();

            ps2 = con.prepareStatement("UPDATE TakesPlaceIn SET BuildingName = ? WHERE BuildingName = ?");
            ps2.setString(1, newName.trim());
            ps2.setString(2, oldName.trim());
            ps2.executeUpdate();

            ps3 = con.prepareStatement("UPDATE Room SET BuildingName = ? WHERE BuildingName = ?");
            ps3.setString(1, newName.trim());
            ps3.setString(2, oldName.trim());
            ps3.executeUpdate();

            ps4 = con.prepareStatement("DELETE FROM Building WHERE BuildingName = ?");
            ps4.setString(1, oldName.trim());
            int result = ps4.executeUpdate();

            if (result > 0) {
                con.commit();
                successMessage = "Renamed building '" + oldName + "' to '" + newName + "'.";
            } else {
                con.rollback();
                errorMessage = "Building not found: " + oldName;
            }

        } catch (Exception e) {
            try { if (con != null) con.rollback(); } catch (Exception ex) {}
            errorMessage = e.getMessage();
        } finally {
            try { if (ps1 != null) ps1.close(); } catch (Exception e) {}
            try { if (ps2 != null) ps2.close(); } catch (Exception e) {}
            try { if (ps3 != null) ps3.close(); } catch (Exception e) {}
            try { if (ps4 != null) ps4.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}

/* ===== UPDATE ROOM (change Room ID and/or Building) ===== */
if ("updateRoom".equals(action)) {
    String oldBuilding = request.getParameter("OldBuilding");
    String oldRoom = request.getParameter("OldRoom");
    String newBuilding = request.getParameter("NewBuilding");
    String newRoom = request.getParameter("NewRoom");

    if (oldBuilding != null && oldRoom != null && newBuilding != null && newRoom != null
        && !oldBuilding.trim().isEmpty() && !oldRoom.trim().isEmpty()
        && !newBuilding.trim().isEmpty() && !newRoom.trim().isEmpty()) {

        Connection con = null;
        PreparedStatement check = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;
        PreparedStatement ps3 = null;
        ResultSet rs = null;

        try {
            int oldRoomID = Integer.parseInt(oldRoom);
            int newRoomID = Integer.parseInt(newRoom);

            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/project?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC",
                user,
                password
            );
            con.setAutoCommit(false);

            check = con.prepareStatement("SELECT COUNT(*) FROM TakesPlaceIn WHERE RoomID = ? AND BuildingName = ?");
            check.setInt(1, oldRoomID);
            check.setString(2, oldBuilding.trim());
            rs = check.executeQuery();
            int sessionCount = 0;
            if (rs.next()) sessionCount = rs.getInt(1);

            if (sessionCount > 0) {
                errorMessage = "Cannot update room " + oldRoomID + " in " + oldBuilding + " because " + sessionCount + " session(s) still use it.";
                con.rollback();
            } else {
                ps1 = con.prepareStatement("INSERT INTO Room (BuildingName, RoomID) VALUES (?, ?)");
                ps1.setString(1, newBuilding.trim());
                ps1.setInt(2, newRoomID);
                ps1.executeUpdate();

                ps2 = con.prepareStatement("DELETE FROM Room WHERE RoomID = ? AND BuildingName = ?");
                ps2.setInt(1, oldRoomID);
                ps2.setString(2, oldBuilding.trim());
                int result = ps2.executeUpdate();

                if (result > 0) {
                    con.commit();
                    successMessage = "Updated room " + oldRoomID + " in " + oldBuilding
                        + " -> room " + newRoomID + " in " + newBuilding + ".";
                } else {
                    con.rollback();
                    errorMessage = "Original room not found.";
                }
            }

        } catch (NumberFormatException e) {
            errorMessage = "Room IDs must be valid numbers.";
            try { if (con != null) con.rollback(); } catch (Exception ex) {}
        } catch (Exception e) {
            try { if (con != null) con.rollback(); } catch (Exception ex) {}
            errorMessage = e.getMessage();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (check != null) check.close(); } catch (Exception e) {}
            try { if (ps1 != null) ps1.close(); } catch (Exception e) {}
            try { if (ps2 != null) ps2.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}
%>

<div class="page-shell">
  <div class="container">

    <div class="card" style="margin-bottom: 24px;">
      <h1 class="form-title" style="margin-bottom: 8px;">Manage Locations</h1>
      <p class="form-subtitle" style="margin-bottom: 0;">
        Add, update, or delete buildings and rooms.
      </p>
    </div>

    <% if (successMessage != null) { %>
      <div class="card" style="margin-bottom: 24px;">
        <div style="padding:12px 14px; border-radius:14px; background:#f4f8f6; color:#0f766e; border:1px solid rgba(15,118,110,0.18);">
          <%= successMessage %>
        </div>
      </div>
    <% } %>

    <% if (errorMessage != null) { %>
      <div class="card" style="margin-bottom: 24px;">
        <div style="padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);">
          Error: <%= errorMessage %>
        </div>
      </div>
    <% } %>

    <div class="grid grid-2" style="margin-bottom: 24px;">

      <div class="form-card" style="margin: 0; width: 100%;">
        <h2 style="margin-top: 0;">Add Building</h2>
        <form method="post">
          <input type="hidden" name="action" value="addBuilding">

          <div class="field">
            <label for="Building">Building Name</label>
            <input type="text" id="Building" name="Building" required>
          </div>

          <div style="margin-top: 18px;">
            <button type="submit" class="btn btn-primary">Add Building</button>
          </div>
        </form>
      </div>

      <div class="form-card" style="margin: 0; width: 100%;">
        <h2 style="margin-top: 0;">Add Room</h2>
        <form method="post">
          <input type="hidden" name="action" value="addRoom">

          <div class="field">
            <label for="RoomBuilding">Building Name</label>
            <input type="text" id="RoomBuilding" name="RoomBuilding" required>
          </div>

          <div class="field">
            <label for="Room">Room ID</label>
            <input type="number" id="Room" name="Room" required>
          </div>

          <div style="margin-top: 18px;">
            <button type="submit" class="btn btn-primary">Add Room</button>
          </div>
        </form>
      </div>

      <div class="form-card" style="margin: 0; width: 100%;">
        <h2 style="margin-top: 0;">Rename Building</h2>
        <form method="post">
          <input type="hidden" name="action" value="updateBuilding">

          <div class="field">
            <label for="OldBuilding">Current Building Name</label>
            <input type="text" id="OldBuilding" name="OldBuilding" required>
          </div>

          <div class="field">
            <label for="NewBuilding">New Building Name</label>
            <input type="text" id="NewBuilding" name="NewBuilding" required>
          </div>

          <div style="margin-top: 18px;">
            <button type="submit" class="btn btn-primary">Rename Building</button>
          </div>
        </form>
      </div>

      <div class="form-card" style="margin: 0; width: 100%;">
        <h2 style="margin-top: 0;">Update Room</h2>
        <form method="post">
          <input type="hidden" name="action" value="updateRoom">

          <div class="field">
            <label for="UpdOldBuilding">Current Building</label>
            <input type="text" id="UpdOldBuilding" name="OldBuilding" required>
          </div>

          <div class="field">
            <label for="UpdOldRoom">Current Room ID</label>
            <input type="number" id="UpdOldRoom" name="OldRoom" required>
          </div>

          <div class="field">
            <label for="UpdNewBuilding">New Building</label>
            <input type="text" id="UpdNewBuilding" name="NewBuilding" required>
          </div>

          <div class="field">
            <label for="UpdNewRoom">New Room ID</label>
            <input type="number" id="UpdNewRoom" name="NewRoom" required>
          </div>

          <div style="margin-top: 18px;">
            <button type="submit" class="btn btn-primary">Update Room</button>
          </div>
        </form>
      </div>

      <div class="form-card" style="margin: 0; width: 100%;">
        <h2 style="margin-top: 0;">Delete Building</h2>
        <form method="post" onsubmit="return confirm('Delete this building? This cannot be undone.');">
          <input type="hidden" name="action" value="deleteBuilding">

          <div class="field">
            <label for="DelBuilding">Building Name</label>
            <input type="text" id="DelBuilding" name="Building" required>
          </div>

          <div style="margin-top: 18px;">
            <button type="submit" class="btn btn-primary">Delete Building</button>
          </div>
        </form>
      </div>

      <div class="form-card" style="margin: 0; width: 100%;">
        <h2 style="margin-top: 0;">Delete Room</h2>
        <form method="post" onsubmit="return confirm('Delete this room? This cannot be undone.');">
          <input type="hidden" name="action" value="deleteRoom">

          <div class="field">
            <label for="DelRoomBuilding">Building Name</label>
            <input type="text" id="DelRoomBuilding" name="RoomBuilding" required>
          </div>

          <div class="field">
            <label for="DelRoom">Room ID</label>
            <input type="number" id="DelRoom" name="Room" required>
          </div>

          <div style="margin-top: 18px;">
            <button type="submit" class="btn btn-primary">Delete Room</button>
          </div>
        </form>
      </div>

    </div>

    <div class="card">
      <h2 style="margin-top: 0; margin-bottom: 16px;">Room List</h2>

      <div style="overflow-x:auto;">
        <table class="table">
          <thead>
            <tr>
              <th>Building Name</th>
              <th>Room ID</th>
              <th>Action</th>
            </tr>
          </thead>
          <tbody>
<%
Connection con = null;
Statement stmt = null;
ResultSet rs = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/project?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC",
        user,
        password
    );

    stmt = con.createStatement();
    rs = stmt.executeQuery("SELECT * FROM Room ORDER BY BuildingName, RoomID");

    while (rs.next()) {
        String b = rs.getString("BuildingName");
        int r = rs.getInt("RoomID");
%>
            <tr>
              <td><%= b %></td>
              <td><%= r %></td>
              <td>
                <form method="post" style="display:inline;" onsubmit="return confirm('Delete room <%= r %> in <%= b %>?');">
                  <input type="hidden" name="action" value="deleteRoom">
                  <input type="hidden" name="RoomBuilding" value="<%= b %>">
                  <input type="hidden" name="Room" value="<%= r %>">
                  <button type="submit" class="btn btn-secondary">Delete</button>
                </form>
              </td>
            </tr>
<%
    }
} catch (Exception e) {
%>
            <tr>
              <td colspan="3">Error: <%= e.getMessage() %></td>
            </tr>
<%
} finally {
    try { if (rs != null) rs.close(); } catch (Exception e) {}
    try { if (stmt != null) stmt.close(); } catch (Exception e) {}
    try { if (con != null) con.close(); } catch (Exception e) {}
}
%>
          </tbody>
        </table>
      </div>
    </div>

  </div>
</div>

</body>
</html>
