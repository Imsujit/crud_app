<%@page import="com.nsgacademy.crudapp.model.Student"%>
<html>
<head>
   <title>MVC CRUD APPLICATION</title>
</head>
<body>
    <h2>MVC CRUD APPLICATION</h2>
    <h3>SERVLET + JSP + JDBC</h3>

    <%
        Student student = (Student)request.getAttribute("student");
        boolean isEdit = (student!=null);
    %>

    <h4><%=isEdit ? "Edit" : "Add"%> Student</h4>
    <form action="student?action=<%= (isEdit ? "update" : "insert")%>" method="post">
        <%
            if(isEdit){
        %>
            <input type="hidden" name="id" value="<%= student.getId()%>">
        <%
            }
        %>


        <label>Name</label>
        <input type="text" name="name" value="<%=(isEdit ? student.getName() : "") %>" placeholder="Enter name"><br><br>

        <label>Email</label>
        <input type="text" name="email" value="<%=(isEdit ? student.getEmail() : "") %>" placeholder="Enter email"><br><br>

        <label>Mobile</label>
        <input type="text" name="mobile" value="<%=(isEdit ? student.getMobile() : "") %>" placeholder="Enter mobile"><br><br>

        <button type="submit">Save</button>
        <a href="student">Cancel</a>
    </form>
</body>
</html>