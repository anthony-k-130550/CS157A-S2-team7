<%@ page import="java.sql.*"%>
<html>
<head>
  <title>View Available Rooms</title>
</head>
<body>
<h1>Room List</h1>

<table border="1">
  <tr>
    <td>Building Name</td>
    <td>Room ID</td>
  </tr>
    <%
        String user; // assumes database name is the same as username
        user = "root";
        String password = "CS157ALG";
        try {
            java.sql.Connection con;
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project?autoReconnect=true&useSSL=false", user, password);

            Statement stmt = con.createStatement();

            ResultSet rs = stmt.executeQuery("SELECT * FROM room");

            while (rs.next()) {
               out.println("<tr>" + "<td>" +  rs.getString(2) + "</td>"+ "<td>" +  rs.getInt(1) + "</td>" + "</tr>");
            }
            rs.close();
            stmt.close();
            con.close();
        } catch(SQLException e) {
            out.println("SQLException caught: " + e.getMessage());
        }
    %>
    </table>
</body>
</html>