<%@page isErrorPage="true"%>
<html lang="en">
<head>
   <title>MVC CRUD APPLICATION</title>
</head>
<body>
    <h2>Error Occured</h2>
    <%
        String errorMessage = (String)request.getAttribute("errorMessage");
        Throwable cause = (Throwable)request.getAttribute("cause");
        exception = (Throwable)request.getAttribute("exception");
    %>

    <p><%=errorMessage%></p>
    <p><%=cause%></p>
    <p><%=exception%></p>

</body>
</html>