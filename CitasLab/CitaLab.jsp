<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.SQLException"%>

<%
    // Variables
    String Descripcion= request.getParameter("descripcion");
    String Fecha = request.getParameter("fecha");
    String Hora = request.getParameter("hora");
    String Ced_Medico = request.getParameter("Ced_Medico");
    String Ced_Paciente = (String) session.getAttribute("Ced_Paciente");
    if (Ced_Paciente == null) {
        response.sendRedirect("../Acceso/login.html");
    }

    Connection conexion = null;
    Statement sentencia = null;
    int filas = 0;

    try {
        
        Class.forName("org.postgresql.Driver");
        
        // Conectar a la base de datos PostgreSQL
        conexion = DriverManager.getConnection("jdbc:postgresql://localhost:5433/Hospital", "postgres", "password");
        
        sentencia = conexion.createStatement();
        String consultaSQL = "INSERT INTO Citas_Lab (Descripcion_Lab,Fecha_CLab,Hora,Ced_Medico,Ced_Paciente) VALUES ";
        consultaSQL += "('" + Descripcion + "', '" + Fecha + "', '" + Hora + "', '" + Ced_Medico + "','"+Ced_Paciente+"')";
        
        // Ejecutar la sentencia
        filas = sentencia.executeUpdate(consultaSQL);
        
        // Redirigir a otra página
        response.sendRedirect("verCitaLaboratorio.jsp");
        
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
