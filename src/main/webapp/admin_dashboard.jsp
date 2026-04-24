<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Admin Dashboard</title>
  <link rel="stylesheet" href="css/global.css">
</head>
<body>

<%@ include file="navbar.jsp" %>

<div class="page-shell">
  <div class="container">

    <div class="card" style="margin-bottom: 24px;">
      <h1 class="form-title" style="margin-bottom: 10px;">Admin Dashboard</h1>
      <p class="form-subtitle" style="margin-bottom: 0;">
        Manage the platform, monitor users, and maintain study session infrastructure.
      </p>
    </div>

    <div class="grid grid-3">

      <div class="panel">
        <h2 style="margin: 0 0 10px; font-size: 20px; letter-spacing: -0.02em;">User Management</h2>
        <p class="muted" style="margin: 0; line-height: 1.7;">
          Search for users, review accounts, and disable users when necessary.
        </p>
      </div>

      <div class="panel">
        <h2 style="margin: 0 0 10px; font-size: 20px; letter-spacing: -0.02em;">Buildings & Rooms</h2>
        <p class="muted" style="margin: 0; line-height: 1.7;">
          Add buildings and rooms to support valid locations for study sessions.
        </p>
      </div>

      <div class="panel">
        <h2 style="margin: 0 0 10px; font-size: 20px; letter-spacing: -0.02em;">Session Oversight</h2>
        <p class="muted" style="margin: 0; line-height: 1.7;">
          Monitor sessions created by users and maintain data integrity across the system.
        </p>
      </div>

    </div>

    <div class="card" style="margin-top: 24px;">
      <h2 style="margin: 0 0 12px; font-size: 24px; letter-spacing: -0.02em;">Platform Overview</h2>
      <p class="muted" style="margin: 0; line-height: 1.8;">
        Study Session enables students to organize and join collaborative study groups based on shared courses.
        As an administrator, you are responsible for maintaining system structure, managing user access, and ensuring
        that sessions are organized within valid campus locations.
      </p>
    </div>

  </div>
</div>

</body>
</html>