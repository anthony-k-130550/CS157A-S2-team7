<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Dashboard</title>

<style>
  :root {
    --panel: rgba(255,255,255,0.82);
    --text: #172033;
    --muted: #64708a;
    --line: rgba(23,32,51,0.08);
    --accent: #4f46e5;
    --shadow: 0 18px 45px rgba(23,32,51,0.08);
    --radius: 22px;
  }

  body {
    margin:0;
    font-family: Inter, sans-serif;
    background:#f4f6fb;
    color:var(--text);
  }

  .container {
    width: min(1120px, calc(100% - 32px));
    margin: 50px auto;
  }

  h1 {
    margin-bottom: 10px;
  }

  .grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 18px;
    margin-top: 30px;
  }

  .card {
    background: var(--panel);
    border: 1px solid var(--line);
    border-radius: var(--radius);
    padding: 22px;
    box-shadow: var(--shadow);
  }

  .card h3 {
    margin-bottom: 8px;
  }

  .card p {
    color: var(--muted);
    margin-bottom: 14px;
  }

  .btn {
    padding: 10px 14px;
    border-radius: 10px;
    border: none;
    background: var(--accent);
    color: white;
    font-weight: 600;
    cursor: pointer;
  }

  @media (max-width: 900px) {
    .grid {
      grid-template-columns: 1fr;
    }
  }
</style>
</head>

<body>

<div class="container">
  <h1>Dashboard</h1>
  <p style="color:var(--muted);">Quick access to core features.</p>

  <div class="grid">
    <div class="card">
      <h3>Search Sessions</h3>
      <p>Browse available sessions.</p>
      <button class="btn" onclick="location.href='search.jsp'">Open</button>
    </div>

    <div class="card">
      <h3>My Sessions</h3>
      <p>View your sessions.</p>
      <button class="btn" onclick="location.href='my-sessions.jsp'">Open</button>
    </div>

    <div class="card">
      <h3>Create Session</h3>
      <p>Start a new session.</p>
      <button class="btn" onclick="location.href='create-session.jsp'">Create</button>
    </div>

    <div class="card">
      <h3>Profile</h3>
      <p>Manage your account.</p>
      <button class="btn" onclick="location.href='profile.jsp'">View</button>
    </div>

    <div class="card">
      <h3>Admin Panel</h3>
      <p>Administrative controls.</p>
      <button class="btn" onclick="location.href='admin.jsp'">Open</button>
    </div>

    <div class="card">
      <h3>Home</h3>
      <p>Return to main hub.</p>
      <button class="btn" onclick="location.href='home.jsp'">Go</button>
    </div>
  </div>
</div>

</body>
</html>