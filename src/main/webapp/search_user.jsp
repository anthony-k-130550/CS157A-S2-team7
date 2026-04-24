<%@ page language="java" contentType="text/html; charset=UTF-8"
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

function enableUser(userID) {
  window.location.href = "enable_intermediate.jsp?userID=" + userID;
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
              <th>Action</th>
            </tr>
          </thead>
          <tbody>

<%
String userID = request.getParameter("userID");
String name = request.getParameter("name");
String email = request.getParameter("email");
String department = request.getParameter("Department");

String user = "root";
String password = "CS157ALG";
Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

StringBuilder query = new StringBuilder(
    "SELECT u.*, " +
    "EXISTS (SELECT 1 FROM disables d WHERE d.StudentUserID = u.UserID) AS isDisabled " +
    "FROM users u " +
    "JOIN students s ON s.UserID = u.UserID " +
    "WHERE 1=1"
);

if (userID != null && !userID.isBlank()) {
    query.append(" AND u.UserID = ?");
}

if (name != null && !name.isBlank()) {
    query.append(" AND u.FullName LIKE ?");
}

if (email != null && !email.isBlank()) {
    query.append(" AND u.Email LIKE ?");
}

if (department != null && !department.isBlank()) {
    query.append(" AND u.Department LIKE ?");
}

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/project?autoReconnect=true&useSSL=false",
        user,
        password
    );

    ps = con.prepareStatement(query.toString());

    int paramIndex = 1;

    if (userID != null && !userID.isBlank()) {
        ps.setInt(paramIndex++, Integer.parseInt(userID));
    }

    if (name != null && !name.isBlank()) {
        ps.setString(paramIndex++, "%" + name + "%");
    }

    if (email != null && !email.isBlank()) {
        ps.setString(paramIndex++, "%" + email + "%");
    }

    if (department != null && !department.isBlank()) {
        ps.setString(paramIndex++, "%" + department + "%");
    }

    rs = ps.executeQuery();

    while (rs.next()) {
        boolean isDisabled = rs.getBoolean("isDisabled");
        String action;

        if (isDisabled) {
            action = "<button type='button' class='btn btn-success' onclick=\"enableUser(" + rs.getInt("UserID") + ")\">Enable</button>";
        } else {
            action = "<button type='button' class='btn btn-danger' onclick=\"getReason(" + rs.getInt("UserID") + ")\">Disable</button>";
        }

        out.println("<tr>");
        out.println("<td>" + rs.getInt("UserID") + "</td>");
        out.println("<td>" + rs.getString("FullName") + "</td>");
        out.println("<td>" + rs.getString("Email") + "</td>");
        out.println("<td>" + rs.getString("Department") + "</td>");
        out.println("<td>" + action + "</td>");
        out.println("</tr>");
    }

} catch(SQLException e) {
    out.println("<tr><td colspan='5'><div style='padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);'>SQLException caught: " + e.getMessage() + "</div></td></tr>");
    e.printStackTrace();
} catch(ClassNotFoundException e) {
    out.println("<tr><td colspan='5'><div style='padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);'>Driver error: " + e.getMessage() + "</div></td></tr>");
} finally {
    if (rs != null) {
        try { rs.close(); } catch (Exception e) {}
    }
    if (ps != null) {
        try { ps.close(); } catch (Exception e) {}
    }
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