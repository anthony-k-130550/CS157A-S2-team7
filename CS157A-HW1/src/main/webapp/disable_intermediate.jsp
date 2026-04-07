<%@ page import="java.sql.*"%>
<html>
	<head>
	  <title>Study Session</title>
	</head>
	<body>
		<%
			Integer AdminId = (Integer)session.getAttribute("userID");
			String userID = (request.getParameter("userID"));
			String deleteReason = request.getParameter("deleteReason");
			
			String db = "project";
	        String user;
	        user = "root";
	        String password = "CS157ALG";
	        try {
	            java.sql.Connection con;
	            Class.forName("com.mysql.jdbc.Driver");

	            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project?autoReconnect=true&useSSL=false", user, password);
				con.setAutoCommit(false);
	            Statement stmt = con.createStatement();
	            
	            String deletedQuery = "SELECT * FROM disables WHERE StudentUserID=" + userID;
	            ResultSet deleted = stmt.executeQuery(deletedQuery);
	            
	            if (!deleted.next()) { //safety check to see if the session has already been disable
	            	String delete = "INSERT INTO disables (AdminUserID, StudentUserID, Reason) VALUES(" + 
            				AdminId + ", " +
            				userID + ", '" +
            				deleteReason + "')";
	            	Statement deleteStmt = con.createStatement();
	            	int rs = deleteStmt.executeUpdate(delete);
	            	if (rs > 0) {
	            		con.commit();
	            		out.println("Successfully disabled user with user ID: " + userID);
	            	}
	            	deleteStmt.close();
	            } else {
	            	con.rollback();
	            	out.println("<p>Session has already been deleted.</p>");
	            }
	            out.println("<p>Back to User Search: </p>");
            	out.println("<button onclick=\"window.location.href='search_user.jsp?'\">Back</button>");
	            stmt.close();
	            con.close();
	        } catch(SQLException e) {
	            out.println("SQLException caught: " + e.getMessage());
	        }
		%>
	</body>
</html>