<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*"%>
    
    <%@ include file="navbar.jsp" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


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


<form method="post">
	<!-- Department -->
	<label>UserID:</label>
	<input type="number" name="userID"><br><br>
	
	<!-- Class Number -->
	<label>Name:</label>
	<input type="text" name="name"><br><br>
	
	<!-- Day -->
	<label>Email:</label>
	<input type="text" name="email"><br><br>
	
	<!-- Building -->
	<label>Department:</label>
	<input type="text" name="Department"><br><br>

	
	<button type="submit">Search User</button>

</form>



<table border="1">
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
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project?autoReconnect=true&useSSL=false", user, password);

    String sql = query.toString();
    
    PreparedStatement ps = con.prepareStatement(sql);
	
    ResultSet rs = ps.executeQuery();
    
    while(rs.next()){
    	out.println("<tr>");
        out.println("<td>" + rs.getInt("userID") + "</td>");
        out.println("<td>" + rs.getString("FullName") + "</td>");
        out.println("<td>" + rs.getString("Email") + "</td>");
        out.println("<td>" + rs.getString("Department") + "</td>");
        out.println("<td><button onclick=\"getReason(" + rs.getInt("userID") + ")\">Disable</button></td>");
        out.println("</tr>");
    }
	
    if (rs != null) rs.close();
    if (ps != null) ps.close();
    
    out.println("</tbody>");
    out.println("</table>");

} catch(SQLException
		e) {
	out.println("SQLException caught: " + e.getMessage());
	e.printStackTrace();
}  finally {
    if (con != null) {
        try { con.close(); } catch (Exception e) {}
    }
}

	
%>




</body>
</html>