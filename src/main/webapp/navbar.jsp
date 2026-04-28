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

      <% if ("student".equals(role)) { %>
        <a class="nav-link" href="create_session.jsp">Create Session</a>
        <a class="nav-link" href="search_sessions.jsp">Search Session</a>
        <a class="nav-link" href="view_sessions.jsp">My Sessions</a>
        <a class="nav-link" href="student_view_course.jsp">View Courses</a>
        <a class="nav-link" href="student_view_room.jsp">View Rooms</a>
      <% } %>

      <% if ("admin".equals(role)) { %>
        <a class="nav-link" href="admin_dashboard.jsp">Dashboard</a>
        <a class="nav-link" href="admin_locations.jsp">Locations</a>
        <a class="nav-link" href="admin_courses.jsp">Courses</a>
        <a class="nav-link" href="search_user.jsp">Search Users</a>
      <% } %>

      <% if (role != null) { %>
        <a class="nav-link" href="logout.jsp" style="margin-left: 12px;">Log Out</a>
      <% } %>
    </div>
  </div>
</nav>