package com.nsgacademy.crudapp.dao;

import com.nsgacademy.crudapp.exception.DAOException;
import com.nsgacademy.crudapp.model.User;
import com.nsgacademy.crudapp.utils.JDBCUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAOImpl implements UserDAO{
    private static final String REGISTER_SQL = "INSERT INTO users(name,mobile,username,password) values(?,?,?,?)";
    private static final String LOGIN_SQL = "SELECT * FROM users WHERE username=? AND password=?";
    private static final String EXISTS_SQL = "SELECT 1 FROM users WHERE username=?";

    @Override
    public void register(User user) {
        try(Connection con = JDBCUtils.fetchConnection();
            PreparedStatement stmt =  con.prepareStatement(REGISTER_SQL)){

            stmt.setString(1,user.getName());
            stmt.setString(2,user.getMobile());
            stmt.setString(3,user.getUsername());
            stmt.setString(4,user.getPassword());

            stmt.executeUpdate();

        }catch(SQLException e){
            throw new DAOException("Registration Failed!"+e.getMessage(),e);
        }
    }

    @Override
    public User login(String username, String password) {
        User user=null;
        try(Connection con = JDBCUtils.fetchConnection();
            PreparedStatement stmt = con.prepareStatement(LOGIN_SQL)){

            stmt.setString(1,username);
            stmt.setString(2,password);

            try(ResultSet rs = stmt.executeQuery()){
                if(rs.next()) {
                    user = new User(rs.getInt(1),
                            rs.getString(2),
                            rs.getString(3),
                            rs.getString(4),
                            rs.getString(5));
                }
            }

        }catch (SQLException e){
            throw new DAOException("Login Failed!"+e.getMessage(),e);
        }
        return user;
    }

    @Override
    public boolean exists(String username) {
        try(Connection con = JDBCUtils.fetchConnection();
           PreparedStatement stmt = con.prepareStatement(EXISTS_SQL)){

            stmt.setString(1,username);

            try(ResultSet rs = stmt.executeQuery()){
                return rs.next();
            }

        }catch (SQLException e){
            throw new DAOException("User Exist Error"+e.getMessage(),e);
        }
    }
}