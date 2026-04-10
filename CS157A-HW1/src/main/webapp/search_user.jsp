s<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search Users</title>
<link rel="stylesheet" href="css/global.css">
</head>
<body>

<%@ include file="navbar.jsp" %>

<script>
function getReason(userID) {
  let input = prompt("Enter reason:");

  if (input !== null && input.trim() !== "") {
    window.location.href = "disable_intermediate.jsp?userID=" + userID + "&deleteReason=" + encodeURIComponent(input);
  } else {
    alert("Input required!");
  }
}
</script>

<div class="page-shell">
  <div class="container">
    <div class="card" style="margin-bottom: 24px;">
      <h1 class="form-title" style="margin-bottom: 8px;">Search Users</h1>
      <p class="form-subtitle" style="margin-bottom: 0;">
        Find student accounts by user ID, name, email, or department, then disable accounts when needed.
      </p>
    </div>

    <div class="card" style="margin-bottom: 24px;">
      <form method="post">
        <div class="grid grid-2">
          <div class="field">
            <label for="userID">User ID</label>
            <input type="number" id="userID" name="userID">
          </div>

          <div class="field">
            <label for="name">Name</label>
            <input type="text" id="name" name="name">
          </div>

          <div class="field">
            <label for="email">Email</label>
            <input type="text" id="email" name="email">
          </div>

          <div class="field">
            <label for="Department">Department</label>
            <input type="text" id="Department" name="Department">
          </div>
        </div>

        <div class="form-actions">
          <button type="submit" class="btn btn-primary">Search User</button>
        </div>
      </form>
    </div>

    <div class="card">
      <div style="overflow-x: auto;">
        <table class="table">
          <thead>
            <tr>
              <th>UserID</th>
              <th>Name</th>
              <th>Email</th>
              <th>Department</th>
              <th>Disable</th>
            </tr>
          </thead>
          <tbody>

<%
String userID = request.getParameter("userID");
String name = request.getParameter("name");
String email = request.getParameter("email");
String department = request.getParameter("Department");

String db = "project";
String user;
user = "root";
String password = "CS157ALG";
java.sql.Connection con = null;

StringBuilder query = new StringBuilder(
    "SELECT u.* FROM users u JOIN students s ON s.UserID = u.UserID WHERE 1=1"
);

// userID
if (userID != null && !userID.isBlank()) {
    query.append(" AND u.UserID = '" + userID + "'");
}

// name
if (name != null && !name.isBlank()) {
    query.append(" AND u.FullName LIKE '%" + name + "%'");
}

// email
if (email != null && !email.isBlank()) {
    query.append(" AND u.Email LIKE '%" + email + "%'");
}

// department
if (department != null && !department.isBlank()) {
    query.append(" AND u.Department LIKE '%" + department + "%'");
}

try {
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/project?autoReconnect=true&useSSL=false",
        user,
        password
    );

    String sql = query.toString();
    PreparedStatement ps = con.prepareStatement(sql);
    ResultSet rs = ps.executeQuery();

    while (rs.next()) {
        out.println("<tr>");
        out.println("<td>" + rs.getInt("userID") + "</td>");
        out.println("<td>" + rs.getString("FullName") + "</td>");
        out.println("<td>" + rs.getString("Email") + "</td>");
        out.println("<td>" + rs.getString("Department") + "</td>");
        out.println("<td><button type='button' class='btn btn-danger' onclick=\"getReason(" + rs.getInt("userID") + ")\">Disable</button></td>");
        out.println("</tr>");
    }

    if (rs != null) rs.close();
    if (ps != null) ps.close();

} catch(SQLException e) {
    out.println("<tr><td colspan='5'><div style='padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);'>SQLException caught: " + e.getMessage() + "</div></td></tr>");
    e.printStackTrace();
} finally {
    if (con != null) {
        try { con.close(); } catch (Exception e) {}
    }
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