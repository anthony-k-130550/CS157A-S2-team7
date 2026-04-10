<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Admin Add Buildings</title>
  <link rel="stylesheet" href="css/global.css">
</head>
<body>

<%@ include file="navbar.jsp" %>

<div class="page-shell">
  <div class="container">
    <div class="card" style="margin-bottom: 24px;">
      <h1 class="form-title" style="margin-bottom: 8px;">Add Building</h1>
      <p class="form-subtitle" style="margin-bottom: 0;">
        Add a new building to the system so study sessions can be assigned to valid campus locations.
      </p>
    </div>

    <div class="form-card">
      <form method="post">
        <div class="field">
          <label for="Building">Building Name</label>
          <input type="text" id="Building" name="Building" required>
        </div>

        <div class="form-actions">
          <button type="submit" class="btn btn-primary">Add Building</button>
        </div>
      </form>

      <%
        String building = request.getParameter("Building");
        if (building != null) {
          String insert = "INSERT INTO building VALUES('" + building + "')";

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
            con.setAutoCommit(false);
            int rs = stmt.executeUpdate(insert);

            if (rs > 0) {
              con.commit();
              out.println("<div style='margin-top:18px; padding:12px 14px; border-radius:14px; background:#f4f8f6; color:#0f766e; border:1px solid rgba(15,118,110,0.18);'>Successfully added " + building + " to the buildings table.</div>");
            } else {
              con.rollback();
              out.println("<div style='margin-top:18px; padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);'>Failed to add " + building + " to the buildings table.</div>");
            }

            stmt.close();
            con.close();
          } catch(SQLException e) {
            out.println("<div style='margin-top:18px; padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);'>SQLException caught: " + e.getMessage() + "</div>");
          }
        }
      %>
    </div>
  </div>
</div>

</body>
</html>