<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Study Session</title>
  <link rel="stylesheet" href="css/global.css">
</head>
<body>

<%@ include file="navbar.jsp" %>

<div class="page-shell">
  <div class="container">
    <div class="form-card">

      <%
        String sessionID = request.getParameter("sessionID");
        int userID = Integer.parseInt(request.getParameter("userID"));
        String deleteReason = request.getParameter("deleteReason");

        String db = "project";
        String user;
        user = "root";
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

          String deletedQuery = "SELECT * FROM deletes WHERE SessionID=" + sessionID;
          ResultSet deleted = stmt.executeQuery(deletedQuery);

          if (!deleted.next()) {
            String delete = "INSERT INTO deletes (DeletedByUserID, SessionID, Reason) VALUES("
              + userID + ", "
              + sessionID + ", '"
              + deleteReason + "')";

            Statement deleteStmt = con.createStatement();
            int rs = deleteStmt.executeUpdate(delete);

            if (rs > 0) {
              con.commit();
              out.println("<h1 class='form-title'>Session deleted</h1>");
              out.println("<p class='form-subtitle'>The session was removed successfully.</p>");
              out.println("<div style='margin-top:18px; padding:12px 14px; border-radius:14px; background:#f4f8f6; color:#0f766e; border:1px solid rgba(15,118,110,0.18);'>Successfully deleted session with Session ID: " + sessionID + ".</div>");
            }

            deleteStmt.close();
          } else {
            con.rollback();
            out.println("<h1 class='form-title'>Session already deleted</h1>");
            out.println("<p class='form-subtitle'>This session has already been removed from the active list.</p>");
            out.println("<div style='margin-top:18px; padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);'>Session has already been deleted.</div>");
          }

          out.println("<div class='form-actions' style='margin-top:22px;'>");
          out.println("<button type='button' class='btn btn-secondary' onclick=\"window.location.href='view_sessions.jsp'\">Back to My Sessions</button>");
          out.println("</div>");

          stmt.close();
          con.close();

        } catch(SQLException e) {
          out.println("<h1 class='form-title'>Something went wrong</h1>");
          out.println("<p class='form-subtitle'>There was a database error while deleting the session.</p>");
          out.println("<div style='margin-top:18px; padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);'>SQLException caught: " + e.getMessage() + "</div>");
          out.println("<div class='form-actions' style='margin-top:22px;'>");
          out.println("<button type='button' class='btn btn-secondary' onclick=\"window.location.href='view_sessions.jsp'\">Back to My Sessions</button>");
          out.println("</div>");
        }
      %>

    </div>
  </div>
</div>

</body>
</html>