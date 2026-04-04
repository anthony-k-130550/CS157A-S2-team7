<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Admin Panel</title>
<link rel="stylesheet" href="../css/main.css">
</head>

<body>

<nav class="nav">
  <div class="container nav-inner">
    <a class="brand" href="home.jsp">
      <div class="brand-badge">SS</div>
      Study Session
    </a>
  </div>
</nav>

<div class="container" style="margin-top:40px;">

  <h1>Admin Panel</h1>
  <p class="muted">Manage users and study sessions.</p>

  <!-- USERS -->
  <div style="margin-top:30px;">
    <h2>Users</h2>

    <div class="card" style="margin-top:12px;">
      <div style="display:flex; justify-content:space-between; align-items:center;">
        <div>
          <strong>john@email.com</strong>
          <div class="muted">Computer Science</div>
        </div>

        <!-- disable button -->
        <button class="btn btn-danger">Disable</button>
      </div>
    </div>
  </div>

  <!-- SESSIONS -->
  <div style="margin-top:30px;">
    <h2>Sessions</h2>

    <div class="card" style="margin-top:12px;">
      <div style="display:flex; justify-content:space-between; align-items:center;">
        <div>
          <strong>Math Study Group</strong>
          <div class="muted">April 10</div>
        </div>

        <!-- delete session -->
        <button class="btn btn-danger">Delete</button>
      </div>
    </div>
  </div>

</div>

</body>
</html>