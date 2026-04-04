<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Session Details</title>
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

<div class="container" style="margin-top:40px; max-width:800px;">

  <div class="card">
    <h1>Math Study Group</h1>

    <p class="muted" style="margin-top:10px;">
      Department: Mathematics<br>
      Date: April 10<br>
      Location: Building A · Room 101
    </p>

    <div style="margin-top:20px;">
      <strong>Description</strong>
      <p class="muted">
        Review calculus topics and prepare for upcoming exams.
      </p>
    </div>

    <!-- ACTION BUTTONS -->
    <div style="margin-top:30px; display:flex; gap:12px; flex-wrap:wrap;">

      <!-- student actions -->
      <button class="btn btn-primary">Join Session</button>
      <button class="btn btn-secondary">Leave Session</button>

      <!-- admin / owner action -->
      <button class="btn btn-danger">Delete Session</button>

    </div>

  </div>

</div>

</body>
</html>