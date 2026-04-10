<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Join Study Session</title>
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
          Statement stmt1 = con.createStatement();
          Statement stmt2 = con.createStatement();

          String query1 = "SELECT * FROM disables WHERE StudentUserID=" + userID;
          String query2 = "SELECT * FROM joins WHERE StudentUserID=" + userID + " AND SessionID=" + sessionID;

          ResultSet disableResult = stmt1.executeQuery(query1);
          ResultSet alreadyInResult = stmt2.executeQuery(query2);

          if (!alreadyInResult.next()) {
            if (!disableResult.next()) {
              Statement stmt3 = con.createStatement();
              String update = "INSERT INTO joins(StudentUserID, SessionID, SuccessStatus) VALUES("
                + userID + ", "
                + sessionID + ", "
                + "'successfully joined')";

              int rs = stmt3.executeUpdate(update);

              if (rs > 0) {
                con.commit();
                out.println("<h1 class='form-title'>Joined session</h1>");
                out.println("<p class='form-subtitle'>Your request to join the session was successful.</p>");
                out.println("<div style='margin-top:18px; padding:12px 14px; border-radius:14px; background:#f4f8f6; color:#0f766e; border:1px solid rgba(15,118,110,0.18);'>Successfully joined session with Session ID: " + sessionID + ".</div>");
              } else {
                con.rollback();
                out.println("<h1 class='form-title'>Join failed</h1>");
                out.println("<p class='form-subtitle'>The session could not be joined.</p>");
                out.println("<div style='margin-top:18px; padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);'>Join failed.</div>");
              }

              stmt3.close();
            } else {
              out.println("<h1 class='form-title'>Account disabled</h1>");
              out.println("<p class='form-subtitle'>This account cannot join sessions.</p>");
              out.println("<div style='margin-top:18px; padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);'>Your account has been disabled. Please contact an administrator.</div>");
            }
          } else {
            out.println("<h1 class='form-title'>Already joined</h1>");
            out.println("<p class='form-subtitle'>You are already a member of this session.</p>");
            out.println("<div style='margin-top:18px; padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);'>You have already joined the session.</div>");
          }

          out.println("<div class='form-actions' style='margin-top:22px;'>");
          out.println("<button type='button' class='btn btn-secondary' onclick=\"window.location.href='search_sessions.jsp'\">Back to Search Sessions</button>");
          out.println("</div>");

          disableResult.close();
          alreadyInResult.close();
          stmt1.close();
          stmt2.close();
          con.close();

        } catch (SQLException e) {
          out.println("<h1 class='form-title'>Something went wrong</h1>");
          out.println("<p class='form-subtitle'>There was a database error while joining the session.</p>");
          out.println("<div style='margin-top:18px; padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);'>SQLException caught: " + e.getMessage() + "</div>");
          out.println("<div class='form-actions' style='margin-top:22px;'>");
          out.println("<button type='button' class='btn btn-secondary' onclick=\"window.location.href='search_sessions.jsp'\">Back to Search Sessions</button>");
          out.println("</div>");
        }
      %>

    </div>
  </div>
</div>

</body>
</html>