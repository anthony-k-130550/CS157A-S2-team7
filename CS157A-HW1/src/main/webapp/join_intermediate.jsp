<%@ page import="java.sql.*"%>
<html>
	<head>
	  <title>Study Session</title>
	</head>
	<body>
		<%
			String sessionID = request.getParameter("sessionID");
			int userID = Integer.parseInt(request.getParameter("userID"));
			
			String db = "project";
	        String user;
	        user = "root";
	        String password = "CS175ALG";
	        
	        try {
	            java.sql.Connection con;
	            Class.forName("com.mysql.jdbc.Driver");

	            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project?autoReconnect=true&useSSL=false", user, password);
	            con.setAutoCommit(false);
	            Statement stmt1 = con.createStatement();
	            Statement stmt2 = con.createStatement();
	            
	            String query1 = "SELECT * FROM disables WHERE StudentUserID=" + userID;
	            String query2 = "SELECT * FROM joins WHERE StudentUserID=" + userID + " AND SessionID=" + sessionID;
	            ResultSet disableResult = stmt1.executeQuery(query1);
	            ResultSet alreadyInResult = stmt2.executeQuery(query2);
	            
	            if (!alreadyInResult.next()){ //checking to make sure student hasn't already joined previously
	            	if (!disableResult.next()) { //checking to make sure that the student isn't in the disabled list
		            	Statement stmt3 = con.createStatement();
	            		String update = "INSERT INTO joins(StudentUserID, SessionID, SuccessStatus) VALUES(" +
		            				userID + ", " +
		            				sessionID + ", " +
		            				"'successfully joined')";
			           	int rs = stmt3.executeUpdate(update);
			           	
			           	if (rs > 0) {
			           		con.commit();
			           		out.println("<p>Successfully joined session with Session ID: " + sessionID + "</p>");
			           	} else {
			           		con.rollback();
			           		out.println("<p>join failed</p>");
			           	}
		            	stmt3.close();
		            } else {
		            	out.println("<p>Your account has been disabled. Please contact an administrator</p>");
		            }
	            } else {
	            	out.println("<p>You have already joined the session</p>");
	            }
	            out.println("<p>Back to Search Sessions: </p>");
            	out.println("<button onclick=\"window.location.href='search_sessions.jsp?'\">Back</button>");
	            disableResult.close();
	            alreadyInResult.close();
	           	stmt1.close();
	           	stmt2.close();
	           	con.close();
	        } catch(SQLException e) {
		         out.println("SQLException caught: " + e.getMessage());
		     }  
		%>
	</body>
</html>