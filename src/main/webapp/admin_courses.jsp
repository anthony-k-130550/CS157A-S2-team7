<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Manage Courses</title>
  <link rel="stylesheet" href="css/global.css">
</head>
<body>

<%@ include file="navbar.jsp" %>

<%
String user = "root";
String password = "CS157ALG";

String department = request.getParameter("Department");
String courseNumberStr = request.getParameter("CourseNumber");
String courseName = request.getParameter("CourseName");

String successMessage = null;
String errorMessage = null;

if (department != null && courseNumberStr != null && courseName != null) {
    Connection con = null;
    PreparedStatement pstmt = null;

    try {
        int courseNumber = Integer.parseInt(courseNumberStr);

        Class.forName("com.mysql.cj.jdbc.Driver");

        con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/project?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC",
            user,
            password
        );

        String insert = "INSERT INTO Course (Department, CourseNumber, CourseName) VALUES (?, ?, ?)";
        pstmt = con.prepareStatement(insert);

        pstmt.setString(1, department);
        pstmt.setInt(2, courseNumber);
        pstmt.setString(3, courseName);

        int result = pstmt.executeUpdate();

        if (result > 0) {
            successMessage = "Successfully added " + courseName + ".";
        } else {
            errorMessage = "Failed to add course.";
        }

    } catch (NumberFormatException e) {
        errorMessage = "Course Number must be a valid integer.";
    } catch (Exception e) {
        errorMessage = e.getMessage();
    } finally {
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
        try { if (con != null) con.close(); } catch (Exception e) {}
    }
}
%>

<div class="page-shell">
  <div class="container">

    <div class="card" style="margin-bottom: 24px;">
      <h1 class="form-title" style="margin-bottom: 8px;">Manage Courses</h1>
      <p class="form-subtitle" style="margin-bottom: 0;">
        View all courses and add new ones from one page.
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

    <div class="grid grid-2">

      <div class="form-card" style="margin: 0; width: 100%;">
        <h2 style="margin-top: 0;">Add Course</h2>

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

          <div style="margin-top: 18px;">
            <button type="submit" class="btn btn-primary">Add Course</button>
          </div>
        </form>
      </div>

      <div class="card">
        <h2 style="margin-top: 0;">Course List</h2>

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
    rs = stmt.executeQuery("SELECT * FROM Course ORDER BY CourseID");

    while (rs.next()) {
%>
              <tr>
                <td><%= rs.getInt(1) %></td>
                <td><%= rs.getString(2) %></td>
                <td><%= rs.getInt(3) %></td>
                <td><%= rs.getString(4) %></td>
              </tr>
<%
    }
} catch (Exception e) {
%>
              <tr>
                <td colspan="4">Error: <%= e.getMessage() %></td>
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
</div>

</body>
</html>