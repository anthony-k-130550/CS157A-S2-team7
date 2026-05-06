<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*"%>

<%!
boolean tableExists(Connection con, String tableName) {
    try {
        DatabaseMetaData meta = con.getMetaData();
        ResultSet rs = meta.getTables(null, null, tableName, null);
        boolean exists = rs.next();
        rs.close();
        return exists;
    } catch (Exception e) {
        return false;
    }
}

boolean columnExists(Connection con, String tableName, String columnName) {
    try {
        DatabaseMetaData meta = con.getMetaData();
        ResultSet rs = meta.getColumns(null, null, tableName, columnName);
        boolean exists = rs.next();
        rs.close();
        return exists;
    } catch (Exception e) {
        return false;
    }
}

String cleanErrorMessage(Exception e) {
    String msg = e.getMessage();
    if (msg == null) return "Something went wrong. Please try again.";
    if (msg.contains("foreign key constraint fails")) return "This record cannot be changed because it is still connected to other records.";
    if (msg.contains("Duplicate entry")) return "This record already exists.";
    if (msg.contains("doesn't have a default value")) return "A required value is missing. Please check the form and try again.";
    if (msg.contains("Data truncation")) return "One of the values entered is not valid. Please check the form and try again.";
    return "Something went wrong while processing your request.";
}
%>

