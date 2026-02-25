package com.nsgacademy.crudapp.utils;

import com.nsgacademy.crudapp.exception.DAOException;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class JDBCUtils {
//    private static final String URL = "jdbc:postgresql://localhost:5432/crudapp";
//    private static final String USERNAME = "postgres";
//    private static final String PASSWORD = "password";

    private static final String JDBC_HOST = System.getenv("JDBC_HOST") != null ? System.getenv("JDBC_HOST") : "localhost";
    private static final String JDBC_PORT = System.getenv("JDBC_PORT") != null ? System.getenv("JDBC_PORT") : "5432";
    private static final String JDBC_DB = System.getenv("JDBC_DB") != null ? System.getenv("JDBC_DB") : "crudapp";
    private static final String JDBC_USERNAME = System.getenv("JDBC_USERNAME") != null ? System.getenv("JDBC_USERNAME") : "postgres";
    private static final String JDBC_PASSWORD = System.getenv("JDBC_PASSWORD") != null ? System.getenv("JDBC_PASSWORD") : "password";

    private static final String JDBC_URL = "jdbc:postgresql://" + JDBC_HOST + ":" + JDBC_PORT + "/" + JDBC_DB;

    static{
        try{
            Class.forName("org.postgresql.Driver");
        }catch(ClassNotFoundException e){
            throw new DAOException("Unable to load driver");
        }
    }

    public static Connection fetchConnection() throws SQLException {
        return DriverManager.getConnection(JDBC_URL,JDBC_USERNAME,JDBC_PASSWORD);
    }
}