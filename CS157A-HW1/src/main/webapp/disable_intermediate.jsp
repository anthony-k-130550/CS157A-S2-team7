<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Disable User</title>
  <link rel="stylesheet" href="css/global.css">
</head>
<body>

<%@ include file="navbar.jsp" %>

<div class="page-shell">
  <div class="container">
    <div class="form-card">

      <%
        Integer adminId = (Integer) session.getAttribute("userID");
        String userID = request.getParameter("userID");
        String deleteReason = request.getParameter("deleteReason");

        String user = "root";
        String password = "CS157ALG";

        try {
          java.sql.Connection con;
          Class.forName("com.mysql.jdbc.Driver");

          con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/project?autoReconnect=true&useSSL=false",
            user,
            password
          );

          con.setAutoCommit(false);
          Statement stmt = con.createStatement();

          String deletedQuery = "SELECT * FROM disables WHERE StudentUserID=" + userID;
          ResultSet deleted = stmt.executeQuery(deletedQuery);

          if (!deleted.next()) {
            String disableSql = "INSERT INTO disables (AdminUserID, StudentUserID, Reason) VALUES("
              + adminId + ", "
              + userID + ", '"
              + deleteReason + "')";

            Statement disableStmt = con.createStatement();
            int rs = disableStmt.executeUpdate(disableSql);

            if (rs > 0) {
              con.commit();
              out.println("<h1 class='form-title'>User disabled</h1>");
              out.println("<p class='form-subtitle'>The account has been disabled successfully.</p>");
              out.println("<div style='margin-top:18px; padding:12px 14px; border-radius:14px; background:#f4f8f6; color:#0f766e; border:1px solid rgba(15,118,110,0.18);'>Successfully disabled user with User ID: " + userID + ".</div>");
            } else {
              con.rollback();
              out.println("<h1 class='form-title'>Disable failed</h1>");
              out.println("<p class='form-subtitle'>The account could not be disabled.</p>");
              out.println("<div style='margin-top:18px; padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);'>No changes were made.</div>");
            }

            disableStmt.close();
          } else {
            con.rollback();
            out.println("<h1 class='form-title'>User already disabled</h1>");
            out.println("<p class='form-subtitle'>This account has already been disabled.</p>");
            out.println("<div style='margin-top:18px; padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);'>User has already been disabled.</div>");
          }

          out.println("<div class='form-actions' style='margin-top:22px;'>");
          out.println("<button type='button' class='btn btn-secondary' onclick=\"window.location.href='search_user.jsp'\">Back to User Search</button>");
          out.println("</div>");

          if (deleted != null) deleted.close();
          if (stmt != null) stmt.close();
          if (con != null) con.close();

        } catch (SQLException e) {
          out.println("<h1 class='form-title'>Something went wrong</h1>");
          out.println("<p class='form-subtitle'>There was a database error while disabling the user.</p>");
          out.println("<div style='margin-top:18px; padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);'>SQLException caught: " + e.getMessage() + "</div>");
          out.println("<div class='form-actions' style='margin-top:22px;'>");
          out.println("<button type='button' class='btn btn-secondary' onclick=\"window.location.href='search_user.jsp'\">Back to User Search</button>");
          out.println("</div>");
        }
      %>

    </div>
  </div>
</div>

</body>
</html>