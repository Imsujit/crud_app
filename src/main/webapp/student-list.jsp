<%@page language="java" import="java.util.*,com.nsgacademy.crudapp.model.Student"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student MVC Registry | CRUD</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body { background-color: #f8f9fa; font-family: 'Segoe UI', sans-serif; }
        .table-container { margin-top: 50px; margin-bottom: 50px; }
        .card { border: none; box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1); border-radius: 10px; }
        .card-header { border-radius: 10px 10px 0 0 !important; }
        .btn-action { margin-right: 5px; }
        .pagination .page-link { color: #212529; border: none; margin: 0 2px; border-radius: 5px; }
        .pagination .active .page-link { background-color: #0dcaf0; border-color: #0dcaf0; color: white; }
        .page-info-text { font-size: 0.9rem; color: #6c757d; }
        .form-select-sm, .form-control-sm { border-radius: 5px; border: 1px solid #dee2e6; }
    </style>
</head>
<body>

<div class="container table-container">

    <%
        int totalPages = (int)request.getAttribute("totalPages");
        int currentPage = (int)request.getAttribute("currentPage");
        int pageSize = (int)request.getAttribute("pageSize");
        int totalRecords = (int)request.getAttribute("totalRecords");
        int start = ((currentPage-1)*pageSize)+1;
        int end = Math.min(start + pageSize-1, totalRecords);
    %>

    <div class="card">
        <div class="card-header bg-dark text-white d-flex justify-content-between align-items-center py-3">
            <div>
                <h4 class="mb-0">
                    <i class="fas fa-layer-group me-2 text-info"></i>Student MVC Registry
                </h4>
                <small class="text-info opacity-75">Servlet &bull; JSP &bull; JDBC</small>
            </div>
            <a href="student?action=add" class="btn btn-info btn-sm fw-bold">
                <i class="fas fa-plus-circle me-1"></i> New Student
            </a>
        </div>

        <div class="card-body p-0"> <%
                String success = request.getParameter("success");
                if(success != null){
            %>
                <div class="alert alert-success alert-dismissible fade show m-3" role="alert">
                    <i class="fas fa-check-circle me-2"></i> <%= success %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <%
                }
            %>

            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="ps-4">#</th>
                            <th><i class="fas fa-user me-2 text-secondary"></i>Name</th>
                            <th><i class="fas fa-envelope me-2 text-secondary"></i>Email</th>
                            <th><i class="fas fa-phone me-2 text-secondary"></i>Mobile</th>
                            <th class="text-center">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        List<Student> students = (List<Student>)request.getAttribute("students");
                        if(students != null && !students.isEmpty()){
                            int cnt = start; // Start count from the current page range
                            for(Student s : students){
                    %>
                                <tr>
                                    <td class="ps-4"><strong><%= cnt++ %></strong></td>
                                    <td><%= s.getName() %></td>
                                    <td><%= s.getEmail() %></td>
                                    <td><%= s.getMobile() %></td>
                                    <td class="text-center">
                                        <a href="student?action=edit&id=<%= s.getId() %>" class="btn btn-outline-primary btn-sm btn-action">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <a href="student?action=delete&id=<%= s.getId() %>"
                                           class="btn btn-outline-danger btn-sm"
                                           onclick="return confirm('Are you sure?')">
                                            <i class="fas fa-trash-alt"></i>
                                        </a>
                                    </td>
                                </tr>
                    <%
                            }
                        } else {
                    %>
                            <tr>
                                <td colspan="5" class="text-center text-muted py-5">
                                    <i class="fas fa-info-circle me-1"></i> No students found.
                                </td>
                            </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="row align-items-center mt-5 gy-3">
            <div class="col-md-4 text-center text-md-start">
                <div class="p-2 px-3 bg-white shadow-sm d-inline-block rounded-pill border">
                    <span class="text-muted small">Showing </span>
                    <span class="fw-bold text-dark"><%=start%></span>
                    <i class="fa-solid fa-arrow-right-long mx-2 text-info opacity-50"></i>
                    <span class="fw-bold text-dark"><%=end%></span>
                    <span class="text-muted small"> of </span>
                    <span class="badge bg-dark rounded-pill"><%=totalRecords%></span>
                </div>
            </div>

            <div class="col-md-8">
                <div class="d-flex flex-wrap justify-content-center justify-content-md-end align-items-center gap-3">

                    <form action="student" class="d-flex align-items-center bg-white shadow-sm border rounded-pill px-3 py-1">
                        <label class="small text-muted me-2 fw-semibold">View</label>
                        <select name="pageSize" class="form-select form-select-sm border-0 bg-transparent focus-none" style="box-shadow: none;" onChange="this.form.submit()">
                            <option <%=(pageSize==5) ? "selected" : ""%> value="5">5</option>
                            <option <%=(pageSize==10) ? "selected" : ""%> value="10">10</option>
                            <option <%=(pageSize==20) ? "selected" : ""%> value="20">20</option>
                            <option <%=(pageSize==50) ? "selected" : ""%> value="50">50</option>
                        </select>
                    </form>

                    <form action="student" method="get" class="d-flex align-items-center bg-white shadow-sm border rounded-pill ps-3 pe-1 py-1">
                        <span class="small text-muted me-2 fw-semibold">Go to</span>
                        <input type="hidden" name="pageSize" value="<%=pageSize%>">
                        <input type="number" name="page" min="1" max="<%=totalPages%>"
                               class="form-control form-control-sm border-0 text-center fw-bold"
                               placeholder="#" style="width: 50px; box-shadow: none;">
                        <button class="btn btn-info btn-sm rounded-pill text-white px-3">
                            <i class="fa-solid fa-rocket"></i>
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <nav aria-label="Page navigation" class="mt-4">
            <ul class="pagination justify-content-center border-0">
                <li class="page-item mx-1">
                    <a class="page-link rounded-circle shadow-sm border-0" href="student?page=1&pageSize=<%=pageSize%>">
                        <i class="fa-solid fa-angles-left small"></i>
                    </a>
                </li>

                <li class="page-item mx-1 <%=(currentPage==1) ? "disabled" : ""%>">
                    <a class="page-link rounded-circle shadow-sm border-0" href="student?page=<%=(currentPage-1)%>&pageSize=<%=pageSize%>">
                        <i class="fa-solid fa-chevron-left small"></i>
                    </a>
                </li>

                <% for(int i=1; i<=totalPages; i++){ %>
                    <li class="page-item mx-1 <%= (currentPage==i) ? "active" : "" %>">
                        <a class="page-link rounded-pill shadow-sm border-0 px-3 fw-bold" href="student?page=<%=i%>&pageSize=<%=pageSize%>"><%=i%></a>
                    </li>
                <% } %>

                <li class="page-item mx-1 <%=(currentPage==totalPages) ? "disabled" : ""%>">
                    <a class="page-link rounded-circle shadow-sm border-0" href="student?page=<%=(currentPage+1)%>&pageSize=<%=pageSize%>">
                        <i class="fa-solid fa-chevron-right small"></i>
                    </a>
                </li>

                <li class="page-item mx-1">
                    <a class="page-link rounded-circle shadow-sm border-0" href="student?page=<%=totalPages%>&pageSize=<%=pageSize%>">
                        <i class="fa-solid fa-angles-right small"></i>
                    </a>
                </li>
            </ul>
        </nav>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
