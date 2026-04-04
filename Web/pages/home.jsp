<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Home - Study Session</title>

<style>
  :root {
    --bg: #f6f7fb;
    --panel: rgba(255, 255, 255, 0.82);
    --text: #172033;
    --muted: #64708a;
    --line: rgba(23, 32, 51, 0.08);
    --accent: #4f46e5;
    --accent-soft: rgba(79, 70, 229, 0.12);
    --shadow: 0 18px 45px rgba(23, 32, 51, 0.08);
    --radius: 24px;
  }

  * { box-sizing: border-box; }

  body {
    margin: 0;
    font-family: Inter, system-ui, sans-serif;
    color: var(--text);
    background:
      radial-gradient(circle at top left, rgba(79,70,229,0.08), transparent 30%),
      linear-gradient(180deg, #fafbff 0%, #f4f6fb 100%);
  }

  .container {
    width: min(1120px, calc(100% - 32px));
    margin: 0 auto;
  }

  .nav {
    backdrop-filter: blur(14px);
    background: rgba(246,247,251,0.72);
    border-bottom: 1px solid var(--line);
  }

  .nav-inner {
    display: flex;
    justify-content: space-between;
    padding: 16px 0;
  }

  .brand {
    display: flex;
    gap: 12px;
    font-weight: 700;
  }

  .brand-badge {
    width: 40px;
    height: 40px;
    border-radius: 14px;
    display: grid;
    place-items: center;
    background: linear-gradient(135deg,#4f46e5,#2563eb);
    color: white;
  }

  .btn {
    padding: 12px 18px;
    border-radius: 14px;
    font-weight: 600;
    border: none;
    cursor: pointer;
  }

  .btn-primary {
    background: linear-gradient(135deg,#4f46e5,#2563eb);
    color: white;
  }

  .grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 18px;
    margin-top: 40px;
  }

  .card {
    background: var(--panel);
    border: 1px solid var(--line);
    border-radius: var(--radius);
    padding: 24px;
    box-shadow: var(--shadow);
  }

  .card h3 {
    margin: 0 0 10px;
  }

  .card p {
    color: var(--muted);
    margin-bottom: 16px;
  }
</style>
</head>

<body>

<nav class="nav">
  <div class="container nav-inner">
    <div class="brand">
      <div class="brand-badge">SS</div>
      Study Session
    </div>
  </div>
</nav>

<div class="container">
  <h1 style="margin-top:40px;">Welcome back</h1>
  <p style="color:var(--muted);">Access your study tools and sessions.</p>

  <div class="grid">
    <div class="card">
      <h3>Search Sessions</h3>
      <p>Find study sessions by department or topic.</p>
      <button class="btn btn-primary" onclick="location.href='search.jsp'">Open</button>
    </div>

    <div class="card">
      <h3>My Sessions</h3>
      <p>View sessions you joined or created.</p>
      <button class="btn btn-primary" onclick="location.href='my-sessions.jsp'">Open</button>
    </div>

    <div class="card">
      <h3>Create Session</h3>
      <p>Start a new study session.</p>
      <button class="btn btn-primary" onclick="location.href='create-session.jsp'">Create</button>
    </div>

    <div class="card">
      <h3>Profile</h3>
      <p>Manage your account details.</p>
      <button class="btn btn-primary" onclick="location.href='profile.jsp'">View</button>
    </div>

    <div class="card">
      <h3>Dashboard</h3>
      <p>Quick navigation hub.</p>
      <button class="btn btn-primary" onclick="location.href='dashboard.jsp'">Open</button>
    </div>

    <div class="card">
      <h3>Admin</h3>
      <p>Manage users and sessions.</p>
      <button class="btn btn-primary" onclick="location.href='admin.jsp'">Open</button>
    </div>
  </div>
</div>

</body>
</html>