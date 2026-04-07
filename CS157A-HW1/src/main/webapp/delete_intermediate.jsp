<%@ page import="java.sql.*"%>
<html>
	<head>
	  <title>Study Session</title>
	</head>
	<body>
		<%
			String sessionID = request.getParameter("sessionID");
			int userID = Integer.parseInt(request.getParameter("userID"));
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
	            
	            String deletedQuery = "SELECT * FROM deletes WHERE SessionID=" + sessionID;
	            ResultSet deleted = stmt.executeQuery(deletedQuery);
	            
	            if (!deleted.next()) { //safety check to see if the session has already been deleted
	            	String delete = "INSERT INTO deletes (DeletedByUserID, SessionID, Reason) VALUES(" + 
            				userID + ", " +
            				sessionID + ", '" +
            				deleteReason + "')";
	            	Statement deleteStmt = con.createStatement();
	            	int rs = deleteStmt.executeUpdate(delete);
	            	if (rs > 0) {
	            		con.commit();
	            		out.println("Successfully Deleted Session with Session ID: " + sessionID);
	            	}
	            	deleteStmt.close();
	            } else {
	            	con.rollback();
	            	out.println("<p>Session has already been deleted.</p>");
	            }
	            out.println("<p>Back to Search Sessions: </p>");
            	out.println("<button onclick=\"window.location.href='view_sessions.jsp?'\">Back</button>");
	            stmt.close();
	            con.close();
	        } catch(SQLException e) {
	            out.println("SQLException caught: " + e.getMessage());
	        }
		%>
	</body>
</html>