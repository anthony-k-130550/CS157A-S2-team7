<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Enable User</title>
  <link rel="stylesheet" href="css/global.css">
</head>
<body>

<%@ include file="navbar.jsp" %>

<div class="page-shell">
  <div class="container">
    <div class="form-card">

      <%
        String userID = request.getParameter("userID");

        String user = "root";
        String password = "CS157ALG";

        Connection con = null;
        Statement stmt = null;
        ResultSet disabled = null;

        try {
          Class.forName("com.mysql.jdbc.Driver");

          con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/project?autoReconnect=true&useSSL=false",
            user,
            password
          );

          con.setAutoCommit(false);
          stmt = con.createStatement();

          String disabledQuery = "SELECT * FROM disables WHERE StudentUserID=" + userID;
          disabled = stmt.executeQuery(disabledQuery);

          if (disabled.next()) {
            disabled.close();

            String enableSql = "DELETE FROM disables WHERE StudentUserID=" + userID;
            Statement enableStmt = con.createStatement();
            int rs = enableStmt.executeUpdate(enableSql);

            if (rs > 0) {
              con.commit();
              out.println("<h1 class='form-title'>User enabled</h1>");
              out.println("<p class='form-subtitle'>The account has been enabled successfully.</p>");
              out.println("<div style='margin-top:18px; padding:12px 14px; border-radius:14px; background:#f4f8f6; color:#0f766e; border:1px solid rgba(15,118,110,0.18);'>Successfully enabled user with User ID: " + userID + ".</div>");
            } else {
              con.rollback();
              out.println("<h1 class='form-title'>Enable failed</h1>");
              out.println("<p class='form-subtitle'>The account could not be enabled.</p>");
              out.println("<div style='margin-top:18px; padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);'>No changes were made.</div>");
            }

            enableStmt.close();
          } else {
            con.rollback();
            out.println("<h1 class='form-title'>User already enabled</h1>");
            out.println("<p class='form-subtitle'>This account is not currently disabled.</p>");
            out.println("<div style='margin-top:18px; padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);'>User is not in the disables table.</div>");
          }

          out.println("<div class='form-actions' style='margin-top:22px;'>");
          out.println("<button type='button' class='btn btn-secondary' onclick=\"window.location.href='search_user.jsp'\">Back to User Search</button>");
          out.println("</div>");

        } catch (SQLException e) {
          if (con != null) {
            try { con.rollback(); } catch (Exception ex) {}
          }

          out.println("<h1 class='form-title'>Something went wrong</h1>");
          out.println("<p class='form-subtitle'>There was a database error while enabling the user.</p>");
          out.println("<div style='margin-top:18px; padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);'>SQLException caught: " + e.getMessage() + "</div>");
          out.println("<div class='form-actions' style='margin-top:22px;'>");
          out.println("<button type='button' class='btn btn-secondary' onclick=\"window.location.href='search_user.jsp'\">Back to User Search</button>");
          out.println("</div>");
        } catch (ClassNotFoundException e) {
          out.println("<h1 class='form-title'>Something went wrong</h1>");
          out.println("<p class='form-subtitle'>The database driver could not be loaded.</p>");
          out.println("<div style='margin-top:18px; padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);'>Driver error: " + e.getMessage() + "</div>");
          out.println("<div class='form-actions' style='margin-top:22px;'>");
          out.println("<button type='button' class='btn btn-secondary' onclick=\"window.location.href='search_user.jsp'\">Back to User Search</button>");
          out.println("</div>");
        } finally {
          if (disabled != null) {
            try { disabled.close(); } catch (Exception e) {}
          }
          if (stmt != null) {
            try { stmt.close(); } catch (Exception e) {}
          }
          if (con != null) {
            try { con.close(); } catch (Exception e) {}
          }
        }
      %>

    </div>
  </div>
</div>

</body>
</html>