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