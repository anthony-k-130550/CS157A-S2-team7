<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
request.setCharacterEncoding("UTF-8");

String dbUrl = "jdbc:mysql://localhost:3306/project?autoReconnect=true&useSSL=false";
String dbUser = "root";
String dbPassword = "CS157ALG";

String successMessage = null;
String errorMessage = null;

if ("POST".equalsIgnoreCase(request.getMethod())) {
    String title = request.getParameter("title");
    String startTime = request.getParameter("startTime");
    String endTime = request.getParameter("endTime");
    String day = request.getParameter("day");
    String capacityStr = request.getParameter("capacity");
    String courseIDStr = request.getParameter("courseID");
    String roomLocation = request.getParameter("roomLocation");
    String description = request.getParameter("description");

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        int capacity = Integer.parseInt(capacityStr);
        int courseID = Integer.parseInt(courseIDStr);

        String[] roomParts = roomLocation.split("\\|\\|");
        int room = Integer.parseInt(roomParts[0]);
        String building = roomParts[1];

        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
        con.setAutoCommit(false);

        int userID = (Integer) session.getAttribute("userID");

        ps = con.prepareStatement("SELECT 1 FROM Disables WHERE StudentUserID = ?");
        ps.setInt(1, userID);
        rs = ps.executeQuery();

        if (rs.next()) {
            errorMessage = "Your account has been disabled. Please contact an administrator.";
        } else {
            if (rs != null) rs.close();
            if (ps != null) ps.close();

            ps = con.prepareStatement(
                "INSERT INTO StudySession (Title, StartTime, EndTime, Day, Capacity, Description) VALUES (?, ?, ?, ?, ?, ?)",
                Statement.RETURN_GENERATED_KEYS
            );

            ps.setString(1, title);
            ps.setString(2, startTime);
            ps.setString(3, endTime);
            ps.setString(4, day);
            ps.setInt(5, capacity);
            ps.setString(6, description);

            ps.executeUpdate();

            rs = ps.getGeneratedKeys();

            int sessionId = -1;
            if (rs.next()) {
                sessionId = rs.getInt(1);
            }

            if (rs != null) rs.close();
            if (ps != null) ps.close();

            ps = con.prepareStatement("INSERT INTO StudyingFor (SessionID, CourseID) VALUES (?, ?)");
            ps.setInt(1, sessionId);
            ps.setInt(2, courseID);
            ps.executeUpdate();

            if (ps != null) ps.close();

            ps = con.prepareStatement("INSERT INTO TakesPlaceIn (RoomID, BuildingName, SessionID) VALUES (?, ?, ?)");
            ps.setInt(1, room);
            ps.setString(2, building);
            ps.setInt(3, sessionId);
            ps.executeUpdate();

            if (ps != null) ps.close();

            ps = con.prepareStatement("INSERT INTO Creates (StudentUserID, SessionID, SuccessStatus) VALUES (?, ?, ?)");
            ps.setInt(1, userID);
            ps.setInt(2, sessionId);
            ps.setString(3, "successfully created");
            ps.executeUpdate();

            con.commit();

            response.sendRedirect("view_sessions.jsp");
            return;
        }

    } catch (Exception e) {
        if (con != null) {
            try { con.rollback(); } catch (Exception rollbackError) {}
        }
        errorMessage = "Something went wrong: " + e.getMessage();
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (ps != null) ps.close(); } catch (Exception e) {}
        try { if (con != null) con.close(); } catch (Exception e) {}
    }
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Study Session</title>
<link rel="stylesheet" href="css/global.css">
</head>

<body>

<%@ include file="navbar.jsp" %>

