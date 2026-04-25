<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Leave Session</title>
<link rel="stylesheet" href="css/global.css">
</head>
<body>

<%@ include file="navbar.jsp" %>

<div class="page-shell">
  <div class="container">
    <div class="form-card">

<%
        int userID = Integer.parseInt(request.getParameter("userID"));
        int sessionID = Integer.parseInt(request.getParameter("sessionID"));

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

            String sql = "DELETE FROM joins WHERE sessionID=? AND StudentUserID=?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, sessionID);
            ps.setInt(2, userID);

            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                out.println("<h1 class='form-title'>You left the session</h1>");
                out.println("<p class='form-subtitle'>Successfully left session with Session ID: " + sessionID + ".</p>");
                out.println("<div style='margin-top:18px; padding:12px 14px; border-radius:14px; background:#f4f8f6; color:#0f766e; border:1px solid rgba(15,118,110,0.18);'>Your session membership has been removed.</div>");
            } else {
                out.println("<h1 class='form-title'>No matching session found</h1>");
                out.println("<p class='form-subtitle'>We could not find a joined session matching that request.</p>");
                out.println("<div style='margin-top:18px; padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);'>No matching record found.</div>");
            }

            out.println("<div class='form-actions' style='margin-top:22px;'>");
            out.println("<button type='button' class='btn btn-secondary' onclick=\"window.location.href='view_sessions.jsp'\">Back to My Sessions</button>");
            out.println("</div>");

            if (ps != null) ps.close();
            if (con != null) con.close();

        } catch(SQLException e) {
            out.println("<h1 class='form-title'>Something went wrong</h1>");
            out.println("<p class='form-subtitle'>There was a database error while leaving the session.</p>");
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