package com.nsgacademy.crudapp.utils;

import com.sun.jdi.ClassNotLoadedException;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class JDBCUtils {
    private static final String URL = "jdbc:postgresql://localhost/crudapp";
    private static final String USERNAME = "postgres";
    private static final String PASSWORD = "password";

    static{
        try{
            Class.forName("org.postgresql.Driver");
        }catch(ClassNotFoundException e){
            System.out.println(e.getMessage());
        }
    }

    public static Connection fetchConnection() throws SQLException {
        return DriverManager.getConnection(URL,USERNAME,PASSWORD);
    }
}
