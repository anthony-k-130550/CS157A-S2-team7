<%@ page import="java.sql.*"%>
<html>
<head>
  <title>Search Study Sessions</title>
</head>
<body>
<h1>Search Study Sessions</h1>

<form method="post">
	<!-- Department -->
	<label>Department:</label>
	<input type="text" name="department"><br><br>
	
	<!-- Class Number -->
	<label>Class Number:</label>
	<input type="number" name="classNumber" min = "1"><br><br>
	
	<!-- Day -->
	<label>Day:</label>
	<input type="date" name="day"><br><br>
	
	<!-- Building -->
	<label>Building Name:</label>
	<input type="text" name="buildingName"><br><br>
	
	<!-- Room ID -->	
	<label>Room ID:</label>
	<input type="number" name="roomID"><br><br>
	
	<button type="submit">Search Session</button>

</form>

<%
	//getting the role stored in login
	String permission = (String) session.getAttribute("role");
	//getting the filter parameters
	String dept = request.getParameter("department");
	String classNum = request.getParameter("classNumber");
	String day = request.getParameter("day");
	String building = request.getParameter("buildingName");
	String room = request.getParameter("roomID");
	
	
	/*out.println("<p>Department: " + dept + "</p>");
	out.println("<p>Class Number: " + classNum + "</p>");
	out.println("<p>Day: " + day + "</p>");
	out.println("<p>Building Name: " + building + "</p>");
	out.println("<p>Room ID: " + room + "</p>");*/
	
	//building the string based off of the chosen values
	StringBuilder query = new StringBuilder();
	query.append("SELECT * FROM studysession WHERE SessionID NOT IN (SELECT SessionID FROM deletes)"); //always making sure that the sessions are not in the deletes page
	if (!(dept == null || dept.isBlank())) {
		query.append("AND SessionID IN (SELECT SessionID FROM studyingfor WHERE CourseID IN (SELECT CourseID FROM course WHERE Department LIKE '%" + 
		dept + 
		"%'))");
	}
	
	//course number filter
	if (!(classNum == null || classNum.isBlank())) {
		query.append("AND SessionID IN (SELECT SessionID FROM studyingfor WHERE CourseID IN (SELECT CourseID FROM course WHERE CourseNumber = '" + 
		classNum + 
		"'))");
	}
	
	//day filter
	if (!(day == null || day.isBlank())) {
		query.append("AND Day = '" + day + "'");
	}
	
	
	//building filter
	if (!(building == null || building.isBlank())) {
		query.append("AND SessionID in (SELECT SessionID FROM takesplacein WHERE BuildingName LIKE '%" +
		building + 
		"%') AND EXISTS (SELECT * FROM building WHERE buildingName LIKE '%" + building + "%')"); //check to see if building is in the building list
	}
	
	//room filter
	if (!(room == null || room.isBlank())) {
		query.append("AND SessionID in (SELECT SessionID FROM takesplacein WHERE RoomID = '" +
		room + 
		"') AND EXISTS (SELECT * FROM room WHERE RoomID =" + room + ")");
	}
	
	String queryString = query.toString();
	
	String db = "project";
    String user;
    user = "root";
    String password = "CS157A";
    try {
        java.sql.Connection con;
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Project?autoReconnect=true&useSSL=false", user, password);

        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery(queryString);

        //header along with table definition
        out.println("<h1>Available Study Sessions</h1>");
        out.println("<table border = \"1\">");
        //title row of the table
        out.println("<tr>" + "<td>Session ID</td>" + 
            	"<td>Session Name</td>" + 
            	"<td>Start Time</td>"  + 
            	"<td>End Time</td>" +
            	"<td>Date</td>" +
            	"<td>Capacity</td>" +
            	"<td>Description</td>" +
            	"<td>Details</td>" +
            	"</tr>");
        
        //all the other rows
        while (rs.next()) {
        		out.println("<tr>" + "<td>" +  rs.getInt(1) + "</td>" + 
  	        	"<td>" + rs.getString(2) + "</td>" + 
  	        	"<td>" + rs.getTime(3) + "</td>"  + 
  	        	"<td>" + rs.getTime(4) + "</td>" +
  	        	"<td>" + rs.getDate(5) + "</td>" +
  	        	"<td>" + rs.getInt(6) + "</td>" +
	        	"<td>" + rs.getString(7) + "</td>" +
  	        	"<td><button onclick=\"window.location.href='individual_session_view.jsp?sessionID=" + rs.getInt(1) + "'\">Details</button></td>" + 
   	        	"</tr>");
   	           	out.println("<br>");
        }
        out.println("</table>");

        rs.close();
        stmt.close();
        con.close();
    } catch(SQLException e) {
        out.println("SQLException caught: " + e.getMessage());
    }



%>

</body>
</html>