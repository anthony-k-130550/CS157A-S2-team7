<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Admin Dashboard</title>
  <link rel="stylesheet" href="css/global.css">
</head>
<body>

<%@ include file="navbar.jsp" %>

<%
int totalUsers = 0;
int totalStudents = 0;
int totalAdmins = 0;
int totalCourses = 0;
int totalRooms = 0;
int totalSessions = 0;
int disabledUsers = 0;
String dbError = null;

String user = "root";
String password = "CS157ALG";

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/project?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC",
        user,
        password
    );

    Statement stmt = con.createStatement();

    ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM Users");
    if (rs.next()) totalUsers = rs.getInt(1);
    rs.close();

    rs = stmt.executeQuery("SELECT COUNT(*) FROM Students");
    if (rs.next()) totalStudents = rs.getInt(1);
    rs.close();

    rs = stmt.executeQuery("SELECT COUNT(*) FROM Admins");
    if (rs.next()) totalAdmins = rs.getInt(1);
    rs.close();

    rs = stmt.executeQuery("SELECT COUNT(*) FROM Course");
    if (rs.next()) totalCourses = rs.getInt(1);
    rs.close();

    rs = stmt.executeQuery("SELECT COUNT(*) FROM Room");
    if (rs.next()) totalRooms = rs.getInt(1);
    rs.close();

    rs = stmt.executeQuery("SELECT COUNT(*) FROM StudySession");
    if (rs.next()) totalSessions = rs.getInt(1);
    rs.close();

    rs = stmt.executeQuery("SELECT COUNT(*) FROM Disables");
    if (rs.next()) disabledUsers = rs.getInt(1);
    rs.close();

    stmt.close();
    con.close();

} catch (Exception e) {
    dbError = e.getMessage();
}
%>

<div class="page-shell">
  <div class="container">

    <div class="card" style="margin-bottom: 24px;">
      <h1 class="form-title" style="margin-bottom: 10px;">Admin Dashboard</h1>
    </div>

    <% if (dbError != null) { %>
      <div class="card" style="margin-bottom: 24px;">
        <div style="padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);">
          Database error: <%= dbError %>
        </div>
      </div>
    <% } %>

    <div class="grid grid-3">
      <div class="panel">
        <h2 style="margin:0 0 8px; font-size:18px;">Total Users</h2>
        <div style="font-size:32px; font-weight:800;"><%= totalUsers %></div>
        <p class="muted" style="margin:8px 0 0;">All user accounts in the system.</p>
      </div>

      <div class="panel">
        <h2 style="margin:0 0 8px; font-size:18px;">Students</h2>
        <div style="font-size:32px; font-weight:800;"><%= totalStudents %></div>
        <p class="muted" style="margin:8px 0 0;">Student accounts available to create and join sessions.</p>
      </div>

      <div class="panel">
        <h2 style="margin:0 0 8px; font-size:18px;">Admins</h2>
        <div style="font-size:32px; font-weight:800;"><%= totalAdmins %></div>
        <p class="muted" style="margin:8px 0 0;">Administrative accounts managing the platform.</p>
      </div>

      <div class="panel">
        <h2 style="margin:0 0 8px; font-size:18px;">Courses</h2>
        <div style="font-size:32px; font-weight:800;"><%= totalCourses %></div>
        <p class="muted" style="margin:8px 0 0;">Courses linked to study sessions.</p>
      </div>

      <div class="panel">
        <h2 style="margin:0 0 8px; font-size:18px;">Rooms</h2>
        <div style="font-size:32px; font-weight:800;"><%= totalRooms %></div>
        <p class="muted" style="margin:8px 0 0;">Available study locations in campus buildings.</p>
      </div>

      <div class="panel">
        <h2 style="margin:0 0 8px; font-size:18px;">Sessions</h2>
        <div style="font-size:32px; font-weight:800;"><%= totalSessions %></div>
        <p class="muted" style="margin:8px 0 0;">Study sessions currently stored in the system.</p>
      </div>
    </div>

    <div class="grid grid-2" style="margin-top: 24px;">
      <div class="card">
        <h2 style="margin:0 0 12px; font-size:22px;">Quick Actions</h2>
        <div style="display:grid; gap:12px;">
          <a class="btn btn-secondary" href="search_user.jsp">Search Users</a>
          <a class="btn btn-secondary" href="admin_add_buildings.jsp">Add Building</a>
          <a class="btn btn-secondary" href="admin_add_room.jsp">Add Room</a>
          <a class="btn btn-secondary" href="admin_add_course.jsp">Add Course</a>
        </div>
      </div>

      <div class="card">
        <h2 style="margin:0 0 12px; font-size:22px;">System Status</h2>
        <p style="margin:0 0 10px;"><strong>Disabled Users:</strong> <%= disabledUsers %></p>
        <p style="margin:0 0 10px;"><strong>Total Sessions:</strong> <%= totalSessions %></p>

      </div>
    </div>

  </div>
</div>

</body>
</html>