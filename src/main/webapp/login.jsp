<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Study Session Account Login</title>
  <link rel="stylesheet" href="css/global.css">
</head>
<body>
  <%@ include file="navbar.jsp" %>

  <div class="page-shell">
    <div class="container">
      <div class="form-card">
        <h1 class="form-title">Login</h1>
        <p class="form-subtitle">Enter your email and password.</p>

        <form method="post">
          <div class="field">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" required>
          </div>

          <div class="field">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required>
          </div>

          <div style="margin-top: 20px;">
            <button type="submit" class="btn btn-primary">Login</button>
          </div>
        </form>

        <%
         String user;
         user = "root";
         String databasePassword = "CS157ALG";

         String email = request.getParameter("email");
         String password = request.getParameter("password");

         if (email != null && password != null) {
           try {
             Connection con;
             Class.forName("com.mysql.cj.jdbc.Driver");

             con = DriverManager.getConnection(
            		  "jdbc:mysql://127.0.0.1:3306/project?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC",
            		  user,
            		  databasePassword
            		);

             Statement stmt = con.createStatement();

             String query = "SELECT * FROM users WHERE Email = '"
                 + email + "' AND Password = '"
                 + password + "'";

             ResultSet rs = stmt.executeQuery(query);

             if (rs.next()) {
               int userID = rs.getInt(1);
               String redirectQuery = "SELECT 1 FROM admins WHERE userID = '" + userID + "'";

               String disableQuery = "SELECT * FROM disables WHERE StudentUserID=" + userID;
               Statement disableStmt = con.createStatement();
               ResultSet disableRS = disableStmt.executeQuery(disableQuery);

               if (!disableRS.next()) {
                 session.setAttribute("userID", userID);

                 ResultSet redirectResult = stmt.executeQuery(redirectQuery);
                 if (redirectResult.next()) {
                   session.setAttribute("role", "admin");
                   response.sendRedirect("admin_dashboard.jsp");
                 } else {
                   session.setAttribute("role", "student");
                   response.sendRedirect("userhome.jsp");
                 }
               } else {
                 out.println("<div style='margin-top:18px; padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);'>Your account has been disabled. Please contact an administrator.</div>");
               }

               disableRS.close();
               disableStmt.close();
             } else {
               out.println("<div style='margin-top:18px; padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);'>Invalid email or password.</div>");
             }

             rs.close();
             stmt.close();
             con.close();
           } catch (SQLException e) {
             out.println("<div style='margin-top:18px; padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);'>SQLException caught: " + e.getMessage() + "</div>");
           }
         }
        %>
      </div>
    </div>
  </div>
</body>
</html>