<%
String currentRole = (String) session.getAttribute("role");
if (!"admin".equals(currentRole)) {
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Manage Courses</title>
  <link rel="stylesheet" href="css/global.css">
  <style>
    .course-card {
      padding: 16px;
      border: 1px solid rgba(0,0,0,0.08);
      border-radius: 14px;
      margin-bottom: 14px;
      background: #fff;
    }
    .course-card-row {
      display: grid;
      grid-template-columns: 60px 1.2fr 0.8fr 1.6fr auto;
      gap: 12px;
      align-items: end;
    }
    .course-card-row .field { margin: 0; }
    .course-card-actions {
      display: flex;
      gap: 8px;
      align-items: end;
    }
    .session-pill {
      padding: 10px 12px;
      border: 1px solid rgba(0,0,0,0.08);
      border-radius: 10px;
      margin-top: 8px;
      background: #fafafa;
    }
    .session-meta { font-size: 13px; color: #475569; margin-top: 4px; }
    .session-meta strong { color: #0f172a; }
    .course-id-label {
      font-weight: 700;
      font-size: 14px;
      padding-bottom: 8px;
    }
    .session-summary { cursor: pointer; padding: 4px 0; }
    @media (max-width: 900px) {
      .course-card-row {
        grid-template-columns: 1fr;
      }
    }
  </style>
</head>
<body>

<%@ include file="navbar.jsp" %>

<%
String dbUser = "root";
String dbPassword = "CS157ALG";
String dbUrl = "jdbc:mysql://localhost:3306/project?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC&characterEncoding=UTF-8";

String successMessage = null;
String errorMessage = null;

String action = request.getParameter("action");
request.setCharacterEncoding("UTF-8");

if ("addCourse".equals(action)) {
    String department = request.getParameter("Department");
    String courseNumberStr = request.getParameter("CourseNumber");
    String courseName = request.getParameter("CourseName");

    if (department != null && courseNumberStr != null && courseName != null
        && !department.trim().isEmpty()
        && !courseNumberStr.trim().isEmpty()
        && !courseName.trim().isEmpty()) {

        Connection con = null;
        PreparedStatement pstmt = null;
        try {
            int courseNumber = Integer.parseInt(courseNumberStr);
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
            pstmt = con.prepareStatement("INSERT INTO Course (Department, CourseNumber, CourseName) VALUES (?, ?, ?)");
            pstmt.setString(1, department.trim());
            pstmt.setInt(2, courseNumber);
            pstmt.setString(3, courseName.trim());
            int result = pstmt.executeUpdate();
            if (result > 0) successMessage = "Successfully added course: " + department.trim() + " " + courseNumber + ".";
            else errorMessage = "Failed to add course.";
        } catch (NumberFormatException e) {
            errorMessage = "Course Number must be a valid integer.";
        } catch (Exception e) {
            errorMessage = cleanErrorMessage(e);
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}

if ("updateCourse".equals(action)) {
    String courseIDStr = request.getParameter("CourseID");
    String department = request.getParameter("Department");
    String courseNumberStr = request.getParameter("CourseNumber");
    String courseName = request.getParameter("CourseName");

    if (courseIDStr != null && department != null && courseNumberStr != null && courseName != null
        && !courseIDStr.trim().isEmpty()
        && !department.trim().isEmpty()
        && !courseNumberStr.trim().isEmpty()
        && !courseName.trim().isEmpty()) {

        Connection con = null;
        PreparedStatement pstmt = null;
        try {
            int courseID = Integer.parseInt(courseIDStr);
            int courseNumber = Integer.parseInt(courseNumberStr);
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
            pstmt = con.prepareStatement("UPDATE Course SET Department = ?, CourseNumber = ?, CourseName = ? WHERE CourseID = ?");
            pstmt.setString(1, department.trim());
            pstmt.setInt(2, courseNumber);
            pstmt.setString(3, courseName.trim());
            pstmt.setInt(4, courseID);
            int result = pstmt.executeUpdate();
            if (result > 0) successMessage = "Successfully updated course ID " + courseID + ".";
            else errorMessage = "Course not found.";
        } catch (NumberFormatException e) {
            errorMessage = "Course ID and Course Number must be valid integers.";
        } catch (Exception e) {
            errorMessage = cleanErrorMessage(e);
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}

if ("deleteCourse".equals(action)) {
    String courseIDStr = request.getParameter("CourseID");
    if (courseIDStr != null && !courseIDStr.trim().isEmpty()) {
        Connection con = null;
        PreparedStatement check = null;
        PreparedStatement del = null;
        ResultSet rs = null;
        try {
            int courseID = Integer.parseInt(courseIDStr);
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

            int usageCount = 0;
            if (tableExists(con, "StudyingFor") && columnExists(con, "StudyingFor", "CourseID")) {
                check = con.prepareStatement("SELECT COUNT(*) FROM StudyingFor WHERE CourseID = ?");
                check.setInt(1, courseID);
                rs = check.executeQuery();
                if (rs.next()) usageCount += rs.getInt(1);
                try { rs.close(); } catch (Exception e) {}
                try { check.close(); } catch (Exception e) {}
                rs = null; check = null;
            }

            if (usageCount > 0) {
                errorMessage = "Cannot delete this course because it is still connected to " + usageCount + " study session(s).";
            } else {
                del = con.prepareStatement("DELETE FROM Course WHERE CourseID = ?");
                del.setInt(1, courseID);
                int result = del.executeUpdate();
                if (result > 0) successMessage = "Successfully deleted unused course ID " + courseID + ".";
                else errorMessage = "Course not found.";
            }
        } catch (NumberFormatException e) {
            errorMessage = "Course ID must be a valid integer.";
        } catch (Exception e) {
            errorMessage = cleanErrorMessage(e);
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (check != null) check.close(); } catch (Exception e) {}
            try { if (del != null) del.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}
%>

<div class="page-shell">
  <div class="container">

    <div class="card" style="margin-bottom:24px;">
      <h1 class="form-title" style="margin-bottom:8px;">Manage Courses</h1>
      <p class="form-subtitle" style="margin-bottom:0;">
        Add, edit, delete unused courses, and view connected study sessions.
      </p>
    </div>

    <% if (successMessage != null) { %>
      <div style="margin-bottom:24px; padding:12px 14px; border-radius:14px; background:#f4f8f6; color:#0f766e; border:1px solid rgba(15,118,110,0.18);">
        <%= successMessage %>
      </div>
    <% } %>

    <% if (errorMessage != null) { %>
      <div style="margin-bottom:24px; padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);">
        <%= errorMessage %>
      </div>
    <% } %>

    <div class="card" style="margin-bottom:24px;">
      <h2 style="margin-top:0; margin-bottom:6px;">Add Course</h2>
      <form method="post" style="margin-top:14px;">
        <input type="hidden" name="action" value="addCourse">
        <div class="grid grid-2">
          <div class="field">
            <label for="Department">Department</label>
            <input type="text" id="Department" name="Department" required>
          </div>
          <div class="field">
            <label for="CourseNumber">Course Number</label>
            <input type="number" id="CourseNumber" name="CourseNumber" required>
          </div>
        </div>
        <div class="field">
          <label for="CourseName">Course Name</label>
          <input type="text" id="CourseName" name="CourseName" required>
        </div>
        <button type="submit" class="btn btn-primary" style="margin-top:14px;">Add Course</button>
      </form>
    </div>

    <div class="card">
      <h2 style="margin-top:0; margin-bottom:14px;">Course List</h2>

<%
Connection con = null;
Statement stmt = null;
ResultSet rs = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

    boolean hasStudyingFor = tableExists(con, "StudyingFor")
        && columnExists(con, "StudyingFor", "CourseID")
        && columnExists(con, "StudyingFor", "SessionID");
    boolean hasStudySession = tableExists(con, "StudySession");

    stmt = con.createStatement();
    rs = stmt.executeQuery("SELECT CourseID, Department, CourseNumber, CourseName FROM Course ORDER BY CourseID");

    boolean any = false;
    while (rs.next()) {
        any = true;
        int courseID = rs.getInt("CourseID");
        String dept = rs.getString("Department");
        int number = rs.getInt("CourseNumber");
        String name = rs.getString("CourseName");
        String formId = "course-form-" + courseID;

        StringBuilder sessionHtml = new StringBuilder();
        int sessionCount = 0;

        if (hasStudyingFor && hasStudySession) {
            PreparedStatement sps = null;
            ResultSet srs = null;
            try {
                sps = con.prepareStatement(
                    "SELECT s.SessionID, s.Title, s.Day, s.StartTime, s.EndTime, s.Capacity, s.Description "
                    + "FROM StudyingFor sf JOIN StudySession s ON sf.SessionID = s.SessionID "
                    + "WHERE sf.CourseID = ? ORDER BY s.Day, s.StartTime"
                );
                sps.setInt(1, courseID);
                srs = sps.executeQuery();
                while (srs.next()) {
                    sessionCount++;
                    int sid = srs.getInt("SessionID");
                    String title = srs.getString("Title");
                    Date day = srs.getDate("Day");
                    Time start = srs.getTime("StartTime");
                    Time end = srs.getTime("EndTime");
                    int cap = srs.getInt("Capacity");
                    String desc = srs.getString("Description");

                    sessionHtml.append("<div class=\"session-pill\">");
                    sessionHtml.append("<div style=\"font-weight:600;\">")
                               .append(title == null ? "(untitled)" : title)
                               .append(" <span class=\"muted\" style=\"font-weight:400;\">#").append(sid).append("</span></div>");
                    sessionHtml.append("<div class=\"session-meta\">");
                    sessionHtml.append("<strong>Day:</strong> ").append(day == null ? "-" : day.toString()).append(" &nbsp; | &nbsp; ");
                    sessionHtml.append("<strong>Time:</strong> ")
                               .append(start == null ? "-" : start.toString())
                               .append(" to ")
                               .append(end == null ? "-" : end.toString()).append(" &nbsp; | &nbsp; ");
                    sessionHtml.append("<strong>Capacity:</strong> ").append(cap);
                    sessionHtml.append("</div>");
                    if (desc != null && !desc.trim().isEmpty()) {
                        sessionHtml.append("<div class=\"session-meta\"><strong>Description:</strong> ").append(desc).append("</div>");
                    }
                    sessionHtml.append("</div>");
                }
            } catch (Exception ex) {
                sessionHtml.setLength(0);
                sessionHtml.append("<span class=\"muted\">Could not load sessions.</span>");
            } finally {
                try { if (srs != null) srs.close(); } catch (Exception e) {}
                try { if (sps != null) sps.close(); } catch (Exception e) {}
            }
        }
%>
      <div class="course-card">
        <form id="<%= formId %>" method="post" style="display:none;">
          <input type="hidden" name="CourseID" value="<%= courseID %>">
        </form>

        <div class="course-card-row">
          <div>
            <div class="course-id-label">ID #<%= courseID %></div>
          </div>
          <div class="field">
            <label>Department</label>
            <input type="text" name="Department" value="<%= dept %>" form="<%= formId %>" required>
          </div>
          <div class="field">
            <label>Number</label>
            <input type="number" name="CourseNumber" value="<%= number %>" form="<%= formId %>" required>
          </div>
          <div class="field">
            <label>Name</label>
            <input type="text" name="CourseName" value="<%= name %>" form="<%= formId %>" required>
          </div>
          <div class="course-card-actions">
            <button type="submit" name="action" value="updateCourse" form="<%= formId %>" class="btn btn-secondary">Save</button>
            <button type="submit" name="action" value="deleteCourse" form="<%= formId %>" class="btn btn-primary"
                    onclick="return confirm('Delete unused course <%= dept %> <%= number %>? This only works if the course has no connected sessions.');">Delete</button>
          </div>
        </div>

        <div style="margin-top:14px;">
<%
        if (sessionCount == 0) {
%>
          <span class="muted">No connected sessions</span>
<%
        } else {
%>
          <details>
            <summary class="session-summary"><strong><%= sessionCount %> connected session(s)</strong> &mdash; click to expand</summary>
            <div style="margin-top:6px;">
              <%= sessionHtml.toString() %>
            </div>
          </details>
<%
        }
%>
        </div>
      </div>
<%
    }

    if (!any) {
%>
      <p class="muted">No courses yet. Add one above.</p>
<%
    }

} catch (Exception e) {
%>
      <div style="padding:12px 14px; border-radius:14px; background:#fef3f2; color:#b42318; border:1px solid rgba(180,35,24,0.18);">
        <%= cleanErrorMessage(e) %>
      </div>
<%
} finally {
    try { if (rs != null) rs.close(); } catch (Exception e) {}
    try { if (stmt != null) stmt.close(); } catch (Exception e) {}
    try { if (con != null) con.close(); } catch (Exception e) {}
}
%>
    </div>

  </div>
</div>

</body>
</html>