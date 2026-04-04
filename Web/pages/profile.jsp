<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Profile</title>
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

<div class="container" style="margin-top:40px; max-width:700px;">

  <div class="card">

    <h1>My Profile</h1>
    <p class="muted">Account details and settings.</p>

    <div style="margin-top:20px;">

      <div class="field">
        <label>Full Name</label>
        <div>John Doe</div>
      </div>

      <div class="field">
        <label>Email</label>
        <div>john@email.com</div>
      </div>

      <div class="field">
        <label>Department</label>
        <div>Computer Science</div>
      </div>

      <div class="field">
        <label>Role</label>
        <div>Student</div>
      </div>

    </div>

    <div style="margin-top:30px; display:flex; gap:12px;">
      <button class="btn btn-primary">Edit Profile</button>
      <button class="btn btn-danger">Disable Account</button>
    </div>

  </div>

</div>

</body>
</html>