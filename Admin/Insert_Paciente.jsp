<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection,java.sql.Statement,java.sql.DriverManager,java.sql.SQLException"%>

<%
    // Variables
    String Ced_Paciente = request.getParameter("Ced_Paciente");
    String Nom_Paciente = request.getParameter("Nom_Paciente");
    String Email_Paciente = request.getParameter("Email_Paciente");
    String Tel = request.getParameter("Tel_Paciente");
    String Ciudad = request.getParameter("Ciudad");
    String Direccion = request.getParameter("Dir_Paciente");
    String Estado = request.getParameter("Estado_C");
    String Pswd = request.getParameter("Ced_Paciente");
    String Historia = request.getParameter("Historia"); 

    Connection conexion = null;
    Statement sentencia = null;
    int filas = 0;

    try {
        // Cargar el driver de PostgreSQL
        Class.forName("org.postgresql.Driver");
        
        // Conectar a la base de datos PostgreSQL
        conexion = DriverManager.getConnection("jdbc:postgresql://localhost:5433/Hospital", "postgres", "password");
        
        // Crear la sentencia SQL
        sentencia = conexion.createStatement();
        String consultaSQL = "INSERT INTO Paciente (Ced_Paciente, Nom_Paciente, Email_Paciente, Tel_Paciente, Ciudad, Dir_Paciente, Estado_C, Pswd_Pac, Historia) VALUES ('" 
            + Ced_Paciente + "', '" + Nom_Paciente + "', '" + Email_Paciente + "', '" + Tel + "', '" + Ciudad + "', '" + Direccion + "', '" + Estado + "', '" + Pswd + "', '" + Historia + "')";

        // Ejecutar la sentencia
        filas = sentencia.executeUpdate(consultaSQL);

        // Redirigir a otra página solo si se insertaron filas
        if (filas > 0) {
            response.sendRedirect("useredit.jsp");
        } else {
            out.println("<p>No se pudo insertar el paciente.</p>");
        }
        
    } catch (ClassNotFoundException e) {
        out.println("Error en la carga del driver: " + e.getMessage());
    } catch (SQLException e) {
        out.println("Error accediendo a la base de datos: " + e.getMessage());
    } finally {
        // Cerrar la sentencia
        if (sentencia != null) {
            try {
                sentencia.close();
            } catch (SQLException e) {
                out.println("Error cerrando la sentencia: " + e.getMessage());
            }
        }
        // Cerrar la conexión
        if (conexion != null) {
            try {
                conexion.close();
            } catch (SQLException e) {
                out.println("Error cerrando la conexión: " + e.getMessage());
            }
        }
    }
%>
