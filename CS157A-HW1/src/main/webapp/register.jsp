<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Study Session Account Registration</title>
  <link rel="stylesheet" href="css/global.css">
</head>
<body>

<%@ include file="navbar.jsp" %>

<div class="page-shell">
  <div class="container">
    <div class="form-card">

      <h1 class="form-title">Create your account</h1>
      <p class="form-subtitle">Fill out the information below to register for a study session account.</p>

      <form method="post">

        <div class="field">
          <label for="fullname">Full Name</label>
          <input type="text" id="fullname" name="fullname" required>
        </div>

        <div class="field">
          <label for="email">Email</label>
          <input type="email" id="email" name="email" required>
        </div>

        <div class="field">
          <label for="password">Password</label>
          <input type="password" id="password" name="password" required>
        </div>

        <div class="field">
          <label for="department">Department</label>
          <input type="text" id="department" name="department" required>
        </div>

        <div class="form-actions">
          <button type="submit" class="btn btn-primary">Register</button>
        </div>

      </form>

      <%
       String db = "project";
       String user;
       user = "root";
       String databasePassword = "CS157ALG";

       String fullname = request.getParameter("fullname");
       String email;
       String password;
       String dept;

       if (fullname != null) {

         email = request.getParameter("email");
         password = request.getParameter("password");
         dept = request.getParameter("department");

         int userID = (int)(Math.random() * 900000000) + 100000000;
         int studentID = (int)(Math.random() * 9000000) + 1000000;

         String emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$";

         if (!email.matches(emailRegex)) {
           out.println("<div style='margin-top:18px; padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);'>Invalid email format</div>");
           return;
         }

         try {
           java.sql.Connection con;
           Class.forName("com.mysql.jdbc.Driver");

           con = DriverManager.getConnection(
             "jdbc:mysql://localhost:3306/project?autoReconnect=true&useSSL=false",
             user,
             databasePassword
           );

           Statement stmt = con.createStatement();
           con.setAutoCommit(false);

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
             con.commit();
             out.println("<div style='margin-top:18px; padding:12px 14px; border-radius:14px; background:#f4f8f6; color:#0f766e; border:1px solid rgba(15,118,110,0.18);'>Successful registration. You can now log in.</div>");
           } else {
             con.rollback();
             out.println("<div style='margin-top:18px; padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);'>Registration failed.</div>");
           }

           stmt.close();
           con.close();

         } catch(SQLException e) {
           out.println("<div style='margin-top:18px; padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);'>SQLException: " + e.getMessage() + "</div>");
         }
       }
      %>

    </div>
  </div>
</div>

</body>
</html>