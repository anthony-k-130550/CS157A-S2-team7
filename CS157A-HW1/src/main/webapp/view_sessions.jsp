<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="navbar.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

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
 


<table border="1">
    <thead>
        <tr>
            <th>SessionID</th>
            <th>Title</th>
            <th>Start Time</th>
            <th>End Time</th>
            <th>Day</th>
            <th>Capacity</th>
            <th>Description</th>
            <th>Delete</th>
        </tr>
    </thead>
    <tbody>

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
        
    	out.println("<h1>CREATED</h1>");

        //Get session created by the user
		        
		String sql = "SELECT us.* FROM studysession us JOIN creates s ON us.sessionID = s.sessionID WHERE s.StudentUserID = ?";
		
        PreparedStatement ps = con.prepareStatement(sql);
        
        ps.setInt(1, userID);
        
        ResultSet rs = ps.executeQuery();
        
        Statement stmt = con.createStatement();
        
       
        
        //Display session created by the user
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
            out.println("<td><button onclick=\"getReason(" + rs.getInt(1) + "," + userID + ")\">Delete</button></td>");
            out.println("</tr>");
            }
            if(psDeleted != null) psDeleted.close();
            if(rsDeleted != null) rsDeleted.close();
			
        }
        
        out.println("</tbody>");
        out.println("</table>");
		
        if(rs != null) rs.close();
        if(ps != null) ps.close();
        
    	out.println("<h1>JOINED</h1>");
    	
		sql = "SELECT us.* FROM studysession us JOIN joins s ON us.sessionID = s.sessionID WHERE s.StudentUserID = ?";
		
        ps = con.prepareStatement(sql);
        
        ps.setInt(1, userID);
        
        rs = ps.executeQuery();
        
        
        out.println("<table border='1'>");
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
        
        //Display session created by the user
        while (rs.next()) {
        	out.println("<tr>");
            out.println("<td>" + rs.getInt("sessionID") + "</td>");
            out.println("<td>" + rs.getString("title") + "</td>");
            out.println("<td>" + rs.getTime("startTime") + "</td>");
            out.println("<td>" + rs.getTime("endTime") + "</td>");
            out.println("<td>" + rs.getDate("day") + "</td>");
            out.println("<td>" + rs.getInt("capacity") + "</td>");
            out.println("<td>" + rs.getString("description") + "</td>");
            out.println("<td><button onclick=\"window.location.href='leave_intermediate.jsp?sessionID=" 
            	    + rs.getInt(1) + "&userID=" + userID + "'\">Leave</button></td>");
            out.println("</tr>");
        }
        
        out.println("</tbody>");
        out.println("</table>");
		
        if(rs != null) rs.close();
        if(ps != null) ps.close();

        
        
    }catch(SQLException
    		e) {
    	out.println("SQLException caught: " + e.getMessage());
    	e.printStackTrace();
    }  finally {
        if (con != null) {
            try { con.close(); } catch (Exception e) {}
        }
    }
	

%>

</body>
</html>