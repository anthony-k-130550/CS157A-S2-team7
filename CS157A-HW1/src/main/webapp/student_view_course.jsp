<%@ page import="java.sql.*"%>
<html>
<head>
  <title>View Available Courses</title>
</head>
<body>
<h1>Course List</h1>

<table border="1">
  <tr>
    <td>Course ID</td>
    <td>Department</td>
    <td>Course Number</td>
    <td>Course Name</td>
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

            ResultSet rs = stmt.executeQuery("SELECT * FROM course");

            while (rs.next()) {
               out.println("<tr>" + "<td>" +  rs.getInt(1) + "</td>"+ "<td>" +    rs.getString(2) + "</td>"+ "<td>" + rs.getString(3) + "</td>"
            	+ "<td>" + rs.getString(4) + "</td>" + "</tr>");
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