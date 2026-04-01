<%@ page import="java.sql.*"%>
<html>
<head>
  <title>Study Session Account Registration</title>
</head>
<body>
<h1>Register for a Study Session Account today!</h1>
<p>Fill out the information below for a study session account!</p>

<form method="post">

<label for="fullname">Full Name:</label><br> <input type="text" id="fullname" name="fullname" required><br><br>

<label for="email">Email:</label><br> <input type="email" id="email" name="email" required><br><br>

<label for="password">Password:</label><br> <input type="password" id="password" name="password" required><br><br>

<label for="department">Department:</label><br> <input type="text" id="department" name="department" required><br><br>

<button type="submit">Register</button>

</form>
    <%
     String db = "project";
     String user; // assumes database name is the same as username
     user = "root";
     String databasePassword = "CS157A";
     
     String fullname = request.getParameter("fullname");
     String email;
     String password;
     String dept;
     if (fullname != null) { //if the form is filled
    	 email = request.getParameter("email");
    	 password = request.getParameter("password");
    	 dept = request.getParameter("department");
    	 int userID = (int)(Math.random() * 900000000) + 100000000; //using 9 digit number for user id
    	 int studentID = (int)(Math.random() * 9000000) + 1000000; //using 7 digit number for student id
    	 
    	// simple email regex to check if it's a valid email
   	    String emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$";

   	    if (!email.matches(emailRegex)) {
   	        out.println("<p style='color:red;'>Invalid email format</p>");
   	        return;
   	    }
   	    
	   	 try {
	         java.sql.Connection con;
	         Class.forName("com.mysql.jdbc.Driver");
	
	         con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project?autoReconnect=true&useSSL=false", user, databasePassword);
	
	         Statement stmt = con.createStatement();
	         con.setAutoCommit(false); //added this just in case we can insert into users but not students. Want to commit both at the same time
	         
	         String insert1 = "INSERT INTO users (UserID, FullName, Email, Password, Department) VALUES ("
	        		 	+ userID + ", '"
	        		    + fullname + "', '"
	        		    + email + "', '"
	        		    + password + "', '"
	        		    + dept + "')";
	         
			String insert2 = "INSERT INTO students (UserID, StudentID) VALUES (" 
					+ userID + ", "
					+ studentID + ")";
			
	         int rs1 = stmt.executeUpdate(insert1);
	         int rs2 = stmt.executeUpdate(insert2);
	         
	         if ((rs1 > 0) && (rs2 > 0)) {
	        	 con.commit(); //only save if both work
	        	 out.println("<p>Successful Registration!</p>");
	         } else {
	        	 con.rollback(); //else go back
	        	 out.println("<p>Failed Registration</p>");
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