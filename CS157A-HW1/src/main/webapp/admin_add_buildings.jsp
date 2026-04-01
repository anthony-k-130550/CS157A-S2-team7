<%@ page import="java.sql.*"%>
<html>
<head>
  <title>Admin Add Buildings</title>
</head>
<body>
	<form method="post">
		<!-- Building info -->
		<label>Building:</label>
		<input type="text" name="Building"><br><br>
		
		<button type="submit">Add Building</button>
	</form>
	
	<%
		String building = request.getParameter("Building");
		if (building != null) {
			String insert = "INSERT INTO building VALUES('" + building + "')";
			
			String db = "project";
		    String user;
		    user = "root";
		    String password = "CS157A";
		    try {
		        java.sql.Connection con;
		        Class.forName("com.mysql.jdbc.Driver");
		        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project?autoReconnect=true&useSSL=false", user, password);

		        Statement stmt = con.createStatement();
		        con.setAutoCommit(false);
		        int rs = stmt.executeUpdate(insert);
		        
		        if (rs>0 ){
		        	con.commit();
		        	out.println("<p>Successfully added " + building + " to buildings table.</p>");
		        } else {
		        	con.rollback();
		        	out.println("<p>Failed to add " + building + " to buildings table.</p>");
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