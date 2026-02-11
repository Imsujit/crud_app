package com.nsgacademy.crudapp.dao;

import com.nsgacademy.crudapp.exception.DAOException;
import com.nsgacademy.crudapp.model.Student;
import com.nsgacademy.crudapp.utils.JDBCUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class StudentDAOImpl implements StudentDAO {
    private static final String INSERT_SQL = "INSERT INTO student(name,email,mobile) VALUES(?,?,?)";
    private static final String DELETE_SQL = "DELETE FROM student WHERE id = ?";
    private static final String UPDATE_SQL = "UPDATE student SET name=? ,email=?, mobile=? WHERE id=?";
    private static final String GET_STUDENT_SQL = "SELECT * FROM student WHERE id=?";
    private static final String GET_ALL_STUDENT_SQL = "SELECT * FROM student ORDER BY id";

    @Override
    public void insert(Student student) {
        try(Connection con = JDBCUtils.fetchConnection();
            PreparedStatement psinsert = con.prepareStatement(INSERT_SQL)){
            psinsert.setString(1,student.getName());
            psinsert.setString(2,student.getEmail());
            psinsert.setString(3,student.getMobile());

            psinsert.executeUpdate();
        }catch(Exception e){
            throw new DAOException("Error during insertion: "+e.getMessage(),e);
        }
    }

    @Override
    public void delete(int id) {
        try(Connection con = JDBCUtils.fetchConnection();
            PreparedStatement psdelete = con.prepareStatement(DELETE_SQL)){
            psdelete.setInt(1,id);
            psdelete.executeUpdate();
        }catch(Exception e){
            throw new DAOException("Error during deletion: "+e.getMessage(),e);
        }
    }

    @Override
    public void update(Student student) {
        try(Connection con = JDBCUtils.fetchConnection();
            PreparedStatement psupdate = con.prepareStatement(UPDATE_SQL)){
            psupdate.setString(1,student.getName());
            psupdate.setString(2,student.getEmail());
            psupdate.setString(3,student.getMobile());
            psupdate.setInt(4,student.getId());

            psupdate.executeUpdate();
        }catch(Exception e){
            throw new DAOException("Error during updation: "+e.getMessage(),e);
        }
    }

    @Override
    public Student getStudentById(int id) {
        Student student=null;
        try(Connection con = JDBCUtils.fetchConnection();
            PreparedStatement psgetstudent = con.prepareStatement(GET_STUDENT_SQL)){
            psgetstudent.setInt(1,id);

            try(ResultSet rs = psgetstudent.executeQuery(GET_STUDENT_SQL)){
                if(rs.next()){
                    student = new Student(rs.getString("name"),rs.getString("email"),rs.getString("mobile"));
                }
            }
        }catch(Exception e){
            throw new DAOException("Error during fetching a student: "+e.getMessage(),e);
        }
        return student;
    }

    @Override
    public List<Student> getAllStudents() {
        List<Student> list = new ArrayList<>();
        try(Connection con = JDBCUtils.fetchConnection();
            PreparedStatement psgetallstudent = con.prepareStatement(GET_ALL_STUDENT_SQL)){
            try(ResultSet rs = psgetallstudent.executeQuery()){
                while(rs.next()){
                    list.add(new Student(rs.getInt("id"),rs.getString("name"),rs.getString("email"),rs.getString("mobile")));
                }
            }
        }catch(Exception e){
            throw new DAOException("Error during fetching all students: "+e.getMessage(),e);
        }
        return list;
    }
}
