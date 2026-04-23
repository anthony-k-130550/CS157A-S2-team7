<%
String role = (String) session.getAttribute("role");
%>

<nav class="nav-shell">
  <div class="container nav-inner">
    <a class="brand" href="userhome.jsp">
      <div class="brand-badge">SS</div>
      <span>Study Session</span>
    </a>

    <div class="nav-links">
      <a class="nav-link" href="userhome.jsp">Home</a>

      <% if (role == null) { %>
        <a class="nav-link" href="login.jsp">Log In</a>
        <a class="nav-link nav-link-primary" href="register.jsp">Register</a>
      <% } %>

      <% if ("student".equals(role) || "admin".equals(role)) { %>
        <a class="nav-link" href="create_session.jsp">Create Session</a>
        <a class="nav-link" href="search_sessions.jsp">Search Session</a>
        <a class="nav-link" href="view_sessions.jsp">My Sessions</a>
          <!-- NEW LINKS -->
  <a class="nav-link" href="view_courses.jsp">View Courses</a>
  <a class="nav-link" href="view_rooms.jsp">View Rooms</a>
      <% } %>

      <% if ("admin".equals(role)) { %>
        <a class="nav-link" href="admin_dashboard.jsp">Dashboard</a>
        <a class="nav-link" href="admin_add_buildings.jsp">Add Building</a>
        <a class="nav-link" href="admin_add_room.jsp">Add Room</a>
        <a class="nav-link" href="admin_add_course.jsp">Add Course</a>
        <a class="nav-link" href="search_user.jsp">Search Users</a>
      <% } %>
    </div>
  </div>
</nav>