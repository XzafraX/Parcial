<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ver y Editar Datos - CuritasEPS</title>
    <style>
        /* Estilos básicos */
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #0a75cd; /* Fondo azul */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh; /* Full viewport height */
        }
        .container {
            background-color: #f5f5dc; /* Color beige */
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            text-align: center;
            width: 80%; /* Ajustar el ancho del contenedor */
            max-width: 800px; /* Ancho máximo del contenedor */
            overflow-x: auto; /* Para manejar el desbordamiento en pantallas pequeñas */
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #007bff;
            color: #fff;
        }
        td input, td select, td textarea {
            width: 100%;
            border: none;
            box-sizing: border-box; /* Para que el padding se incluya en el ancho total */
        }
        td input[type="text"], td input[type="email"], td input[type="tel"] {
            background-color: #fff;
        }
        td select, td textarea {
            background-color: #f9f9f9;
        }
        button {
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
        .container a {
            display: block;
            margin-top: 10px;
            color: #007bff;
            text-decoration: none;
        }
        .container a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <%
        String Ced_Paciente = (String) session.getAttribute("Ced_Paciente");
        if (Ced_Paciente == null) {
            response.sendRedirect("../Acceso/login.html");
            return;
        }

        Connection conexion = null;
        Statement sentencia = null;
        ResultSet rs = null;
        try {
            Class.forName("org.postgresql.Driver");
            conexion = DriverManager.getConnection(
                "jdbc:postgresql://localhost:5433/Hospital", "postgres", "password");
            sentencia = conexion.createStatement();
            String consultaSQL = "SELECT Ced_Paciente, Nom_Paciente, Email_Paciente, Tel_Paciente, Ciudad, Dir_Paciente, Estado_C FROM Paciente WHERE Ced_Paciente = '" + Ced_Paciente + "'";
            rs = sentencia.executeQuery(consultaSQL);
            if (rs.next()) {
    %>
    <div class="container">
        <h1>Ver y Editar Datos</h1>
        <form action="ActuUs.jsp" method="post">
            <table>
                <thead>
                    <tr>
                        <th>Campo</th>
                        <th>Valor</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Nombre Completo</td>
                        <td><input type="text" name="nombre" value="<%= rs.getString("Nom_Paciente") %>" disabled></td>
                    </tr>
                    <tr>
                        <td>Cédula</td>
                        <td><input type="text" name="cedula" value="<%= rs.getString("Ced_Paciente") %>" disabled></td>
                    </tr>
                    <tr>
                        <td>Número de Teléfono</td>
                        <td><input type="tel" name="telefono" value="<%= rs.getString("Tel_Paciente") %>" required></td>
                    </tr>
                    <tr>
                        <td>Ciudad</td>
                        <td><input type="text" name="ciudad" value="<%= rs.getString("Ciudad") %>" required></td>
                    </tr>
                    <tr>
                        <td>Correo Electrónico</td>
                        <td><input type="text" name="correo" value="<%= rs.getString("Email_Paciente") %>" required></td>
                    </tr>
                    <tr>
                        <td>Estado Civil</td>
                        <td>
                            <select name="estadoCivil" required>
                                <option value="soltero" <%= "soltero".equals(rs.getString("Estado_C")) ? "selected" : "" %>>Soltero</option>
                                <option value="casado" <%= "casado".equals(rs.getString("Estado_C")) ? "selected" : "" %>>Casado</option>
                                <option value="divorciado" <%= "divorciado".equals(rs.getString("Estado_C")) ? "selected" : "" %>>Divorciado</option>
                                <option value="viudo" <%= "viudo".equals(rs.getString("Estado_C")) ? "selected" : "" %>>Viudo</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Dirección</td>
                        <td><textarea name="direccion" rows="4" required><%= rs.getString("Dir_Paciente") %></textarea></td>
                    </tr>
                </tbody>
            </table>
            <button type="submit">Guardar Cambios</button>
        </form>
        <a href="usermenu.html">Cancelar</a>
    </div>
    <%
            } else {
                out.println("No se encontraron datos para el usuario.");
            }
        } catch (ClassNotFoundException e) {
            out.println("Error en la carga del driver: " + e.getMessage());
        } catch (SQLException e) {
            out.println("Error accediendo a la base de datos: " + e.getMessage());
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { out.println("Error cerrando ResultSet: " + e.getMessage()); }
            if (sentencia != null) try { sentencia.close(); } catch (SQLException e) { out.println("Error cerrando Statement: " + e.getMessage()); }
            if (conexion != null) try { conexion.close(); } catch (SQLException e) { out.println("Error cerrando Connection: " + e.getMessage()); }
        }
    %>
</body>
</html>
