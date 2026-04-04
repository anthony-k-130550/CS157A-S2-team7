<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.ResultSet" %>
<%@ include file="navbar.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Study Session</title>
</head>

<body>
<h1>Create Study Sessions</h1>

<form method="post">
	<!-- Department -->
	<label>Title:</label>
	<input type="text" name="title" required><br><br>
	
	<!-- Start Time -->
	<label>Start Time:</label>
	<input type="time" name="startTime"  min="08:00" max="22:00" required><br><br>
	
	<!-- End Time -->
	<label>End Time:</label>
	<input type="time" name="endTime"  min="08:00" max="22:00" required><br><br>
	
	<!-- Day -->
	<label>Day:</label>
	<input type="date" name="day" required><br><br>
	
	<!-- Capacity  -->	
	<label>Capacity:</label>
	<input type="number" name="capacity" min="1" max ="30" required><br><br>
	
	<label>Room:</label>
	<input type="number" name="room" required><br><br>
	
	<label>Building: </label>
	<input type="text" name="building" required><br><br>
	
	<label>Course: </label>
	<input type="text" name="course" required><br><br>
	
	<!-- Description -->
	<label>Description: </label>
	<input type="text" name="description"><br><br>
	
	
	<button type="submit">Create Session</button>

</form>

<%

if ("POST".equalsIgnoreCase(request.getMethod())) {
    // do insert here

	String title = request.getParameter("title");
	String startTime = request.getParameter("startTime");
	String endTime = request.getParameter("endTime");
	String day = request.getParameter("day");
	int capacity = Integer.parseInt(request.getParameter("capacity"));
	int room = Integer.parseInt(request.getParameter("room"));
	String building = request.getParameter("building");
	String course = request.getParameter("course");
	String description = request.getParameter("description");
	
	
	String db = "project";
    String user;
    user = "root";
    String password = "CS175ALG";
    java.sql.Connection con = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project?autoReconnect=true&useSSL=false", user, password);

        String sql = "SELECT 1 FROM room WHERE RoomID = ? AND BuildingName = ? LIMIT 1";
        String sql2 = "SELECT 1 FROM course WHERE CourseName = ? LIMIT 1";
        
        PreparedStatement ps = con.prepareStatement(sql);
        PreparedStatement ps2 = con.prepareStatement(sql2);

        
        ps.setInt(1, room);
        ps.setString(2, building);
        ps2.setString(1, course);
        
        ResultSet rs = ps.executeQuery();
        ResultSet rs2 = ps2.executeQuery();
        
        boolean roomExist = rs.next();
        boolean courseExist = rs2.next();
        
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (rs2 != null) rs2.close();
        if (ps2 != null) ps2.close();
        
        if(roomExist && courseExist){
        	
        	// 4. SQL INSERT (NO SessionID because AUTO_INCREMENT)
            sql = "INSERT INTO StudySession (Title, StartTime, EndTime, Day, Capacity, Description) VALUES (?, ?, ?, ?, ?, ?)";
    		
            // 5. Create PreparedStatement
            ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            // 6. Set values (ORDER MATTERS)
            ps.setString(1, title);
            ps.setString(2, startTime);
            ps.setString(3, endTime);
            ps.setString(4, day);
            ps.setInt(5, capacity);
            ps.setString(6, description);

            // 7. Execute
            int rows = ps.executeUpdate();
            
            rs = ps.getGeneratedKeys();

            int sessionId = -1;

            if (rs.next()) {
                sessionId = rs.getInt(1);
            }
            
         
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            
            
            // 8. Check result
            if (rows > 0) {
                out.println("<p style='color:green;'>Session inserted successfully!</p>");
            } else {
                out.println("<p style='color:red;'>Insert failed.</p>");
            }
    	
            //Get the course ID
            sql = "SELECT CourseID FROM course WHERE CourseName = ?";
            
            ps = con.prepareStatement(sql);
            ps.setString(1, course);
           	rs = ps.executeQuery();
           	
           	int courseID = -1; 
           	
           	if(rs.next()){
           		courseID = rs.getInt("CourseID");
           	}
           	
           	if (rs != null) rs.close();
           	if (ps != null) ps.close();
            
            //Updat StydinFor Table 
            
            
            
            sql = "INSERT INTO studyingfor (SessionID, CourseID) VALUES (?, ?)";
            ps = con.prepareStatement(sql);
            ps.setInt(1, sessionId);
            ps.setInt(2, courseID);
            rows = ps.executeUpdate();
            
            if (rows > 0) {
                out.println("<p style='color:green;'>stuyingfor upadted</p>");
            } else {
                out.println("<p style='color:red;'> failed stuyingfor.</p>");
            }
            
        
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            
            //Upddate TakePlaceInt
            
            sql = "INSERT INTO takesplacein (RoomID, BuildingName, SessionID) VALUES (?, ?, ?)";
            ps = con.prepareStatement(sql);
            ps.setInt(1, room);
            ps.setString(2, building);
            ps.setInt(3, sessionId);
            
            rows = ps.executeUpdate();
            
            if (rows > 0) {
                out.println("<p style='color:green;'>takesplacein upadted</p>");
            } else {
                out.println("<p style='color:red;'> failed takesplacein.</p>");
            }
            
      
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            
            
            //Update the crates tables
            sql = "INSERT INTO creates (StudentUserID, SessionID, SuccessStatus) VALUES (?, ?, ?)";
            ps = con.prepareStatement(sql);
            Integer userID = (Integer) session.getAttribute("userID");
            ps.setInt(1, userID);
            ps.setInt(2,sessionId);
            ps.setString(3, "successfully created");
            
			rows = ps.executeUpdate();
            
            if (rows > 0) {
                out.println("<p style='color:green;'>Creates table upadted</p>");
            } else {
                out.println("<p style='color:red;'> failed to update Creates table.</p>");
            }
            
            
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            //after submitting redirecting to userhome for now
            response.sendRedirect("userhome.jsp");
           
           
        }
        else if(!roomExist || !courseExist){
        	if(!roomExist){
        		 out.println("<p style='color:red;'>Entered Room/Buidling does not exist.</p>");
        	}
        	if(!courseExist){
       		 out.println("<p style='color:red;'>Entered Course does not exist.</p>");
       		}
            out.println("<p style='color:red;'>Insert failed.</p>");

       }
     

    } catch(SQLException
    		e) {
    	out.println("SQLException caught: " + e.getMessage());
    	e.printStackTrace();
    }  finally {
        if (con != null) {
            try { con.close(); } catch (Exception e) {}
        }
    }
	
}
%>

</body>
</html>