<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Study Session</title>
  <style>
    :root {
      --bg: #f6f7fb;
      --panel: rgba(255, 255, 255, 0.82);
      --panel-strong: #ffffff;
      --text: #172033;
      --muted: #64708a;
      --line: rgba(23, 32, 51, 0.08);
      --accent: #4f46e5;
      --accent-soft: rgba(79, 70, 229, 0.12);
      --success: #0f766e;
      --shadow: 0 18px 45px rgba(23, 32, 51, 0.08);
      --radius: 24px;
    }

    * {
      box-sizing: border-box;
    }

    html {
      scroll-behavior: smooth;
    }

    body {
      margin: 0;
      font-family: Inter, ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
      color: var(--text);
      background:
        radial-gradient(circle at top left, rgba(79, 70, 229, 0.08), transparent 30%),
        radial-gradient(circle at right center, rgba(14, 165, 233, 0.07), transparent 24%),
        linear-gradient(180deg, #fafbff 0%, #f4f6fb 100%);
      min-height: 100vh;
    }

    a {
      color: inherit;
      text-decoration: none;
    }

    .container {
      width: min(1120px, calc(100% - 32px));
      margin: 0 auto;
    }

    .nav {
      position: sticky;
      top: 0;
      z-index: 20;
      backdrop-filter: blur(14px);
      background: rgba(246, 247, 251, 0.72);
      border-bottom: 1px solid rgba(23, 32, 51, 0.06);
    }

    .nav-inner {
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 16px 0;
      gap: 16px;
    }

    .brand {
      display: flex;
      align-items: center;
      gap: 12px;
      font-weight: 700;
      letter-spacing: -0.02em;
    }

    .brand-badge {
      width: 40px;
      height: 40px;
      border-radius: 14px;
      display: grid;
      place-items: center;
      background: linear-gradient(135deg, #4f46e5, #2563eb);
      color: #fff;
      box-shadow: 0 10px 24px rgba(79, 70, 229, 0.22);
      font-size: 15px;
      font-weight: 800;
    }

    .nav-links {
      display: flex;
      align-items: center;
      gap: 22px;
      color: var(--muted);
      font-size: 14px;
    }

    .nav-actions {
      display: flex;
      gap: 12px;
      align-items: center;
    }

    .btn {
      display: inline-flex;
      align-items: center;
      justify-content: center;
      gap: 8px;
      padding: 12px 18px;
      border-radius: 14px;
      border: 1px solid transparent;
      font-size: 14px;
      font-weight: 600;
      transition: 180ms ease;
      cursor: pointer;
      white-space: nowrap;
    }

    .btn:hover {
      transform: translateY(-1px);
    }

    .btn-primary {
      background: linear-gradient(135deg, #4f46e5, #2563eb);
      color: #fff;
      box-shadow: 0 12px 24px rgba(79, 70, 229, 0.24);
    }

    .btn-secondary {
      background: rgba(255,255,255,0.82);
      border-color: var(--line);
      color: var(--text);
    }

    .hero {
      padding: 64px 0 38px;
    }

    .hero-grid {
      display: grid;
      grid-template-columns: 1.2fr 0.95fr;
      gap: 28px;
      align-items: center;
    }

    .eyebrow {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      padding: 8px 12px;
      border-radius: 999px;
      background: var(--accent-soft);
      color: var(--accent);
      font-size: 13px;
      font-weight: 700;
      margin-bottom: 18px;
    }

    h1 {
      margin: 0;
      font-size: clamp(40px, 6vw, 64px);
      line-height: 1.03;
      letter-spacing: -0.04em;
    }

    .hero p {
      margin: 18px 0 0;
      font-size: 18px;
      line-height: 1.7;
      color: var(--muted);
      max-width: 620px;
    }

    .hero-actions {
      display: flex;
      flex-wrap: wrap;
      gap: 14px;
      margin-top: 28px;
    }

    .hero-stats {
      display: grid;
      grid-template-columns: repeat(3, minmax(0, 1fr));
      gap: 14px;
      margin-top: 32px;
    }

    .stat {
      background: var(--panel);
      border: 1px solid var(--line);
      border-radius: 18px;
      padding: 18px;
      box-shadow: var(--shadow);
      backdrop-filter: blur(10px);
    }

    .stat strong {
      display: block;
      font-size: 26px;
      letter-spacing: -0.03em;
      margin-bottom: 6px;
    }

    .stat span {
      color: var(--muted);
      font-size: 14px;
    }

    .hero-card {
      background: rgba(255, 255, 255, 0.84);
      border: 1px solid rgba(255, 255, 255, 0.75);
      border-radius: 28px;
      padding: 22px;
      box-shadow: 0 24px 60px rgba(23, 32, 51, 0.1);
      backdrop-filter: blur(14px);
    }

    .card-header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 18px;
    }

    .pill {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      padding: 8px 12px;
      border-radius: 999px;
      background: #eef6ff;
      color: #1d4ed8;
      font-size: 13px;
      font-weight: 700;
    }

    .session-card {
      border: 1px solid var(--line);
      border-radius: 20px;
      padding: 18px;
      background: var(--panel-strong);
      margin-top: 14px;
    }

    .session-top {
      display: flex;
      justify-content: space-between;
      gap: 12px;
      align-items: start;
    }

    .session-title {
      font-size: 18px;
      font-weight: 700;
      letter-spacing: -0.02em;
    }

    .session-meta {
      display: grid;
      grid-template-columns: repeat(2, minmax(0, 1fr));
      gap: 10px;
      margin-top: 14px;
      color: var(--muted);
      font-size: 14px;
    }

    .session-note {
      margin-top: 14px;
      padding: 12px 14px;
      border-radius: 14px;
      background: #f4f8f6;
      color: var(--success);
      font-size: 14px;
      font-weight: 600;
    }

    .section {
      padding: 34px 0;
    }

    .section-heading {
      display: flex;
      justify-content: space-between;
      align-items: end;
      gap: 20px;
      margin-bottom: 22px;
    }

    .section-heading h2 {
      margin: 0;
      font-size: clamp(28px, 4vw, 38px);
      letter-spacing: -0.03em;
    }

    .section-heading p {
      margin: 8px 0 0;
      color: var(--muted);
      line-height: 1.7;
      max-width: 680px;
    }

    .cards {
      display: grid;
      grid-template-columns: repeat(3, minmax(0, 1fr));
      gap: 18px;
    }

    .feature-card {
      background: rgba(255,255,255,0.82);
      border: 1px solid var(--line);
      border-radius: var(--radius);
      padding: 22px;
      box-shadow: var(--shadow);
    }

    .icon {
      width: 46px;
      height: 46px;
      border-radius: 16px;
      display: grid;
      place-items: center;
      background: var(--accent-soft);
      color: var(--accent);
      font-size: 20px;
      margin-bottom: 14px;
    }

    .feature-card h3 {
      margin: 0 0 8px;
      font-size: 20px;
      letter-spacing: -0.02em;
    }

    .feature-card p {
      margin: 0;
      color: var(--muted);
      line-height: 1.7;
      font-size: 15px;
    }

    .two-col {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 18px;
    }

    .panel {
      background: rgba(255,255,255,0.82);
      border: 1px solid var(--line);
      border-radius: 26px;
      padding: 24px;
      box-shadow: var(--shadow);
    }

    .list {
      display: grid;
      gap: 14px;
      margin-top: 10px;
    }

    .list-item {
      display: flex;
      gap: 14px;
      align-items: flex-start;
      padding: 14px 0;
      border-bottom: 1px solid var(--line);
    }

    .list-item:last-child {
      border-bottom: 0;
      padding-bottom: 0;
    }

    .list-number {
      min-width: 34px;
      height: 34px;
      border-radius: 12px;
      display: grid;
      place-items: center;
      background: #eef2ff;
      color: var(--accent);
      font-size: 14px;
      font-weight: 800;
    }

    .list-item strong {
      display: block;
      margin-bottom: 4px;
      font-size: 15px;
    }

    .list-item span {
      color: var(--muted);
      line-height: 1.6;
      font-size: 14px;
    }

    .cta {
      padding: 42px 0 74px;
    }

    .cta-box {
      background: linear-gradient(135deg, #111827, #1f2a44);
      color: white;
      border-radius: 32px;
      padding: 34px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 24px;
      box-shadow: 0 22px 60px rgba(17, 24, 39, 0.2);
    }

    .cta-box p {
      margin: 10px 0 0;
      color: rgba(255,255,255,0.76);
      max-width: 620px;
      line-height: 1.7;
    }

    .footer {
      padding: 0 0 36px;
      color: var(--muted);
      font-size: 14px;
    }

    @media (max-width: 960px) {
      .hero-grid,
      .two-col,
      .cards,
      .cta-box {
        grid-template-columns: 1fr;
        display: grid;
      }

      .nav-links {
        display: none;
      }
    }

    @media (max-width: 720px) {
      .hero {
        padding-top: 34px;
      }

      .nav-inner {
        flex-wrap: wrap;
      }

      .nav-actions {
        width: 100%;
      }

      .nav-actions .btn {
        flex: 1;
      }

      .hero-stats,
      .session-meta {
        grid-template-columns: 1fr;
      }

      .section,
      .cta {
        padding-top: 24px;
      }

      h1 {
        font-size: 38px;
      }

      .hero p {
        font-size: 16px;
      }

      .feature-card,
      .panel,
      .hero-card,
      .cta-box {
        border-radius: 22px;
      }
    }
  </style>
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
          <div class="eyebrow">Code Review Milestone: Main webpage + 2 functional requirements</div>
          <h1>Register, log in, and start building your study session experience.</h1>
          <p>
            Study Session helps students organize campus study groups in one place. For this milestone,
            the project includes the main landing page plus two implemented functional requirements:
            <strong>Account Registration</strong> and <strong>Account Login</strong>.
          </p>

          <div class="hero-actions">
            <a class="btn btn-primary" href="register.jsp">Create Account</a>
            <a class="btn btn-secondary" href="login.jsp">Sign In</a>
          </div>

          <div class="hero-stats">
            <div class="stat">
              <strong>FR1</strong>
              <span>Account registration with full name, email, password, and department.</span>
            </div>
            <div class="stat">
              <strong>FR2</strong>
              <span>Account login using email and password validation.</span>
            </div>
            <div class="stat">
              <strong>Schema</strong>
              <span>Designed around Users, Students, and Admins tables.</span>
            </div>
          </div>
        </div>

        <div class="hero-card">
          <div class="card-header">
            <div>
              <strong style="font-size: 20px; letter-spacing: -0.02em;">Milestone Preview</strong>
              <div style="color: var(--muted); margin-top: 6px; font-size: 14px;">Connected to registration and login pages</div>
            </div>
            <span class="pill">Ready to Review</span>
          </div>

          <div class="session-card">
            <div class="session-top">
              <div>
                <div class="session-title">Current Code Review Scope</div>
              </div>
              <span class="pill" style="background:#eefcf5; color:#0f766e;">2 FRs</span>
            </div>

            <div class="session-meta">
              <div><strong>Requirement 1</strong><br />Register a new user</div>
              <div><strong>Requirement 2</strong><br />Log in as existing user</div>
              <div><strong>User Roles</strong><br />Student and Admin</div>
              <div><strong>Database Fit</strong><br />Users / Students / Admins</div>
            </div>

            <div class="session-note">
              This submission focuses on account access features that connect directly to the project database design.
            </div>
          </div>
        </div>
      </div>
    </section>

    <section class="section" id="features">
      <div class="container">
        <div class="section-heading">
          <div>
            <h2>Included in this submission</h2>
            <p>
              This landing page supports the first project code review by clearly showing the main entry point of the system
              and the two completed functional requirements for user access.
            </p>
          </div>
        </div>

        <div class="cards">
          <article class="feature-card">
            <div class="icon">1</div>
            <h3>Account Registration</h3>
            <p>New users can create an account by entering full name, email, password, department, and selecting a user role.</p>
          </article>

          <article class="feature-card">
            <div class="icon">2</div>
            <h3>Account Login</h3>
            <p>Existing users can log in with email and password and receive feedback if credentials are invalid.</p>
          </article>

          <article class="feature-card">
            <div class="icon">3</div>
            <h3>Database Alignment</h3>
            <p>The current account flow is designed to match the project schema for Users, Students, and Admins.</p>
          </article>
        </div>
      </div>
    </section>

    <section class="section" id="how-it-works">
      <div class="container two-col">
        <div class="panel">
          <div class="section-heading" style="margin-bottom: 8px; display:block;">
            <h2 style="font-size: 28px;">How it works</h2>
            <p>The current milestone demonstrates the user account flow.</p>
          </div>

          <div class="list">
            <div class="list-item">
              <div class="list-number">1</div>
              <div>
                <strong>Open the registration page</strong>
                <span>Users can create an account from the landing page by choosing Register.</span>
              </div>
            </div>
            <div class="list-item">
              <div class="list-number">2</div>
              <div>
                <strong>Enter account details</strong>
                <span>Registration collects full name, email, password, department, and role for the new account.</span>
              </div>
            </div>
            <div class="list-item">
              <div class="list-number">3</div>
              <div>
                <strong>Prevent duplicate emails</strong>
                <span>The registration logic checks whether the email is already in use before creating the account.</span>
              </div>
            </div>
            <div class="list-item">
              <div class="list-number">4</div>
              <div>
                <strong>Log in with saved credentials</strong>
                <span>Users can then go to the login page and sign in using the same email and password.</span>
              </div>
            </div>
          </div>
        </div>

        <div class="panel" id="roles">
          <div class="section-heading" style="margin-bottom: 8px; display:block;">
            <h2 style="font-size: 28px;">User roles and tables</h2>
            <p>The account pages are built around the entities described in the report.</p>
          </div>

          <div class="list">
            <div class="list-item">
              <div class="list-number">U</div>
              <div>
                <strong>Users</strong>
                <span>Stores the shared account fields: full name, email, password, and department.</span>
              </div>
            </div>
            <div class="list-item">
              <div class="list-number">S</div>
              <div>
                <strong>Students</strong>
                <span>Represents student accounts and connects student-specific information to the main user record.</span>
              </div>
            </div>
            <div class="list-item">
              <div class="list-number">A</div>
              <div>
                <strong>Admins</strong>
                <span>Represents admin accounts and supports the separate admin role defined in the database design.</span>
              </div>
            </div>
            <div class="list-item">
              <div class="list-number">DB</div>
              <div>
                <strong>Database setup</strong>
                <span>The repo also includes schema and seed files so the professor can review the database portion of the project.</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section class="cta" id="get-started">
      <div class="container">
        <div class="cta-box">
          <div>
            <h2 style="margin:0; font-size: clamp(28px, 4vw, 40px); letter-spacing: -0.03em;">Try the current milestone</h2>
            <p>
              Use the Register page to create a sample account, then use the Login page to sign in with the same credentials.
              This shows the two functional requirements currently included for the GitHub code review submission.
            </p>
          </div>
          <div style="display:flex; gap:12px; flex-wrap:wrap;">
            <a class="btn btn-primary" href="register.jsp">Register</a>
            <a class="btn btn-secondary" href="login.jsp" style="background: rgba(255,255,255,0.08); color: #fff; border-color: rgba(255,255,255,0.14);">Login</a>
          </div>
        </div>
      </div>
    </section>
  </main>

  <footer class="footer">
    <div class="container">
      Team 7 · Study Session · Main webpage for code review milestone with Account Registration and Account Login
    </div>
  </footer>
</body>
</html>