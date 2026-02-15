<%@page language="java" import="java.util.*,com.nsgacademy.crudapp.model.Student"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MVC CRUD Application</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body { background-color: #f8f9fa; }
        .table-container { margin-top: 50px; }
        .card { border: none; box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15); }
        .btn-action { margin-right: 5px; }
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
        int end = Math.min(start + pageSize-1,totalRecords);
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

        <div class="card-body">
            <%
                String success = request.getParameter("success");
                if(success != null){
            %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i> <%= success %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <%
                }
            %>

            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>#</th>
                            <th><i class="fas fa-user me-2"></i>Name</th>
                            <th><i class="fas fa-envelope me-2"></i>Email</th>
                            <th><i class="fas fa-phone me-2"></i>Mobile</th>
                            <th class="text-center">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        List<Student> students = (List<Student>)request.getAttribute("students");
                        if(students != null && !students.isEmpty()){
                            int cnt = 1;
                            for(Student s : students){
                    %>
                                <tr>
                                    <td><strong><%= cnt++ %></strong></td>
                                    <td><%= s.getName() %></td>
                                    <td><%= s.getEmail() %></td>
                                    <td><%= s.getMobile() %></td>
                                    <td class="text-center">
                                        <a href="student?action=edit&id=<%= s.getId() %>" class="btn btn-outline-primary btn-sm btn-action" title="Edit">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <a href="student?action=delete&id=<%= s.getId() %>"
                                           class="btn btn-outline-danger btn-sm"
                                           title="Delete"
                                           onclick="return confirm('Are you sure you want to delete this record?')">
                                            <i class="fas fa-trash-alt"></i>
                                        </a>
                                    </td>
                                </tr>
                    <%
                            }
                        } else {
                    %>
                            <tr>
                                <td colspan="5" class="text-center text-muted py-4">
                                    <i class="fas fa-info-circle me-1"></i> No students found in the database.
                                </td>
                            </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="card-footer text-muted text-center small">
            Servlet + JSP + JDBC MVC Architecture
        </div>
    </div>

    <div class="d-flex align-items-center justify-content-between mt-5">
        <div class="text-muted">
            Showing
            <strong><%=start%><i class="fa-solid fa-arrow-right"></i><%=end%></strong>
            of
            <strong><%=totalRecords%></strong>
        </div>

        <form action="student" class="d-flex align-items-center">
            <span class="text-muted me-2">Show</span>
            <select name="pageSize" onChange="this.form.submit()">
                <option <%=(pageSize==5) ? "selected" : ""%> value="5">5</option>
                <option <%=(pageSize==10) ? "selected" : ""%> value="10">10</option>
                <option <%=(pageSize==20) ? "selected" : ""%> value="20">20</option>
                <option <%=(pageSize==50) ? "selected" : ""%> value="50">50</option>
                <option <%=(pageSize==100) ? "selected" : ""%> value="100">100</option>
                <option <%=(pageSize==200) ? "selected" : ""%> value="200">200</option>
            </select>
            <span class="text-muted mx-2">entries</span>
        </form>

        <form action="student" method="get" class="d-flex align-items-center">
            <span class="text-muted me-2">Go</span>
            <input type="hidden" name="pageSize" value="<%=pageSize%>">
            <input type="number" name="page" min=1 max=<%=totalPages%> style="width:75px;">
            <button class="btn btn-primary btn-sm ms-2">Go</button>
        </form>
    </div>

    <nav aria-label="Page navigation example">
              <ul class="pagination justify-content-center mt-5">

                <li class="page-item"><a class="page-link" href="student?page=1&pageSize=<%=pageSize%>"><i class="fa-solid fa-backward-fast"></i></a></li>
                <li class="page-item <%=(currentPage==1) ? "disabled" : ""%>"><a class="page-link" href="student?page=<%=(currentPage-1)%>&pageSize=<%=pageSize%>"><i class="fa-solid fa-angle-left"></i></a></li>
                <% for(int i=1;i<=totalPages;i++){ %>
                    <li class="page-item <%= (currentPage==i) ? "active" : "" %>">
                        <a class="page-link" href="student?page=<%=i%>&pageSize=<%=pageSize%>"><%=i%></a>
                    </li>
                <% } %>
                <li class="page-item <%=(currentPage==totalPages) ? "disabled" : ""%>"><a class="page-link" href="student?page=<%=(currentPage+1)%>&pageSize=<%=pageSize%>"><i class="fa-solid fa-angle-right"></i></a></li>
                <li class="page-item"><a class="page-link" href="student?page=<%=totalPages%>&pageSize=<%=pageSize%>"><i class="fa-solid fa-forward-fast"></i></a></li>

              </ul>
    </nav>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>