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
        String Ced_Medico = (String) request.getParameter("Ced_Medico");

        Connection conexion = null;
        Statement sentencia = null;
        ResultSet rs = null;
        try {
            Class.forName("org.postgresql.Driver");
            conexion = DriverManager.getConnection(
                "jdbc:postgresql://localhost:5433/Hospital", "postgres", "password");
            sentencia = conexion.createStatement();
            String consultaSQL = "SELECT Ced_Medico, Nom_Medico, Email_Medico, Tel_Medico, Categoria, Pswd_Medico FROM Medico WHERE Ced_Medico = '" + Ced_Medico + "'";
            rs = sentencia.executeQuery(consultaSQL);
            if (rs.next()) {
    %>
    <div class="container">
        <h1>Ver y Editar Datos de Medico</h1>
        <form action="EditarMedico.jsp" method="post">
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
                        <td><input type="text" name="nombre" value="<%= rs.getString("Nom_Medico") %>" disabled></td>
                    
                    </tr>
                    <tr>
                        <td>Cédula</td>
                        <td><input type="text" name="cedula" value="<%= rs.getString("Ced_Medico") %>" disabled></td>
                        <input type="hidden" name="cedula" value="<%= rs.getString("Ced_Medico") %>">

                    </tr>
                    <tr>
                        <td>Número de Teléfono</td>
                        <td><input type="text" name="telefono" value="<%= rs.getString("Tel_Medico") %>"></td>
                    </tr>
                    <tr>
                        <td>Correo Electrónico</td>
                        <td><input type="text" name="correo" value="<%= rs.getString("Email_Medico") %>"></td>
                    </tr>
                      <tr>
                        <td>Categoria</td>
                        <td>
                        
                          <select name="categoria" required>
                                <option value="Medico General" <%= "Medico General".equals(rs.getString("Categoria")) ? "selected" : "" %>>Medico General</option>
                 <option value="Medico Laboratorio" <%= "Medico Laboratorio".equals(rs.getString("Categoria")) ? "selected" : "" %>>Medico Laboratorio</option>
                            </select>
                          </td>
                     </tr>
                    <tr>
                        <td>Contraseña</td>
                        <td><input type="text" name="Pswd_Medico" value="<%= rs.getString("Pswd_Medico") %>"></td>
                    </tr>
                </tbody>
            </table>
            <!-- Martes 17. Se actualizó el botón, y ahora al darle click aparecerá una alerta en la zona superior que informa sobre la actualización exitosa de los datos -->
            <button type="submit" onclick="alert('Información editada con exito.')">Guardar Cambios</button>
        </form>
        <!-- Enlace para cancelar y volver a la página principal -->
        <a href="../Medico/medicos.jsp">Cancelar</a>
    </div>
    <%
} else {
    out.println("No se encontraron datos para el usuario.");
}
} catch (ClassNotFoundException e) {
out.println("Error en la carga del driver: " + e.getMessage());
} catch (SQLException e) {
out.println("Error accediendo a la base de datos: " + e.getMessage());
} 
%>
</body>
</html>
