<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet"%>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    Connection conexion = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    boolean loginSuccess = false;

    try {
        // Verificar que los parámetros no sean nulos
        if (username != null && password != null && !username.isEmpty() && !password.isEmpty()) {
            // Cargar el driver y establecer la conexión
            Class.forName("org.postgresql.Driver");
            conexion = DriverManager.getConnection("jdbc:postgresql://localhost:5433/Hospital", "postgres", "password");

            // Preparar la consulta para evitar inyección SQL
            String sql = "SELECT Ced_Admin FROM Administrador WHERE Email_Admin = ? AND Pswd_Admin = ?";
            pstmt = conexion.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, password);

            rs = pstmt.executeQuery();

            // Si hay un resultado, el login es exitoso
            if (rs.next()) {
                loginSuccess = true;
            }
        } else {
            out.println("<p>Usuario o contraseña no pueden estar vacíos.</p>");
        }
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        // Cerrar los recursos
        if (rs != null) try { rs.close(); } catch (Exception e) { out.println("<p>Error al cerrar ResultSet: " + e.getMessage() + "</p>"); }
        if (pstmt != null) try { pstmt.close(); } catch (Exception e) { out.println("<p>Error al cerrar PreparedStatement: " + e.getMessage() + "</p>"); }
        if (conexion != null) try { conexion.close(); } catch (Exception e) { out.println("<p>Error al cerrar la conexión: " + e.getMessage() + "</p>"); }
    }

    // Redirigir según el resultado del login
    if (loginSuccess) {
        // Se podría establecer una sesión aquí, si es necesario
        response.sendRedirect("../Admin/adminmenu.html");
    } else {
        out.println("<p>Usuario o contraseña incorrectos</p>");
    }
%>
