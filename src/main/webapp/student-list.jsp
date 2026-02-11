<%@page language="java" import="java.util.*,com.nsgacademy.crudapp.model.Student"%>
<html>
    <head>
        <title>MVC CRUD APPLICATION</title>
    </head>
    <body>
        <h2>MVC CRUD APPLICATION</h2>
        <h5>JSP + SERVLET + JDBC</H5>

        <table border= "1" cellpadding= "5">
        <a href="student?action=add">Add Student</a>
            <thead>
                <tr>
                    <th>#</th>
                    <th>NAME</th>
                    <th>EMAIL</th>
                    <th>MOBILE</th>
                    <th>ACTION</th>
                </tr>
            </thead>

            <tbody>
            <%
                List<Student> students = (List<Student>)request.getAttribute("students");
                if(!(students==null) && !(students.isEmpty())){
                    int cnt=1;
                    for(Student s : students){
            %>
                        <tr>
                            <td><%=cnt++ %></td>
                            <td><%=s.getName()%></td>
                            <td><%=s.getEmail()%></td>
                            <td><%=s.getMobile()%></td>
                            <td>
                                <a href="student?action=edit">UPDATE</a>
                                <a href="student?action=delete">DELETE</a>
                            </td>
                        </tr>
            <%
                    }
                }
                else{
            %>
                    <tr>
                        <td colspan="5" align="center">Student not found</td>
                    </tr>
            <%
                }
            %>
            </tbody>

        </table>
    </body>
</html>