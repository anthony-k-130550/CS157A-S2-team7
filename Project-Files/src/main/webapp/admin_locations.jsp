<%@ page import="java.sql.*"%>
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
%>

<div class="page-shell">
  <div class="container">

    <div class="card" style="margin-bottom: 24px;">
      <h1 class="form-title" style="margin-bottom: 8px;">Manage Locations</h1>
      <p class="form-subtitle" style="margin-bottom: 0;">
        Add buildings, add rooms, and view all room locations from one page.
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

    </div>

    <div class="card">
      <h2 style="margin-top: 0; margin-bottom: 16px;">Room List</h2>

      <div style="overflow-x:auto;">
        <table class="table">
          <thead>
            <tr>
              <th>Building Name</th>
              <th>Room ID</th>
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
%>
            <tr>
              <td><%= rs.getString("BuildingName") %></td>
              <td><%= rs.getInt("RoomID") %></td>
            </tr>
<%
    }
} catch (Exception e) {
%>
            <tr>
              <td colspan="2">Error: <%= e.getMessage() %></td>
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