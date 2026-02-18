<%@page import="com.nsgacademy.crudapp.model.Student"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%
        Student student = (Student)request.getAttribute("student");
        boolean isEdit = (student != null);
    %>
    <title><%= isEdit ? "Edit" : "Add" %> Student | MVC Registry</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body { background-color: #f8f9fa; }
        .form-container { margin-top: 60px; max-width: 550px; }
        .card { border: none; box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15); border-radius: 10px; }
        .card-header { border-radius: 10px 10px 0 0 !important; }
        .form-label { font-weight: 600; color: #495057; }
        .input-group-text { background-color: #f1f3f5; border-right: none; }
        .form-control { border-left: none; }
        .form-control:focus { box-shadow: none; border-color: #dee2e6; }
        .input-group:focus-within { box-shadow: 0 0 0 0.25rem rgba(13, 202, 240, 0.25); border-radius: 0.375rem; }
    </style>
</head>
<body>

<div class="container form-container">
<jsp:include page="header.jsp" />
    <div class="card">
        <div class="card-header bg-dark text-white d-flex justify-content-between align-items-center py-3">
            <div>
                <h4 class="mb-0">
                    <i class="fas <%= isEdit ? "fa-user-pen" : "fa-user-plus" %> me-2 text-info"></i>
                    <%= isEdit ? "Edit Student" : "New Registration" %>
                </h4>
                <small class="text-info opacity-75">
                    <%= isEdit ? "Update existing record" : "Add student to JDBC" %>
                </small>
            </div>
            <a href="student" class="btn btn-outline-light btn-sm">
                <i class="fas fa-times"></i>
            </a>
        </div>

        <div class="card-body p-4">
            <form action="student?action=<%= (isEdit ? "update" : "insert") %>" method="post">

                <% if(isEdit) { %>
                    <input type="hidden" name="id" value="<%= student.getId() %>">
                <% } %>

                <div class="mb-3">
                    <label class="form-label">Name</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-user text-secondary"></i></span>

                        <input type="text" name="name" class="form-control"
                               value="<%= (request.getParameter("name")!=null) ? request.getParameter("name") : (isEdit ? student.getName() : "") %>"
                               placeholder="Enter student name"
                               required
                               pattern="[A-Za-z ]{3,50}"
                               title="Name should be at least 3 to 50 characters">

                        <%String nameError = (String)request.getAttribute("nameError");%>
                        <p class="text-danger"><%= (nameError != null ? nameError : "")%></p>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Email Address</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-envelope text-secondary"></i></span>

                        <input type="email" name="email" class="form-control"
                            value="<%=(request.getParameter("email")!=null) ? request.getParameter("email") : (isEdit ? student.getEmail() : "") %>"
                            placeholder="example@mail.com"
                            required>

                        <%String emailError = (String)request.getAttribute("emailError");%>
                        <p class="text-danger"><%= (emailError != null ? emailError : "")%></p>
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label">Mobile Number</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-phone text-secondary"></i></span>

                        <input type="text" name="mobile" class="form-control"
                            value="<%= (request.getParameter("mobile")!=null) ? request.getParameter("mobile") : (isEdit ? student.getMobile() : "") %>"
                            placeholder="Enter mobile number"
                            required
                            pattern="[0-9]{10}"
                            title="Mobile Number should be of 10 digits">

                        <%String mobileError = (String)request.getAttribute("mobileError");%>
                        <p class="text-danger"><%= (mobileError != null ? mobileError : "")%></p>
                    </div>
                </div>

                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-info text-white fw-bold">
                        <i class="fas fa-save me-2"></i><%= isEdit ? "Update Student" : "Save Student" %>
                    </button>
                    <a href="student" class="btn btn-light text-muted">Cancel</a>
                </div>

            </form>
        </div>

        <div class="card-footer text-muted text-center small">
            MVC Pattern: View (JSP) &rarr; Controller (Servlet)
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>