<%@ page import="java.sql.*"%>
<html>
	<head>
	  <title>Study Session</title>
	</head>
	<body>
		<%
			//
			// first section is just getting the session information, should be the same for both user and admin
			//
			//the details button passes in the sessionID
			String sessionID = request.getParameter("sessionID");
			int userID = (Integer)session.getAttribute("userID");
			
			String query = "SELECT * FROM studysession WHERE SessionID = '" + sessionID + "'";
			String db = "project";
	        String user;
	        user = "root";
	        String password = "CS175ALG";
	        try {
	            java.sql.Connection con;
	            Class.forName("com.mysql.cj.jdbc.Driver");

	            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project?autoReconnect=true&useSSL=false", user, password);

	            Statement stmt = con.createStatement();

	            ResultSet rs = stmt.executeQuery(query);

	            //printing out the header, along with all the session information
	            if (rs.next()) {
	            	out.println("<h1>" + rs.getString(2) + "</h1>");
	            	out.println("<p>Session ID: " + rs.getInt(1) + "</p>");
	            	out.println("<p>Start Time: " + rs.getTime(3) + "</p>");
	            	out.println("<p>End Time: " + rs.getTime(4) + "</p>");
	            	out.println("<p>Date: " + rs.getDate(5) + "</p>");
	            	out.println("<p>Session Capacity: " + rs.getInt(6) + "</p>");
	            	out.println("<p>Description: " + rs.getString(7) + "</p>");
	            }
	            
	            String permission = (String) session.getAttribute("role");
	            //
	            // second section I have it check if it's a student, then creating a join button
	            //
	            if ("student".equals(permission)){
	            	//todo, create join functionality (has to check if count is under capacity), and then add to relevant tables
	            	/*
	            	to join, check if the count of studnetUserIDs in a session is under the session capacity. If it is, let the person join
	            	*/
		            rs.close();
	            	stmt.close();
		            
		            int current = 0;
		            Statement curStmt = con.createStatement();
		            ResultSet rs2 = curStmt.executeQuery("SELECT COUNT(StudentUserID) FROM joins WHERE sessionID = " + sessionID);
		            
		            int max = 0;
		            Statement maxStmt = con.createStatement();
		            ResultSet rs3 = maxStmt.executeQuery("SELECT Capacity FROM studysession WHERE SessionID = " + sessionID);
		            
		            if (rs2.next()) {
		            	current = rs2.getInt(1);
		            }
		            if (rs3.next()) {
		            	max = rs3.getInt(1);
		            }
	        		
		            
	            	if (current < max) {
	            		out.println("<button onclick=\"window.location.href='join_intermediate.jsp?sessionID=" + sessionID + "&userID=" + userID + "'\">Join</button>");
	            	} else {
	            		out.println("<button disabled>MAX CAPACITY</button>");
	            	}
	            	rs2.close();
	            	rs3.close();
	            	curStmt.close();
	            	maxStmt.close();
	            }
	            
	            //
	            // third section I have it check if admin, then create a delete button
	            //
	            if ("admin".equals(permission)){
	            	out.println("<p>Enter a reason (if you want to delete this page)</p>");
	            	out.println("<form action=\"delete_intermediate.jsp\" method=\"post\">");
	            	out.println("<input type=\"hidden\" name=\"sessionID\" value=\"" + sessionID + "\" />");
	            	out.println("<input type=\"hidden\" name=\"userID\" value = \"" + userID + "\" />");
	            	out.println("<input type=\"text\" name=\"deleteReason\" + maxlength=\"200\" value=\"bad behavior\" />");
	            	out.println("<button type=\"submit\">Delete</button>");
	            	out.println("</form>");
	            }
	            con.close();
	        } catch(SQLException e) {
	            out.println("SQLException caught: " + e.getMessage());
	        }
		%>
	</body>
</html>