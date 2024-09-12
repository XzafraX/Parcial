<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.SQLException"%>

<%
    // Variables
    String Nombre = request.getParameter("Ced_Pacientes");
    String Email = request.getParameter("Nom_Paciente");
    String Pswd = request.getParameter("Email_paciente");
    String CPswd = request.getParameter("Tel_Paciente");
    String Genero = request.getParameter("Pswd_Pac");
    String Fecha = request.getParameter("Historia"); // Asegúrate de que esté en formato YYYY-MM-DD

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
        String consultaSQL = "INSERT INTO usuarios (Nombre, Email, Pswd, CPswd, Genero, Fecha, Direccion) VALUES ";
        consultaSQL += "('" + Nombre + "', '" + Email + "', '" + Pswd + "', '" + CPswd + "', '" + Genero + "', '" + Fecha + "', '" + Direccion + "')";
        
        // Ejecutar la sentencia
        filas = sentencia.executeUpdate(consultaSQL);
        
        // Redirigir a otra página
        response.sendRedirect("Mostrar_Card2.jsp");
        
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
