<html>
<head>
   <title>MVC CRUD APPLICATION</title>
</head>
<body>
    <h2>MVC CRUD APPLICATION</h2>
    <h3>JSP + SERVLET + JDBC</h3>
    <h4>Student (Add/Edit) Form</h4>
    <form action="student?action=insert" method="post">
        <label>Name</label>
        <input type="text" name="name" placeholder="Enter Name"><br><br>

        <label>Email</label>
        <input type="text" name="email" placeholder="Enter Email"><br><br>

        <label>Mobile</label>
        <input type="text" name="mobile" placeholder="Enter Mobile"><br><br>

        <button type="submit">Save</button>
        <a href="student">Cancel</a>
    </form>
</body>
</html>