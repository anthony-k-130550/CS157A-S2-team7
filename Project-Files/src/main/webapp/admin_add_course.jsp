<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Admin Add Course</title>
  <link rel="stylesheet" href="css/global.css">
</head>
<body>

<%@ include file="navbar.jsp" %>

<div class="page-shell">
  <div class="container">

    <div class="card" style="margin-bottom: 24px;">
      <h1 class="form-title" style="margin-bottom: 8px;">Add Course</h1>
      <p class="form-subtitle" style="margin-bottom: 0;">
        Add a new course so study sessions can be linked to it.
      </p>
    </div>

    
    <div class="form-card">
      <form method="post">

        <div class="field">
          <label for="Department">Department</label>
          <input type="text" id="Department" name="Department" required>
        </div>

        <div class="field">
          <label for="CourseNumber">Course Number</label>
          <input type="number" id="CourseNumber" name="CourseNumber" required>
        </div>

        <div class="field">
          <label for="CourseName">Course Name</label>
          <input type="text" id="CourseName" name="CourseName" required>
        </div>

        <div class="form-actions">
          <button type="submit" class="btn btn-primary">Add Course</button>
        </div>

      </form>

      <%
        String department = request.getParameter("Department");
        String courseNumberStr = request.getParameter("CourseNumber");
        String courseName = request.getParameter("CourseName");

        if (department != null && courseNumberStr != null && courseName != null) {

          String user = "root";
          String password = "CS157ALG";

          Connection con = null;
          PreparedStatement pstmt = null;

          try {
            int courseNumber = Integer.parseInt(courseNumberStr);

            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection(
              "jdbc:mysql://localhost:3306/project?autoReconnect=true&useSSL=false",
              user,
              password
            );

            con.setAutoCommit(false);

            String insert = "INSERT INTO Course (Department, CourseNumber, CourseName) VALUES (?, ?, ?)";
            pstmt = con.prepareStatement(insert);

            pstmt.setString(1, department);
            pstmt.setInt(2, courseNumber);
            pstmt.setString(3, courseName);

            int result = pstmt.executeUpdate();

            if (result > 0) {
              con.commit();
      %>
              <div style="margin-top:18px; padding:12px 14px; border-radius:14px;
                          background:#f4f8f6; color:#0f766e;
                          border:1px solid rgba(15,118,110,0.18);">
                Successfully added <strong><%= courseName %></strong> to the Course table.
              </div>
      <%
            } else {
              con.rollback();
      %>
              <div style="margin-top:18px; padding:12px 14px; border-radius:14px;
                          background:#fef3f2; color:#b42318;
                          border:1px solid rgba(180,35,24,0.18);">
                Failed to add course.
              </div>
      <%
            }

          } catch (NumberFormatException e) {
      %>
            <div style="margin-top:18px; padding:12px 14px; border-radius:14px;
                        background:#fef3f2; color:#b42318;
                        border:1px solid rgba(180,35,24,0.18);">
              Course Number must be a valid integer.
            </div>
      <%
          } catch (SQLException e) {
            if (con != null) {
              try { con.rollback(); } catch (SQLException ex) {}
            }
      %>
            <div style="margin-top:18px; padding:12px 14px; border-radius:14px;
                        background:#fef3f2; color:#b42318;
                        border:1px solid rgba(180,35,24,0.18);">
              SQLException: <%= e.getMessage() %>
            </div>
      <%
          } catch (ClassNotFoundException e) {
      %>
            <div style="margin-top:18px; padding:12px 14px; border-radius:14px;
                        background:#fef3f2; color:#b42318;
                        border:1px solid rgba(180,35,24,0.18);">
              JDBC Driver not found.
            </div>
      <%
          } finally {
            try { if (pstmt != null) pstmt.close(); } catch (SQLException e) {}
            try { if (con != null) con.close(); } catch (SQLException e) {}
          }
        }
      %>

    </div>
  </div>
</div>

</body>
</html>