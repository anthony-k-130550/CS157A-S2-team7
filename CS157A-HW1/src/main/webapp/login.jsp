<%@ page import="java.sql.*"%>
<html>
<head>
  <title>Study Session Account Registration</title>
</head>
<body>
<h1>Login</h1>
  <p>Enter your email and password.</p>

  <form method="post">
    <label for="email">Email:</label><br>
    <input type="email" id="email" name="email" required><br><br>

    <label for="password">Password:</label><br>
    <input type="password" id="password" name="password" required><br><br>

    <button type="submit">Login</button>
  </form>

    <%
     String db = "project";
     String user; // assumes database name is the same as username
     user = "root";
     String databasePassword = "CS157A";
     
     String email = request.getParameter("email");
     String password = request.getParameter("password");
     
     if (email != null && password != null) {
    	 try {
    	        Connection con;
    	        Class.forName("com.mysql.jdbc.Driver");

    	        con = DriverManager.getConnection(
    	          "jdbc:mysql://localhost:3306/project?autoReconnect=true&useSSL=false",
    	          user,
    	          databasePassword
    	        );

    	        Statement stmt = con.createStatement();

    	        String query = "SELECT * FROM users WHERE Email = '" 
    	            + email + "' AND Password = '" 
    	            + password + "'";

    	        ResultSet rs = stmt.executeQuery(query);

    	        if (rs.next()) {
    	          //response.sendRedirect("home.jsp");	
    	          int userID = rs.getInt(1); //get the userID to see if admin or normal user
    	          String redirectQuery = "SELECT 1 FROM admins WHERE userID = '" + userID + "'";
    	              	          
    	          //if the userID is in the admin table, then go to admin dashboard
    	          //otherwise, go to the normal user/student dashboard
    	          ResultSet redirectResult = stmt.executeQuery(redirectQuery);
    	          if (redirectResult.next()){
    	        	  session.setAttribute("role", "admin");
        	          response.sendRedirect("admin_dashboard.jsp");	
    	          } else {
    	        	  session.setAttribute("role", "user");	
    	        	  response.sendRedirect("userhome.jsp");
    	          }
    	        } else {
    	          out.println("<p style='color:red;'>Invalid email or password.</p>");
    	        }

    	        rs.close();
    	        stmt.close();
    	        con.close();
    	      } catch (SQLException e) {
    	        out.println("SQLException caught: " + e.getMessage());
    	      }
     }
    %>
</body>
</html>