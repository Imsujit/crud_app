package com.nsgacademy.crudapp.controller;

import com.nsgacademy.crudapp.dao.StudentDAO;
import com.nsgacademy.crudapp.dao.StudentDAOImpl;
import com.nsgacademy.crudapp.exception.DAOException;
import com.nsgacademy.crudapp.model.Student;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.regex.Pattern;

@WebServlet(urlPatterns = {"/","/student"})
public class StudentServlet extends HttpServlet {
    private StudentDAO studentDao;
    @Override
    public void init() throws ServletException {
      studentDao = new StudentDAOImpl();  // superclass reference subclass object // one time object initialization
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req,resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if(action==null) action="list";

        try{
            switch(action){
                case "add": showNewForm(req,resp);
                    break;
                case "delete": deleteStudent(req,resp);
                    break;
                case "edit": showEditForm(req,resp);
                    break;
                case "insert": insertStudent(req,resp);
                    break;
                case "update": updateStudent(req,resp);
                    break;
                default: getStudentsList(req,resp);
            }
        }catch (DAOException e){
            req.setAttribute("errorMessage",e.getMessage());
            req.setAttribute("cause",e.getCause());
            req.setAttribute("exception",e);
            req.getRequestDispatcher("error.jsp").forward(req,resp);
        }
    }

    private void getStudentsList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        List<Student> studentsList = studentDao.getAllStudents();
        req.setAttribute("students",studentsList);
        req.getRequestDispatcher("student-list.jsp").forward(req,resp);
    }

    private void deleteStudent(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        int id = Integer.parseInt(req.getParameter("id"));
        studentDao.delete(id);
        resp.sendRedirect("student?action=list&success=Deleted Successfully!");
    }

    private void showNewForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        req.getRequestDispatcher("student-form.jsp").forward(req,resp);
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        int id = Integer.parseInt(req.getParameter("id"));
        Student student = studentDao.getStudentById(id);
        req.setAttribute("student",student);
        req.getRequestDispatcher("student-form.jsp").forward(req,resp);
    }

    private void insertStudent(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String mobile = req.getParameter("mobile");

        if(!validate(req,name,email,mobile)){
            req.getRequestDispatcher("student-form.jsp").forward(req,resp);
            return;
        }

        studentDao.insert(new Student(name.trim(),email.trim(),mobile.trim()));
        resp.sendRedirect("student?action=list&success=Inserted Successfully!");
    }

    private void updateStudent(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        int id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String mobile = req.getParameter("mobile");

        if(!validate(req,name,email,mobile)){
            req.setAttribute("student",new Student(id,name,email,mobile));
            req.getRequestDispatcher("student-form.jsp").forward(req,resp);
            return;
        }

        studentDao.update(new Student(id,name.trim(),email.trim(),mobile.trim()));
        resp.sendRedirect("student?action=list&success=Updated Successfully!");
    }

    private boolean validate(HttpServletRequest req,String name,String email,String mobile){
        boolean isValid = true;

        if(name==null || !Pattern.matches("^[A-Za-z ]{3,50}$",name.trim())){
            isValid = false;
            req.setAttribute("nameError","Name should be at least 3 to 50 characters");
        }

        if(email==null || !Pattern.matches("^[A-Za-z0-9_.-]+@(.+)$",email.trim())){
            isValid = false;
            req.setAttribute("emailError","Invalid Email ID");
        }

        if(mobile==null || !Pattern.matches("^[0-9]{10}$",mobile.trim())){
            isValid = false;
            req.setAttribute("mobileError","Mobile Number should be of 10 digits");
        }

        return isValid;
    }
}
