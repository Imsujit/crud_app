# 📘 MVC CRUD Application using JSP, Servlet, and JDBC (PostgreSQL)

A clean and modular **MVC web application** built using **JSP, Servlets, JDBC, and PostgreSQL**.  
This project demonstrates a professional backend structure with proper MVC layering, centralized error handling, Bootstrap UI, and complete CRUD operations.

GitHub Repository: **https://github.com/Imsujit/crud_app**

---

## 🚀 Features

### ✔ Core CRUD Operations
- Add a new student  
- List all students  
- Edit/update student  
- Delete student  
- Success notifications after each operation  
- Validation (client-side + server-side)

### ✔ MVC Architecture
- **Model:** `Student.java`  
- **DAO Layer:**  
  - `StudentDAO.java`  
  - `StudentDAOImpl.java`  
  - `DAOException.java` *(inside exception package)*  
- **Controller:** `StudentServlet.java`  
- **View:** JSP pages (`student-list.jsp`, `student-form.jsp`, `error.jsp`)

### ✔ UI / UX Enhancements
- Bootstrap-based responsive design  
- Modern table layout  
- Validation error messages  
- Confirmation on delete  
- Form data retention on validation failure  

### ✔ Error Handling
- Centralized `error.jsp`  
- Custom `DAOException` inside `exception` package  
- Root cause details shown on development mode  

---

## 🛠️ Technology Stack

| Layer | Technology |
|-------|------------|
| Frontend | JSP, HTML5, Bootstrap 5 |
| Controller | Servlets (Jakarta EE 10) |
| Backend | Java 21+ |
| Database | PostgreSQL |
| DB Access | JDBC (Prepared Statements) |
| Server | Apache Tomcat 11 |
| Build Tool | Maven |

---

## 📂 Project Structure

```
crud_app/
│
├── src/main/java/com/nsgacademy/crudapp/
│   ├── controller/
│   │   └── StudentServlet.java
│   │
│   ├── dao/
│   │   ├── StudentDAO.java
│   │   ├── StudentDAOImpl.java
│   │
│   ├── exception/
│   │   └── DAOException.java
│   │
│   ├── model/
│   │   └── Student.java
│   │
│   └── utils/
│       └── JDBCUtils.java
│
└── src/main/webapp/
    ├── student-list.jsp
    ├── student-form.jsp
    ├── error.jsp
    └── WEB-INF/
        └── web.xml (optional)
```

---

## 🗄️ Database Setup (PostgreSQL)

Create database:

```sql
CREATE DATABASE crudapp;
```

Create table:

```sql
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    mobile VARCHAR(15) NOT NULL
);
```

Update **JDBCUtils.java**:

```java
private static final String URL = "jdbc:postgresql://localhost:5432/crudapp";
private static final String USER = "postgres";
private static final String PASSWORD = "your_password";
```

---

## ⚙️ How to Run the Project

### 1️⃣ Clone the repository

```bash
git clone https://github.com/Imsujit/crud_app.git
```

### 2️⃣ Import into your IDE
- IntelliJ IDEA / Eclipse / VS Code  
- Open as **Maven Project**

### 3️⃣ Configure PostgreSQL
- Ensure DB `crudapp` exists  
- Run the table creation SQL  

### 4️⃣ Configure Tomcat
- Add Tomcat 11  
- Deploy the WAR or exploded artifact  

### 5️⃣ Access the application

```
http://localhost:8080/crud_app/
```

---

## 🧪 Validation Features

### Client-Side
- Required fields  
- Email format validation  
- Mobile number regex (10 digits)  
- Name pattern restrictions  

### Server-Side
- All input validated again on the backend  
- Errors displayed inline on form  
- User input retained after validation failure  

---

## 🐞 Error Handling

- All database errors wrapped in `DAOException`  
- `StudentServlet` catches and forwards to `error.jsp`  
- Error page displays:
  - Error message  
  - Exception stack trace  
  - Root cause for debugging  

---

## 🔮 Future Enhancements

- Pagination  
- Sorting  
- Searching  
- Student photo upload  
- Gender + DOB + Age calculation  
- Import (CSV/Excel)  
- Export (CSV/Excel/PDF)  
- Login system & roles (User / Admin)  
- Audit logs  
- Deployment configuration  

---

## 📸 Screenshots

### ▶ Student List Page  
<img width="1920" height="1140" alt="student-list" src="https://github.com/user-attachments/assets/3c45f93a-5f8e-4cfd-9644-2305c37f9edc" />



### ▶ Add/Edit Form and Delete 
<img width="1920" height="1140" alt="add-form" src="https://github.com/user-attachments/assets/1170bf5d-7591-4bfb-8a84-0c6671fe9280" />
<img width="1920" height="1140" alt="add-student-success" src="https://github.com/user-attachments/assets/d190d54e-d808-4e28-bdf7-8d5b8dbc463e" />
<img width="1920" height="1140" alt="edit-form" src="https://github.com/user-attachments/assets/3993fa7d-4570-47ec-839d-4f006768896d" />
<img width="1920" height="1140" alt="delete-success" src="https://github.com/user-attachments/assets/65d7e422-2df7-47bb-861d-dea8b083cb1a" />
<img width="1920" height="1140" alt="delete-confirmation" src="https://github.com/user-attachments/assets/3d96c1bf-1f50-4c71-8c98-5d5d7c108aa6" />


### ▶ Error Page  
<img width="1920" height="1140" alt="error-page" src="https://github.com/user-attachments/assets/7ba9edcb-4019-4fd9-9da5-78296ee9cbc5" />


---

## 🤝 Contributing

Pull requests and feature suggestions are welcome!  

---

## 📄 License

This project is open-source and licensed under the **MIT License**.

---

## 🙏 Acknowledgement

Developed as a modular and extendable CRUD foundation before adding advanced features such as import/export, authentication, and more.
