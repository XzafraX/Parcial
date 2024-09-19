<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>

<%
    // Obtener los parámetros del formulario
    String Ced_Medico = request.getParameter("cedula");
    String telefono = request.getParameter("telefono");
    String correo = request.getParameter("correo");
    String categoria = request.getParameter("categoria");
    String Pswd_Medico = request.getParameter("Pswd_Medico");

    Connection conexion = null;
    PreparedStatement pstmt = null;

    try {
        // Cargar el driver de PostgreSQL
        Class.forName("org.postgresql.Driver");

        // Establecer conexión con la base de datos
        conexion = DriverManager.getConnection(
            "jdbc:postgresql://localhost:5433/Hospital", "postgres", "password");

        // Preparar la consulta de actualización
        String sql = "UPDATE Medico SET Tel_Medico = ?, Email_Medico = ?, categoria = ?, Pswd_Medico = ? WHERE Ced_Medico = '" + Ced_Medico + "'";
        pstmt = conexion.prepareStatement(sql);
       
        pstmt.setString(1, telefono);
        pstmt.setString(2, correo);
        pstmt.setString(3, categoria);
        pstmt.setString(4, Pswd_Medico);

        // Depuración: Imprimir SQL
        out.println("SQL: " + pstmt);

        int filas = pstmt.executeUpdate();
    response.sendRedirect("medicos.jsp"); 
       
    } catch (ClassNotFoundException e) {  
        out.println("Error en la carga del driver: " + e.getMessage());
    } catch (SQLException e) {
        out.println("Error accediendo a la base de datos: " + e.getMessage());
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { out.println("Error cerrando la sentencia: " + e.getMessage()); }
        if (conexion != null) try { conexion.close(); } catch (SQLException e) { out.println("Error cerrando la conexión: " + e.getMessage()); }
    }
%>
