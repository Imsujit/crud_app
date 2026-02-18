<%@page import="com.nsgacademy.crudapp.model.User"%>

<%
    // Retrieve the user from the session
    User user = (User)session.getAttribute("user");
%>

<% if(user != null) { %>
    <div class="d-flex justify-content-between align-items-center mb-4 px-1">
        <div>
            <h5 class="text-dark fw-bold mb-0">
                <i class="fas fa-hand-wave text-warning me-2"></i>Hello, <%= user.getUsername() %>!
            </h5>
            <p class="text-muted small mb-0">You are currently logged into the MVC Registry.</p>
        </div>

        <div>
            <a href="user?action=logout" class="btn btn-sm btn-outline-danger border-0 fw-bold">
                <i class="fas fa-power-off me-1"></i> Sign Out
            </a>
        </div>
    </div>
    <hr class="mb-4 opacity-25">
<% } %>