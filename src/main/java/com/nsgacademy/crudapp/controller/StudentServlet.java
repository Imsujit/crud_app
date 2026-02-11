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
                case "add":
                    break;
                case "delete": deleteStudent(req,resp);
                    break;
                case "edit":
                    break;
                case "insert":
                    break;
                case "update":
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
}
