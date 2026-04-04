<%
String role = (String) session.getAttribute("role");
%>

<div>
	 <a href="userhome.jsp" style="margin-right:15px;">Home</a>
	

	<% if (role == null) { %>
	  	<a href="login.jsp" style="margin-right:15px;">Log In</a>
        <a href="register.jsp" style="margin-right:15px;">Register</a>
	<% } %>
    <% if ("student".equals(role) ||"admin".equals(role)) { %>
       <a href="create_session.jsp" style="margin-right:15px;">Create Session</a>
       <a href="search_sessions.jsp" style="margin-right:15px;">Search Session</a>
       <a href="view_sessions.jsp" style="margin-right:15px;">My Sessions</a>
    <% } %>

    <% if ("admin".equals(role)) { %>
        <a href="admin_dashboard.jsp" style="margin-right:15px;">Dashboard</a>
        <a href="admin_add_buildings.jsp" style="margin-right:15px;">Add Room/Building</a>
        <a href="delete_sessions.jsp" style="margin-right:15px;">Search Users</a>
        
    <% } %>

</div>