<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Study Session Details</title>
  <link rel="stylesheet" href="css/global.css">
</head>
<body>

<%@ include file="navbar.jsp" %>

<div class="page-shell">
  <div class="container">
    <div class="form-card" style="max-width: 760px;">

      <%
        //
        // first section is just getting the session information, should be the same for both user and admin
        //
        String sessionID = request.getParameter("sessionID");
        int userID = (Integer) session.getAttribute("userID");

        String query = "SELECT * FROM studysession WHERE SessionID = '" + sessionID + "'";
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

          Statement stmt = con.createStatement();
          ResultSet rs = stmt.executeQuery(query);
          
          String roomQuery = "SELECT BuildingName, RoomID FROM takesplacein WHERE SessionID = " + sessionID;
          Statement roomStmt = con.createStatement();
          ResultSet roomRs = roomStmt.executeQuery(roomQuery);

          if (rs.next()) {
        	roomRs.next(); //move the pointer to the first entry (should be the only entry)
            out.println("<h1 class='form-title' style='margin-bottom: 10px;'>" + rs.getString(2) + "</h1>");
            out.println("<p class='form-subtitle' style='margin-bottom: 18px;'>Review the session details below.</p>");

            out.println("<div class='panel' style='margin-bottom: 18px;'>");
            out.println("<div class='grid grid-2'>");
            out.println("<div><strong>Session ID</strong><p class='muted' style='margin:6px 0 0;'>" + rs.getInt(1) + "</p></div>");
            out.println("<div><strong>Date</strong><p class='muted' style='margin:6px 0 0;'>" + rs.getDate(5) + "</p></div>");
            out.println("<div><strong>Start Time</strong><p class='muted' style='margin:6px 0 0;'>" + rs.getTime(3) + "</p></div>");
            out.println("<div><strong>End Time</strong><p class='muted' style='margin:6px 0 0;'>" + rs.getTime(4) + "</p></div>");
            out.println("<div><strong>Capacity</strong><p class='muted' style='margin:6px 0 0;'>" + rs.getInt(6) + "</p></div>");
            out.println("<div><p class='muted' style='margin:6px 0 0;'></p></div>");
            out.println("<div><strong>Building</strong><p class='muted' style='margin:6px 0 0;'>" + roomRs.getString(1) + "</p></div>");
            out.println("<div><strong>Room</strong><p class='muted' style='margin:6px 0 0;'>" + roomRs.getInt(2) + "</p></div>");
            out.println("</div>");
            out.println("</div>");

            out.println("<div class='panel' style='margin-bottom: 18px;'>");
            out.println("<strong>Description</strong>");
            out.println("<p class='muted' style='margin:8px 0 0; line-height:1.7;'>" + rs.getString(7) + "</p>");
            out.println("</div>");
          }

          String permission = (String) session.getAttribute("role");

          //
          // second section: student join action
          //
          if ("student".equals(permission)) {
            rs.close();
            stmt.close();

            int current = 0;
            Statement curStmt = con.createStatement();
            ResultSet rs2 = curStmt.executeQuery("SELECT COUNT(StudentUserID) FROM joins WHERE sessionID = " + sessionID);

            int max = 0;
            Statement maxStmt = con.createStatement();
            ResultSet rs3 = maxStmt.executeQuery("SELECT Capacity FROM studysession WHERE SessionID = " + sessionID);

            if (rs2.next()) {
              current = rs2.getInt(1);
            }
            if (rs3.next()) {
              max = rs3.getInt(1);
            }

            out.println("<div class='form-actions' style='margin-top: 12px;'>");

            if (current < max) {
              out.println("<button type='button' class='btn btn-primary' onclick=\"window.location.href='join_intermediate.jsp?sessionID=" + sessionID + "&userID=" + userID + "'\">Join Session</button>");
            } else {
              out.println("<button type='button' class='btn btn-danger' disabled>Max Capacity</button>");
            }

            out.println("<button type='button' class='btn btn-secondary' onclick=\"window.location.href='search_sessions.jsp'\">Back to Search</button>");
            out.println("</div>");

            rs2.close();
            rs3.close();
            curStmt.close();
            maxStmt.close();
          }

          //
          // third section: admin delete action
          //
          if ("admin".equals(permission)) {
            out.println("<div class='panel' style='margin-top: 20px;'>");
            out.println("<h2 style='margin:0 0 10px; font-size:22px; letter-spacing:-0.02em;'>Admin Action</h2>");
            out.println("<p class='muted' style='margin:0 0 14px;'>Provide a reason if you want to delete this session.</p>");
            out.println("<form action='delete_intermediate.jsp' method='post'>");
            out.println("<input type='hidden' name='sessionID' value='" + sessionID + "' />");
            out.println("<input type='hidden' name='userID' value='" + userID + "' />");
            out.println("<div class='field'>");
            out.println("<label for='deleteReason'>Reason</label>");
            out.println("<input type='text' id='deleteReason' name='deleteReason' maxlength='200' value='bad behavior' />");
            out.println("</div>");
            out.println("<div class='form-actions'>");
            out.println("<button type='submit' class='btn btn-danger'>Delete Session</button>");
            out.println("<button type='button' class='btn btn-secondary' onclick=\"window.location.href='search_sessions.jsp'\">Back to Search</button>");
            out.println("</div>");
            out.println("</form>");
            out.println("</div>");
          }

          con.close();
        } catch (SQLException e) {
          out.println("<h1 class='form-title'>Something went wrong</h1>");
          out.println("<p class='form-subtitle'>There was a database error while loading this session.</p>");
          out.println("<div style='margin-top:18px; padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);'>SQLException caught: " + e.getMessage() + "</div>");
          out.println("<div class='form-actions' style='margin-top:22px;'>");
          out.println("<button type='button' class='btn btn-secondary' onclick=\"window.location.href='search_sessions.jsp'\">Back to Search</button>");
          out.println("</div>");
        }
      %>

    </div>
  </div>
</div>

</body>
</html>