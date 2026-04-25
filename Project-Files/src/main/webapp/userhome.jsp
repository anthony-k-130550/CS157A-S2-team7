<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Student Home Page</title>
  <link rel="stylesheet" href="css/global.css">
</head>
<body>

<%@ include file="navbar.jsp" %>

<div class="page-shell">
  <div class="container">
    <div class="card">
      <h1 class="form-title" style="margin-bottom: 10px;">Welcome to Study Session</h1>
      <p class="form-subtitle" style="margin-bottom: 0;">
        This platform helps you connect with classmates taking the same courses and build study groups in one place.
      </p>
    </div>

    <div class="grid grid-3" style="margin-top: 24px;">
      <div class="panel">
        <h2 style="margin: 0 0 10px; font-size: 22px; letter-spacing: -0.02em;">Find sessions</h2>
        <p class="muted" style="margin: 0; line-height: 1.7;">
          Search for study sessions that match your subjects, courses, and schedule.
        </p>
      </div>

      <div class="panel">
        <h2 style="margin: 0 0 10px; font-size: 22px; letter-spacing: -0.02em;">Create your own</h2>
        <p class="muted" style="margin: 0; line-height: 1.7;">
          Start a study session and invite other students to join based on course needs.
        </p>
      </div>

      <div class="panel">
        <h2 style="margin: 0 0 10px; font-size: 22px; letter-spacing: -0.02em;">Stay organized</h2>
        <p class="muted" style="margin: 0; line-height: 1.7;">
          Manage your sessions and keep track of the study groups you join.
        </p>
      </div>
    </div>

    <div class="card" style="margin-top: 24px;">
      <h2 style="margin: 0 0 12px; font-size: 24px; letter-spacing: -0.02em;">What you can do here</h2>
      <p class="muted" style="margin: 0; line-height: 1.8;">
        You will be able to find study groups that match the subjects and specific courses you are taking, connect with peers,
        and participate in collaborative study sessions more easily.
      </p>
    </div>
  </div>
</div>

<%
 // added this just for testing purposes
%>

</body>
</html>