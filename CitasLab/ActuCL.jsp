<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>

<%
   //Variables
    String descripcion = request.getParameter("descripcion");
    String fecha = request.getParameter("fecha");
    String hora = request.getParameter("hora");
    String ced = request.getParameter("medico");
    int ID_Lab = Integer.parseInt(request.getParameter("ID_Lab"));
    Connection conexion = null;
    PreparedStatement pstmt = null;

    try {

        Class.forName("org.postgresql.Driver");
        conexion = DriverManager.getConnection(
            "jdbc:postgresql://localhost:5433/Hospital", "postgres", "password");

        String sql = "UPDATE Citas_Lab SET Descripcion_Lab = ?, Fecha_CLab = ?, Hora = ?, Ced_Medico = ? WHERE ID_Lab = ?";
      
        pstmt = conexion.prepareStatement(sql);
       
        pstmt.setString(1, descripcion);
        pstmt.setString(2, fecha);
        pstmt.setString(3, hora);
        pstmt.setString(4, ced);
        pstmt.setInt(5, ID_Lab);

        
        out.println("SQL: " + pstmt);

        int filas = pstmt.executeUpdate();
    response.sendRedirect("verCitaLaboratorio.jsp"); 
       
    } catch (ClassNotFoundException e) {  
        out.println("Error en la carga del driver: " + e.getMessage());
    } catch (SQLException e) {
        out.println("Error accediendo a la base de datos: " + e.getMessage());
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { out.println("Error cerrando la sentencia: " + e.getMessage()); }
        if (conexion != null) try { conexion.close(); } catch (SQLException e) { out.println("Error cerrando la conexión: " + e.getMessage()); }
    }
%>
