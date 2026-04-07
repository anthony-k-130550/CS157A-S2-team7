<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
			int userID = Integer.parseInt(request.getParameter("userID"));
			int sessionID = Integer.parseInt(request.getParameter("sessionID"));

			
			String db = "project";
	        String user;
	        user = "root";
	        String password = "CS157ALG";
	        try {
	            java.sql.Connection con;
	            Class.forName("com.mysql.jdbc.Driver");

	            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project?autoReconnect=true&useSSL=false", user, password);
				
	        	String sql = "DELETE FROM joins WHERE sessionID=? AND StudentUserID=?";
	        	
	        	PreparedStatement ps = con.prepareStatement(sql);
	               
	            ps.setInt(1, sessionID);
	            ps.setInt(2, userID);
	               
	           	int rowsAffected = ps.executeUpdate();

	           	if (rowsAffected > 0) {
	           		out.println("<p>Successfully left session with Session ID: " + sessionID + "</p>");

	           	} else {
	           	    out.println("<p>No matching record found.</p>");
	           	}
	           	
	            
	            out.println("<p>Back to My Sessions: </p>");
            	out.println("<button onclick=\"window.location.href='view_sessions.jsp?'\">Back</button>");
	       
	            
	        } catch(SQLException e) {
	            out.println("SQLException caught: " + e.getMessage());
	        }
		%>
</body>
</html>