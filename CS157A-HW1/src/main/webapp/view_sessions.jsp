\<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Sessions View</title>
<link rel="stylesheet" href="css/global.css">
</head>
<body>

<%@ include file="navbar.jsp" %>

<script>
function getReason(sessionID, userID) {
  let input = prompt("Enter reason:");

  if (input !== null && input.trim() !== "") {
    window.location.href = "delete_intermediate.jsp?sessionID="
      + sessionID + "&userID=" + userID + "&deleteReason=" + encodeURIComponent(input);
  } else {
    alert("Input required!");
  }
}
</script>

<div class="page-shell">
  <div class="container">
    <div class="card" style="margin-bottom: 24px;">
      <h1 class="form-title" style="margin-bottom: 8px;">My Sessions</h1>
      <p class="form-subtitle" style="margin-bottom: 0;">
        View the sessions you created and the sessions you joined. You can delete your own sessions or leave joined sessions.
      </p>
    </div>

<%
    String db = "project";
    String user;
    user = "root";
    String password = "CS157ALG";
    java.sql.Connection con = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project?autoReconnect=true&useSSL=false", user, password);

        Integer userID = (Integer) session.getAttribute("userID");

        out.println("<div class='card' style='margin-bottom: 24px;'>");
        out.println("<h2 style='margin:0 0 16px; font-size:24px; letter-spacing:-0.02em;'>Created Sessions</h2>");
        out.println("<div style='overflow-x:auto;'>");
        out.println("<table class='table'>");
        out.println("<thead>");
        out.println("<tr>");
        out.println("<th>SessionID</th>");
        out.println("<th>Title</th>");
        out.println("<th>Start Time</th>");
        out.println("<th>End Time</th>");
        out.println("<th>Day</th>");
        out.println("<th>Capacity</th>");
        out.println("<th>Description</th>");
        out.println("<th>Delete</th>");
        out.println("</tr>");
        out.println("</thead>");
        out.println("<tbody>");

        String sql = "SELECT us.* FROM studysession us JOIN creates s ON us.sessionID = s.sessionID WHERE s.StudentUserID = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, userID);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            String deletedQuery = "SELECT * FROM deletes WHERE SessionID=?";
            PreparedStatement psDeleted = con.prepareStatement(deletedQuery);
            psDeleted.setInt(1, rs.getInt(1));
            ResultSet rsDeleted = psDeleted.executeQuery();

            if (!rsDeleted.next()) {
                out.println("<tr>");
                out.println("<td>" + rs.getInt("sessionID") + "</td>");
                out.println("<td>" + rs.getString("title") + "</td>");
                out.println("<td>" + rs.getTime("startTime") + "</td>");
                out.println("<td>" + rs.getTime("endTime") + "</td>");
                out.println("<td>" + rs.getDate("day") + "</td>");
                out.println("<td>" + rs.getInt("capacity") + "</td>");
                out.println("<td>" + rs.getString("description") + "</td>");
                out.println("<td><button type='button' class='btn btn-danger' onclick=\"getReason(" + rs.getInt(1) + "," + userID + ")\">Delete</button></td>");
                out.println("</tr>");
            }

            if (psDeleted != null) psDeleted.close();
            if (rsDeleted != null) rsDeleted.close();
        }

        out.println("</tbody>");
        out.println("</table>");
        out.println("</div>");
        out.println("</div>");

        if (rs != null) rs.close();
        if (ps != null) ps.close();

        out.println("<div class='card'>");
        out.println("<h2 style='margin:0 0 16px; font-size:24px; letter-spacing:-0.02em;'>Joined Sessions</h2>");
        out.println("<div style='overflow-x:auto;'>");
        out.println("<table class='table'>");
        out.println("<thead>");
        out.println("<tr>");
        out.println("<th>SessionID</th>");
        out.println("<th>Title</th>");
        out.println("<th>Start Time</th>");
        out.println("<th>End Time</th>");
        out.println("<th>Day</th>");
        out.println("<th>Capacity</th>");
        out.println("<th>Description</th>");
        out.println("<th>Leave</th>");
        out.println("</tr>");
        out.println("</thead>");
        out.println("<tbody>");

        sql = "SELECT us.* FROM studysession us JOIN joins s ON us.sessionID = s.sessionID WHERE s.StudentUserID = ?";
        ps = con.prepareStatement(sql);
        ps.setInt(1, userID);
        rs = ps.executeQuery();

        while (rs.next()) {
            out.println("<tr>");
            out.println("<td>" + rs.getInt("sessionID") + "</td>");
            out.println("<td>" + rs.getString("title") + "</td>");
            out.println("<td>" + rs.getTime("startTime") + "</td>");
            out.println("<td>" + rs.getTime("endTime") + "</td>");
            out.println("<td>" + rs.getDate("day") + "</td>");
            out.println("<td>" + rs.getInt("capacity") + "</td>");
            out.println("<td>" + rs.getString("description") + "</td>");
            out.println("<td><button type='button' class='btn btn-secondary' onclick=\"window.location.href='leave_intermediate.jsp?sessionID="
                + rs.getInt(1) + "&userID=" + userID + "'\">Leave</button></td>");
            out.println("</tr>");
        }

        out.println("</tbody>");
        out.println("</table>");
        out.println("</div>");
        out.println("</div>");

        if (rs != null) rs.close();
        if (ps != null) ps.close();

    } catch(SQLException e) {
        out.println("<div class='card'><div style='padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);'>SQLException caught: " + e.getMessage() + "</div></div>");
        e.printStackTrace();
    } finally {
        if (con != null) {
            try { con.close(); } catch (Exception e) {}
        }
    }
%>

  </div>
</div>

</body>
</html>