<div class="page-shell">
  <div class="container">
    <div class="card" style="margin-bottom: 24px;">
      <h1 class="form-title" style="margin-bottom: 8px;">Create Study Session</h1>
      <p class="form-subtitle" style="margin-bottom: 0;">
        Set up a new study session by choosing the time, location, course, and session details.
      </p>
    </div>

    <div class="card">

      <% if (successMessage != null) { %>
        <div style="margin-bottom:18px; padding:12px 14px; border-radius:14px; background:#f4f8f6; color:#0f766e; border:1px solid rgba(15,118,110,0.18);">
          <%= successMessage %>
        </div>
      <% } %>

      <% if (errorMessage != null) { %>
        <div style="margin-bottom:18px; padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);">
          <%= errorMessage %>
        </div>
      <% } %>

      <form method="post">
        <div class="grid grid-2">
          <div class="field">
            <label for="title">Title</label>
            <input type="text" id="title" name="title" required>
          </div>

          <div class="field">
            <label for="capacity">Capacity</label>
            <input type="number" id="capacity" name="capacity" min="1" max="30" required>
          </div>

          <div class="field">
            <label for="startTime">Start Time</label>
            <input type="time" id="startTime" name="startTime" min="08:00" max="22:00" required>
          </div>

          <div class="field">
            <label for="endTime">End Time</label>
            <input type="time" id="endTime" name="endTime" min="08:00" max="22:00" required>
          </div>

          <div class="field">
            <label for="day">Day</label>
            <input type="date" id="day" name="day" required>
          </div>

          <div class="field">
            <label for="courseID">Course</label>
            <select id="courseID" name="courseID" required>
              <option value="">Select a course</option>

<%
Connection optionCon = null;
PreparedStatement coursePs = null;
ResultSet courseRs = null;

try {
    Class.forName("com.mysql.jdbc.Driver");
    optionCon = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

    coursePs = optionCon.prepareStatement(
        "SELECT CourseID, Department, CourseNumber, CourseName FROM Course ORDER BY Department, CourseNumber"
    );

    courseRs = coursePs.executeQuery();

    while (courseRs.next()) {
        int courseID = courseRs.getInt("CourseID");
        String department = courseRs.getString("Department");
        int courseNumber = courseRs.getInt("CourseNumber");
        String courseName = courseRs.getString("CourseName");
%>
              <option value="<%= courseID %>">
                <%= department %> <%= courseNumber %> - <%= courseName %>
              </option>
<%
    }
} catch (Exception e) {
%>
              <option value="">Could not load courses</option>
<%
} finally {
    try { if (courseRs != null) courseRs.close(); } catch (Exception e) {}
    try { if (coursePs != null) coursePs.close(); } catch (Exception e) {}
}
%>
            </select>
          </div>

          <div class="field">
            <label for="roomLocation">Room / Building</label>
            <select id="roomLocation" name="roomLocation" required>
              <option value="">Select a room</option>

<%
PreparedStatement roomPs = null;
ResultSet roomRs = null;

try {
    if (optionCon == null || optionCon.isClosed()) {
        Class.forName("com.mysql.jdbc.Driver");
        optionCon = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
    }

    roomPs = optionCon.prepareStatement(
        "SELECT RoomID, BuildingName FROM Room ORDER BY BuildingName, RoomID"
    );

    roomRs = roomPs.executeQuery();

    while (roomRs.next()) {
        int roomID = roomRs.getInt("RoomID");
        String buildingName = roomRs.getString("BuildingName");
%>
              <option value="<%= roomID %>||<%= buildingName %>">
                <%= buildingName %> - Room <%= roomID %>
              </option>
<%
    }
} catch (Exception e) {
%>
              <option value="">Could not load rooms</option>
<%
} finally {
    try { if (roomRs != null) roomRs.close(); } catch (Exception e) {}
    try { if (roomPs != null) roomPs.close(); } catch (Exception e) {}
    try { if (optionCon != null) optionCon.close(); } catch (Exception e) {}
}
%>
            </select>
          </div>
        </div>

        <div class="field">
          <label for="description">Description</label>
          <input type="text" id="description" name="description">
        </div>

        <div class="form-actions" style="margin-top:18px;">
          <button type="submit" class="btn btn-primary">Create Session</button>
        </div>
      </form>

    </div>
  </div>
</div>

</body>
</html>