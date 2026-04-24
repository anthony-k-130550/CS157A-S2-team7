<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Study Session</title>
  <link rel="stylesheet" href="css/global.css">
</head>
<body>
  <nav class="nav">
    <div class="container nav-inner">
      <a class="brand" href="#home">
        <div class="brand-badge">SS</div>
        <span>Study Session</span>
      </a>

      <div class="nav-links">
        <a href="#features">Features</a>
        <a href="#how-it-works">How it works</a>
        <a href="#roles">User roles</a>
      </div>

      <div class="nav-actions">
        <a class="btn btn-secondary" href="login.jsp">Login</a>
        <a class="btn btn-primary" href="register.jsp">Register</a>
      </div>
    </div>
  </nav>

  <main id="home">
    <section class="hero">
      <div class="container hero-grid">
        <div>
          <div class="eyebrow">Connect. Organize. Study better.</div>
          <h1>Find and create study sessions with classmates in one place.</h1>
          <p>
            Study Session helps students connect with peers taking the same courses,
            create study groups, and join sessions based on subject, course, and location.
          </p>

          <div class="hero-actions">
            <a class="btn btn-primary" href="register.jsp">Create Account</a>
            <a class="btn btn-secondary" href="login.jsp">Sign In</a>
          </div>

          <div class="hero-stats">
            <div class="stat">
              <strong>Students</strong>
              <span>Create accounts and join sessions that match their courses.</span>
            </div>
            <div class="stat">
              <strong>Sessions</strong>
              <span>Search, create, and manage study sessions.</span>
            </div>
            <div class="stat">
              <strong>Admins</strong>
              <span>Manage users, locations, and system data.</span>
            </div>
          </div>
        </div>

        <div class="hero-card">
          <div class="card-header">
            <div>
              <strong style="font-size: 20px;">Platform Overview</strong>
              <div style="color: var(--muted); margin-top: 6px; font-size: 14px;">
                Designed for student collaboration
              </div>
            </div>
            <span class="pill">Live</span>
          </div>

          <div class="session-card">
            <div class="session-top">
              <div class="session-title">Core actions</div>
              <span class="pill" style="background:#eefcf5; color:#0f766e;">Active</span>
            </div>

            <div class="session-meta">
              <div><strong>Create</strong><br />Start sessions</div>
              <div><strong>Search</strong><br />Find sessions</div>
              <div><strong>Join</strong><br />Collaborate</div>
              <div><strong>Manage</strong><br />Track activity</div>
            </div>

            <div class="session-note">
              A simple system for organizing and joining study groups.
            </div>
          </div>
        </div>
      </div>
    </section>

    <section class="section" id="features">
      <div class="container">
        <div class="section-heading">
          <div>
            <h2>Features</h2>
            <p>
              Everything needed to organize and manage study sessions in one place.
            </p>
          </div>
        </div>

        <div class="cards">
          <article class="feature-card">
            <div class="icon">1</div>
            <h3>Account Access</h3>
            <p>Create an account and securely log in to access the platform.</p>
          </article>

          <article class="feature-card">
            <div class="icon">2</div>
            <h3>Session Management</h3>
            <p>Create sessions, search by filters, and join study groups.</p>
          </article>

          <article class="feature-card">
            <div class="icon">3</div>
            <h3>Admin Controls</h3>
            <p>Manage users, buildings, rooms, and system structure.</p>
          </article>
        </div>
      </div>
    </section>

    <section class="section" id="how-it-works">
      <div class="container two-col">
        <div class="panel">
          <h2 style="font-size: 28px;">How it works</h2>

          <div class="list">
            <div class="list-item">
              <div class="list-number">1</div>
              <div>
                <strong>Create an account</strong>
                <span>Register to access the platform.</span>
              </div>
            </div>

            <div class="list-item">
              <div class="list-number">2</div>
              <div>
                <strong>Log in</strong>
                <span>Access your dashboard.</span>
              </div>
            </div>

            <div class="list-item">
              <div class="list-number">3</div>
              <div>
                <strong>Search or create sessions</strong>
                <span>Find or start study groups.</span>
              </div>
            </div>

            <div class="list-item">
              <div class="list-number">4</div>
              <div>
                <strong>Join and collaborate</strong>
                <span>Study with others in your courses.</span>
              </div>
            </div>
          </div>
        </div>

        <div class="panel" id="roles">
          <h2 style="font-size: 28px;">User roles</h2>

          <div class="list">
            <div class="list-item">
              <div class="list-number">S</div>
              <div>
                <strong>Students</strong>
                <span>Create and join sessions.</span>
              </div>
            </div>

            <div class="list-item">
              <div class="list-number">A</div>
              <div>
                <strong>Admins</strong>
                <span>Manage users and system data.</span>
              </div>
            </div>

            <div class="list-item">
              <div class="list-number">C</div>
              <div>
                <strong>Courses</strong>
                <span>Sessions are linked to courses.</span>
              </div>
            </div>

            <div class="list-item">
              <div class="list-number">L</div>
              <div>
                <strong>Locations</strong>
                <span>Sessions take place in buildings and rooms.</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section class="cta">
      <div class="container">
        <div class="cta-box">
          <div>
            <h2 style="margin:0;">Get started</h2>
            <p>Create an account and start organizing study sessions.</p>
          </div>

          <div style="display:flex; gap:12px;">
            <a class="btn btn-primary" href="register.jsp">Register</a>
            <a class="btn btn-secondary" href="login.jsp">Login</a>
          </div>
        </div>
      </div>
    </section>
  </main>

  <footer class="footer">
    <div class="container">
      Study Session · Student collaboration platform
    </div>
  </footer>
</body>
</html>