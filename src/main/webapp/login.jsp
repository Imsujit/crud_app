<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In | MVC Registry</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body { background-color: #f8f9fa; font-family: 'Segoe UI', sans-serif; }
        .auth-container { margin-top: 100px; max-width: 400px; }
        .card { border: none; border-radius: 12px; box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1); }
        .card-header { border-radius: 12px 12px 0 0 !important; }
        .input-group-text { background-color: #f1f3f5; }
    </style>
</head>
<body>

<div class="container auth-container">
    <div class="card">
        <div class="card-header bg-dark text-white py-3 text-center">
            <h4 class="mb-0"><i class="fas fa-shield-halved me-2 text-info"></i>Login</h4>
            <small class="text-info opacity-75">Secure Access to Registry</small>
        </div>

        <div class="card-body p-4">
            <%
                String success = request.getParameter("success");
                String error = (String)request.getAttribute("error");

                if(success != null){
            %>
                <div class="alert alert-success py-2 small d-flex align-items-center" role="alert">
                    <i class="fas fa-check-circle me-2"></i> <%= success %>
                </div>
            <% } %>

            <% if(error != null){ %>
                <div class="alert alert-danger py-2 small d-flex align-items-center" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i> <%= error %>
                </div>
            <% } %>

            <form action="user?action=doLogin" method="post">
                <div class="mb-3">
                    <label class="form-label small fw-bold">Username</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-user text-muted"></i></span>
                        <input type="text" name="username" class="form-control" placeholder="Enter username" required>
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label small fw-bold">Password</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-lock text-muted"></i></span>
                        <input type="password" name="password" class="form-control" placeholder="Enter password" required>
                    </div>
                </div>

                <div class="d-grid mb-3">
                    <button type="submit" class="btn btn-info text-white fw-bold py-2">Sign In</button>
                </div>

                <div class="text-center">
                    <span class="text-muted small">New user?</span>
                    <a href="user?action=register" class="small text-info fw-bold text-decoration-none ms-1">Register now</a>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>