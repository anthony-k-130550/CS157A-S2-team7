<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>View Available Courses</title>
  <link rel="stylesheet" href="css/global.css">
</head>
<body>

<%@ include file="navbar.jsp" %>

<div class="page-shell">
  <div class="container">

    <div class="card" style="margin-bottom: 24px;">
      <h1 class="form-title" style="margin-bottom: 8px;">Course List</h1>
      <p class="form-subtitle" style="margin-bottom: 0;">
        Browse all available courses in the system. These courses can be used when creating study sessions.
      </p>
    </div>

    <div class="card">
      <div style="overflow-x:auto;">
        <table class="table">
          <thead>
            <tr>
              <th>Course ID</th>
              <th>Department</th>
              <th>Course Number</th>
              <th>Course Name</th>
            </tr>
          </thead>
          <tbody>

    <%
        String user = "root";
        String password = "CS157ALG";

        try {
            java.sql.Connection con;
            Class.forName("com.mysql.jdbc.Driver");

            con = DriverManager.getConnection(
              "jdbc:mysql://localhost:3306/project?autoReconnect=true&useSSL=false",
              user,
              password
            );

            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM course");

            while (rs.next()) {
               out.println("<tr>");
               out.println("<td>" + rs.getInt(1) + "</td>");
               out.println("<td>" + rs.getString(2) + "</td>");
               out.println("<td>" + rs.getString(3) + "</td>");
               out.println("<td>" + rs.getString(4) + "</td>");
               out.println("</tr>");
            }

            rs.close();
            stmt.close();
            con.close();

        } catch(SQLException e) {
            out.println("<tr><td colspan='4'><div style='padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);'>SQLException caught: " + e.getMessage() + "</div></td></tr>");
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