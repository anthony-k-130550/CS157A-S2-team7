<%@ page import="java.sql.*"%>
<%@ include file="navbar.jsp" %>

<html>
<head>
  <title>Admin Add Buildings</title>
</head>
<body>
	<form method="post">
		<!-- Building info -->
		<label>Building:</label>
		<input type="text" name="Building"><br><br>
		
		<label>Room ID</label>
		<input type="number" name="Room"><br><br>
		
		<button type="submit">Add Room</button>
	</form>
	
	<%
		String building = request.getParameter("Building");
		String room = request.getParameter("Room");
		if (building != null && room != null) {
			String insert = "INSERT INTO room(BuildingName, RoomID) VALUES('" + building + "', " +
					room + ")";
			
			String db = "project";
		    String user;
		    user = "root";
		    String password = "CS157ALG";
		    try {
		        java.sql.Connection con;
		        Class.forName("com.mysql.jdbc.Driver");
		        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project?autoReconnect=true&useSSL=false", user, password);

		        Statement stmt = con.createStatement();
		        con.setAutoCommit(false);
		        int rs = stmt.executeUpdate(insert);
		        
		        if (rs>0 ){
		        	con.commit();
		        	out.println("<p>Successfully added " + building + " " + room + " to room table.</p>");
		        } else {
		        	con.rollback();
		        	out.println("<p>Failed to add " + building + " " + room + " to room table.</p>");
		        }
		        stmt.close();
		        con.close();
		    } catch(SQLException e) {
		         out.println("SQLException caught: " + e.getMessage());
		    }
		}
	%>

</body>
</html>