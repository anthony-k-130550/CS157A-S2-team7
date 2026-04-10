<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.ResultSet" %>

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
            <label for="course">Course</label>
            <input type="text" id="course" name="course" required>
          </div>

          <div class="field">
            <label for="building">Building</label>
            <input type="text" id="building" name="building" required>
          </div>

          <div class="field">
            <label for="room">Room</label>
            <input type="number" id="room" name="room" required>
          </div>
        </div>

        <div class="field">
          <label for="description">Description</label>
          <input type="text" id="description" name="description">
        </div>

        <div class="form-actions">
          <button type="submit" class="btn btn-primary">Create Session</button>
        </div>
      </form>

<%
if ("POST".equalsIgnoreCase(request.getMethod())) {

    String title = request.getParameter("title");
    String startTime = request.getParameter("startTime");
    String endTime = request.getParameter("endTime");
    String day = request.getParameter("day");
    int capacity = Integer.parseInt(request.getParameter("capacity"));
    int room = Integer.parseInt(request.getParameter("room"));
    String building = request.getParameter("building");
    String course = request.getParameter("course");
    String description = request.getParameter("description");

    String db = "project";
    String user;
    user = "root";
    String password = "CS157ALG";
    java.sql.Connection con = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project?autoReconnect=true&useSSL=false", user, password);

        int userID = (Integer) session.getAttribute("userID");

        String disableQuery = "SELECT * FROM disables WHERE StudentUserID=" + userID;
        Statement disableStmt = con.createStatement();
        ResultSet disableRS = disableStmt.executeQuery(disableQuery);

        if (!disableRS.next()) {
            String sql = "SELECT 1 FROM room WHERE RoomID = ? AND BuildingName = ? LIMIT 1";
            String sql2 = "SELECT 1 FROM course WHERE CourseName = ? LIMIT 1";

            PreparedStatement ps = con.prepareStatement(sql);
            PreparedStatement ps2 = con.prepareStatement(sql2);

            ps.setInt(1, room);
            ps.setString(2, building);
            ps2.setString(1, course);

            ResultSet rs = ps.executeQuery();
            ResultSet rs2 = ps2.executeQuery();

            boolean roomExist = rs.next();
            boolean courseExist = rs2.next();

            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (rs2 != null) rs2.close();
            if (ps2 != null) ps2.close();

            if (roomExist && courseExist) {

                sql = "INSERT INTO StudySession (Title, StartTime, EndTime, Day, Capacity, Description) VALUES (?, ?, ?, ?, ?, ?)";
                ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

                ps.setString(1, title);
                ps.setString(2, startTime);
                ps.setString(3, endTime);
                ps.setString(4, day);
                ps.setInt(5, capacity);
                ps.setString(6, description);

                int rows = ps.executeUpdate();

                rs = ps.getGeneratedKeys();

                int sessionId = -1;

                if (rs.next()) {
                    sessionId = rs.getInt(1);
                }

                if (rs != null) rs.close();
                if (ps != null) ps.close();

                if (rows > 0) {
                    out.println("<div style='margin-top:18px; padding:12px 14px; border-radius:14px; background:#f4f8f6; color:#0f766e; border:1px solid rgba(15,118,110,0.18);'>Session inserted successfully.</div>");
                } else {
                    out.println("<div style='margin-top:18px; padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);'>Insert failed.</div>");
                }

                sql = "SELECT CourseID FROM course WHERE CourseName = ?";
                ps = con.prepareStatement(sql);
                ps.setString(1, course);
                rs = ps.executeQuery();

                int courseID = -1;

                if (rs.next()) {
                    courseID = rs.getInt("CourseID");
                }

                if (rs != null) rs.close();
                if (ps != null) ps.close();

                sql = "INSERT INTO studyingfor (SessionID, CourseID) VALUES (?, ?)";
                ps = con.prepareStatement(sql);
                ps.setInt(1, sessionId);
                ps.setInt(2, courseID);
                rows = ps.executeUpdate();

                if (rows > 0) {
                    out.println("<div style='margin-top:12px; padding:12px 14px; border-radius:14px; background:#f4f8f6; color:#0f766e; border:1px solid rgba(15,118,110,0.18);'>Course link added successfully.</div>");
                } else {
                    out.println("<div style='margin-top:12px; padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);'>Failed to update studyingfor.</div>");
                }

                if (rs != null) rs.close();
                if (ps != null) ps.close();

                sql = "INSERT INTO takesplacein (RoomID, BuildingName, SessionID) VALUES (?, ?, ?)";
                ps = con.prepareStatement(sql);
                ps.setInt(1, room);
                ps.setString(2, building);
                ps.setInt(3, sessionId);

                rows = ps.executeUpdate();

                if (rows > 0) {
                    out.println("<div style='margin-top:12px; padding:12px 14px; border-radius:14px; background:#f4f8f6; color:#0f766e; border:1px solid rgba(15,118,110,0.18);'>Location added successfully.</div>");
                } else {
                    out.println("<div style='margin-top:12px; padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);'>Failed to update takesplacein.</div>");
                }

                if (rs != null) rs.close();
                if (ps != null) ps.close();

                sql = "INSERT INTO creates (StudentUserID, SessionID, SuccessStatus) VALUES (?, ?, ?)";
                ps = con.prepareStatement(sql);
                ps.setInt(1, userID);
                ps.setInt(2, sessionId);
                ps.setString(3, "successfully created");

                rows = ps.executeUpdate();

                if (rows > 0) {
                    out.println("<div style='margin-top:12px; padding:12px 14px; border-radius:14px; background:#f4f8f6; color:#0f766e; border:1px solid rgba(15,118,110,0.18);'>Creator record saved successfully.</div>");
                } else {
                    out.println("<div style='margin-top:12px; padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);'>Failed to update creates table.</div>");
                }

                if (rs != null) rs.close();
                if (ps != null) ps.close();

                response.sendRedirect("view_sessions.jsp");

            } else if (!roomExist || !courseExist) {
                if (!roomExist) {
                    out.println("<div style='margin-top:18px; padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);'>Entered room and building do not exist.</div>");
                }
                if (!courseExist) {
                    out.println("<div style='margin-top:12px; padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);'>Entered course does not exist.</div>");
                }
                out.println("<div style='margin-top:12px; padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);'>Insert failed.</div>");
            }
        } else {
            out.println("<div style='margin-top:18px; padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);'>Your account has been disabled. Please contact an administrator.</div>");
        }

    } catch(SQLException e) {
        out.println("<div style='margin-top:18px; padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);'>SQLException caught: " + e.getMessage() + "</div>");
        e.printStackTrace();
    } finally {
        if (con != null) {
            try { con.close(); } catch (Exception e) {}
        }
    }
}
%>

    </div>
  </div>
</div>

</body>
</html>