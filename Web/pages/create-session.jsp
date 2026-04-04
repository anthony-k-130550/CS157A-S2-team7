<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Create Session</title>
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

<div class="container" style="margin-top:40px; max-width:600px;">
  
  <div class="card">
    <h1>Create Session</h1>
    <p class="muted">Fill in session details.</p>

    <!-- READY FOR SERVLET -->
    <form>

      <div class="field">
        <label>Title</label>
        <input type="text">
      </div>

      <div class="field">
        <label>Department</label>
        <input type="text">
      </div>

      <div class="field">
        <label>Building</label>
        <input type="text">
      </div>

      <div class="field">
        <label>Room</label>
        <input type="text">
      </div>

      <div class="field">
        <label>Date</label>
        <input type="date">
      </div>

      <button class="btn btn-primary" style="margin-top:20px; width:100%;">
        Create Session
      </button>

    </form>

  </div>
</div>

</body>
</html>