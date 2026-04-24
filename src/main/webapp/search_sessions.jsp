<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Search Study Sessions</title>
  <link rel="stylesheet" href="css/global.css">
</head>
<body>

<%@ include file="navbar.jsp" %>

<div class="page-shell">
  <div class="container">
    <div class="card" style="margin-bottom: 24px;">
      <h1 class="form-title" style="margin-bottom: 8px;">Search Study Sessions</h1>
      <p class="form-subtitle" style="margin-bottom: 0;">
        Filter sessions by department, course number, date, building, or room to find the best study group.
      </p>
    </div>

    <div class="card" style="margin-bottom: 24px;">
      <form method="post">
        <div class="grid grid-2">
          <div class="field">
            <label for="department">Department</label>
            <input type="text" id="department" name="department">
          </div>

          <div class="field">
            <label for="classNumber">Class Number</label>
            <input type="number" id="classNumber" name="classNumber" min="1">
          </div>

          <div class="field">
            <label for="day">Day</label>
            <input type="date" id="day" name="day">
          </div>

          <div class="field">
            <label for="buildingName">Building Name</label>
            <input type="text" id="buildingName" name="buildingName">
          </div>

          <div class="field">
            <label for="roomID">Room ID</label>
            <input type="number" id="roomID" name="roomID">
          </div>
        </div>

        <div class="form-actions">
          <button type="submit" class="btn btn-primary">Search Session</button>
        </div>
      </form>
    </div>

<%
    String permission = (String) session.getAttribute("role");
    String dept = request.getParameter("department");
    String classNum = request.getParameter("classNumber");
    String day = request.getParameter("day");
    String building = request.getParameter("buildingName");
    String room = request.getParameter("roomID");

    StringBuilder query = new StringBuilder();
    query.append("SELECT * FROM studysession WHERE SessionID NOT IN (SELECT SessionID FROM deletes) ");

    if (!(dept == null || dept.isBlank())) {
        query.append("AND SessionID IN (SELECT SessionID FROM studyingfor WHERE CourseID IN (SELECT CourseID FROM course WHERE Department LIKE '%"
            + dept +
            "%')) ");
    }

    if (!(classNum == null || classNum.isBlank())) {
        query.append("AND SessionID IN (SELECT SessionID FROM studyingfor WHERE CourseID IN (SELECT CourseID FROM course WHERE CourseNumber = '"
            + classNum +
            "')) ");
    }

    if (!(day == null || day.isBlank())) {
        query.append("AND Day = '" + day + "' ");
    }

    if (!(building == null || building.isBlank())) {
        query.append("AND SessionID in (SELECT SessionID FROM takesplacein WHERE BuildingName LIKE '%"
            + building +
            "%') AND EXISTS (SELECT * FROM building WHERE buildingName LIKE '%" + building + "%') ");
    }

    if (!(room == null || room.isBlank())) {
        query.append("AND SessionID in (SELECT SessionID FROM takesplacein WHERE RoomID = '"
            + room +
            "') AND EXISTS (SELECT * FROM room WHERE RoomID =" + room + ") ");
    }

    String queryString = query.toString();

    String db = "project";
    String user;
    user = "root";
    String password = "CS157ALG";

    try {
        java.sql.Connection con;
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project?autoReconnect=true&useSSL=false", user, password);

        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery(queryString);

        out.println("<div class='card'>");
        out.println("<h2 style='margin:0 0 16px; font-size:24px; letter-spacing:-0.02em;'>Available Study Sessions</h2>");
        out.println("<div style='overflow-x:auto;'>");
        out.println("<table class='table'>");
        out.println("<thead>");
        out.println("<tr>");
        out.println("<th>Session ID</th>");
        out.println("<th>Session Name</th>");
        out.println("<th>Start Time</th>");
        out.println("<th>End Time</th>");
        out.println("<th>Date</th>");
        out.println("<th>Capacity</th>");
        out.println("<th>Description</th>");
        out.println("<th>Details</th>");
        out.println("</tr>");
        out.println("</thead>");
        out.println("<tbody>");

        while (rs.next()) {
            out.println("<tr>");
            out.println("<td>" + rs.getInt(1) + "</td>");
            out.println("<td>" + rs.getString(2) + "</td>");
            out.println("<td>" + rs.getTime(3) + "</td>");
            out.println("<td>" + rs.getTime(4) + "</td>");
            out.println("<td>" + rs.getDate(5) + "</td>");
            out.println("<td>" + rs.getInt(6) + "</td>");
            out.println("<td>" + rs.getString(7) + "</td>");
            out.println("<td><button type='button' class='btn btn-secondary' onclick=\"window.location.href='individual_session_view.jsp?sessionID=" + rs.getInt(1) + "'\">Details</button></td>");
            out.println("</tr>");
        }

        out.println("</tbody>");
        out.println("</table>");
        out.println("</div>");
        out.println("</div>");

        rs.close();
        stmt.close();
        con.close();
    } catch(SQLException e) {
        out.println("<div class='container' style='margin-top:16px;'><div style='padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);'>SQLException caught: " + e.getMessage() + "</div></div>");
    }
%>

  </div>
</div>

</body>
</html>