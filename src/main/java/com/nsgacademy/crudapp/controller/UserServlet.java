package com.nsgacademy.crudapp.controller;

import com.nsgacademy.crudapp.dao.UserDAO;
import com.nsgacademy.crudapp.dao.UserDAOImpl;
import com.nsgacademy.crudapp.exception.DAOException;
import com.nsgacademy.crudapp.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(urlPatterns = {"/","/user"})
public class UserServlet extends HttpServlet {
    UserDAO userDAO;
    @Override
    public void init() throws ServletException {
        userDAO = new UserDAOImpl(); // superclass reference subclass object // one time object initialization
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if(action==null) action="login";

        try{
            switch (action){
                case "register": showRegisterPage(req,resp);
                    break;
                case "doLogin": loginUser(req,resp);
                    break;
                case "doRegister": registerUser(req,resp);
                    break;
                case "logout" : logoutUser(req,resp);
                    break;
                default : showLoginPage(req,resp);
            }
        }catch (DAOException e){
            req.setAttribute("errorMessage",e.getMessage());
            req.setAttribute("cause",e.getCause());
            req.setAttribute("exception",e);
            req.getRequestDispatcher("error.jsp").forward(req,resp);
        }
    }

    private void logoutUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getSession().invalidate();
        resp.sendRedirect("user");
    }

    private void showRegisterPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        req.getRequestDispatcher("register.jsp").forward(req,resp);
    }

    private void showLoginPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        req.getRequestDispatcher("login.jsp").forward(req,resp);
    }

    private void loginUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username =  req.getParameter("username");
        String password =  req.getParameter("password");

        User user = userDAO.login(username,password);
        if(user!=null){
            req.getSession().setAttribute("user",user);
            resp.sendRedirect("student");
            return;
        }
        req.setAttribute("error","Invalid credential");
        req.getRequestDispatcher("login.jsp").forward(req,resp);
    }

    private void registerUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name =  req.getParameter("name");
        String mobile =  req.getParameter("mobile");
        String username =  req.getParameter("username");
        String password =  req.getParameter("password");

        if(userDAO.exists(username)){
            req.setAttribute("error","User already exist");
            req.getRequestDispatcher("register.jsp").forward(req,resp);
            return;
        }

        User user = new User(name,mobile,username,password);
        userDAO.register(user);
        resp.sendRedirect("user?success=Register Successfully");
    }
}