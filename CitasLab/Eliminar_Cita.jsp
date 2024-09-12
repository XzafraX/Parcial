<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.SQLException"%>

<%
    Connection conexion = null;
    Statement sentencia = null;
    int filas = 0;
    String ID_Lab = request.getParameter("ID_Lab");

    try {
        // Cargar el driver de PostgreSQL
        Class.forName("org.postgresql.Driver");
        
        // Conectar a la base de datos PostgreSQL
        conexion = DriverManager.getConnection("jdbc:postgresql://localhost:5433/Hospital", "postgres", "password");
        
        // Crear la sentencia SQL
        sentencia = conexion.createStatement();
       String consultaSQL = "DELETE FROM Citas_Lab WHERE ID_Lab = '" + ID_Lab + "'";
        
        
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
