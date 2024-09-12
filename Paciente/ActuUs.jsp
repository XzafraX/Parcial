<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>

<%
    // Obtener los parámetros del formulario
ñ
    String telefono = request.getParameter("telefono");
    String ciudad = request.getParameter("ciudad");
    String correo = request.getParameter("correo");
    String estadoCivil = request.getParameter("estadoCivil");
    String direccion = request.getParameter("direccion");
     String Ced_Paciente = (String) session.getAttribute("Ced_Paciente");
        if (Ced_Paciente == null) {
            response.sendRedirect("../Acceso/login.html");
            return;
        }

    Connection conexion = null;
    PreparedStatement pstmt = null;

    try {
        // Cargar el driver de PostgreSQL
        Class.forName("org.postgresql.Driver");

        // Establecer conexión con la base de datos
        conexion = DriverManager.getConnection(
            "jdbc:postgresql://localhost:5433/Hospital", "postgres", "password");

        // Preparar la consulta de actualización
        String sql = "UPDATE Paciente SET  Tel_Paciente = ?, Ciudad = ?, Email_Paciente = ?, Estado_C = ?, Dir_Paciente = ? WHERE  Ced_Paciente = '" + Ced_Paciente + "'";
        pstmt = conexion.prepareStatement(sql);
       
        pstmt.setString(1, telefono);
        pstmt.setString(2, ciudad);
        pstmt.setString(3, correo);
        pstmt.setString(4, estadoCivil);
        pstmt.setString(5, direccion);
        

        int filas = pstmt.executeUpdate();

        if (filas > 0) {
            // Redirigir a la página de éxito si la actualización fue exitosa
            response.sendRedirect("usuarios.jsp"); 
        } else {
            // Mostrar un mensaje si la actualización no tuvo éxito
            out.println("No se pudo actualizar los datos. Por favor, intente de nuevo.");
        }
    } catch (ClassNotFoundException e) {
        
        out.println("Error en la carga del driver: " + e.getMessage());
    } catch (SQLException e) {
        // Manejar errores relacionados con la base de datos
        out.println("Error accediendo a la base de datos: " + e.getMessage());
    } finally {
        // Cerrar los recursos
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { out.println("Error cerrando la sentencia: " + e.getMessage()); }
        if (conexion != null) try { conexion.close(); } catch (SQLException e) { out.println("Error cerrando la conexión: " + e.getMessage()); }
    }
%>
