package com.nsgacademy.crudapp.dao;

import com.nsgacademy.crudapp.model.Pagination;
import com.nsgacademy.crudapp.model.Student;

import java.util.List;

public interface StudentDAO {
    void insert(Student student);
    void delete(int id);
    void update(Student student);
    Student getStudentById(int id);
    List<Student> getSelectedStudent(Pagination pagination);
    int countStudents();
}