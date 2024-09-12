<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet"%>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    Connection conexion = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    boolean loginSuccess = false;
    String Ced_Paciente = null;

    try {
        // Verificar que los parámetros no sean nulos
        if (username != null && password != null) {
            // Cargar el driver y establecer la conexión
            Class.forName("org.postgresql.Driver");
            conexion = DriverManager.getConnection("jdbc:postgresql://localhost:5433/Hospital", "postgres", "password");

            // Preparar la consulta para evitar inyección SQL
            String sql = "SELECT Ced_Paciente FROM Paciente WHERE Email_Paciente = ? AND Pswd_Pac = ?";
            pstmt = conexion.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, password);

            rs = pstmt.executeQuery();

            // Si hay un resultado, el login es exitoso
            if (rs.next()) {
                Ced_Paciente = rs.getString("Ced_Paciente");
                session.setAttribute("Ced_Paciente", Ced_Paciente); // Guardar la cédula en la sesión
                loginSuccess = true;
            }
        } else {
            out.println("Usuario o contraseña no proporcionados.");
        }
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        // Cerrar los recursos
        if (rs != null) try { rs.close(); } catch (Exception e) { out.println("Error al cerrar ResultSet: " + e.getMessage()); }
        if (pstmt != null) try { pstmt.close(); } catch (Exception e) { out.println("Error al cerrar PreparedStatement: " + e.getMessage()); }
        if (conexion != null) try { conexion.close(); } catch (Exception e) { out.println("Error al cerrar la conexión: " + e.getMessage()); }
    }

    // Redirigir según el resultado del login
    if (loginSuccess) {
        response.sendRedirect("../Paciente/usermenu.html");
    } else {
        out.println("<p>Usuario o contraseña incorrectos</p>");
    }
%>
