<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Citas Registradas</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #0270ca;
            color: #333;
        }
        .container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            text-align: center;
            color: #0270ca;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #0270ca;
            color: #fff;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .button-container {
            text-align: center;
            margin-top: 20px;
        }
        a.delete-btn {
    padding: 8px 12px;
    background-color: #dc3545; /* Rojo para eliminar */
    color: #fff;
    text-decoration: none;
    border-radius: 5px;
    font-size: 14px;
    margin-right: 5px;
    display: inline-block;
}

a.edit-btn {
    padding: 8px 12px;
    background-color: #28a745; /* Verde para editar */
    color: #fff;
    text-decoration: none;
    border-radius: 5px;
    font-size: 14px;
    margin-right: 5px;
    display: inline-block;
}

a.delete-btn:hover, a.edit-btn:hover {
    opacity: 0.9;
}

        .button-container a {
            display: inline-block;
            padding: 10px 20px;
            margin-top: 10px;
            background-color: #0270ca;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
        }
        .button-container a:hover {
            background-color: #025a9e;
        }
    </style>
</head>
<body>
    <%
    Connection conexion = null;
    Statement sentencia = null;
    ResultSet rs = null;
    try {
        Class.forName("org.postgresql.Driver");
        conexion = DriverManager.getConnection(
            "jdbc:postgresql://localhost:5433/Hospital", "postgres", "password");
        sentencia = conexion.createStatement();

        
        String consultaSQL = "SELECT Citas_G.ID_Cita, Citas_G.Descripcion, Citas_G.FechaCGen, Citas_G.Hora, Medico.Nom_Medico " +
                             "FROM Citas_G " +
                             "JOIN Medico ON Citas_G.Ced_Medico = Medico.Ced_Medico";

        rs = sentencia.executeQuery(consultaSQL);
    %>
    <div class="container">
        <h1>Citas Registradas</h1>
        <table id="citasTable">
            <thead>
                <tr>
                    <th>Nombre del Médico</th>
                    <th>Hora</th>
                    <th>Fecha</th>
                    <th>Descripción</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <% while (rs.next()) { %>
                    <tr>
                        <td><%= rs.getString("Nom_Medico") %></td>
                        <td><%= rs.getString("Hora") %></td>
                        <td><%= rs.getString("FechaCGen") %></td>
                        <td><%= rs.getString("Descripcion") %></td>
                        <td class="actions">
                                <a class="delete-btn" href="Eliminar_Cita.jsp?ID_Cita=<%= rs.getString("ID_Cita") %>">Eliminar</a>
                              <a class="edit-btn" href="editarCitasGen.jsp?ID_Cita=<%= rs.getString("ID_Cita") %>">Editar</a>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
        <div class="button-container">
            <a href="../Paciente/usermenu.html">Regresar al menú de usuario</a>
        </div>
    </div>
    <%
    } catch (ClassNotFoundException e) {
        out.println("Error en la carga del driver: " + e.getMessage());
    } catch (SQLException e) {
        out.println("Error accediendo a la base de datos: " + e.getMessage());
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { out.println("Error cerrando el ResultSet: " + e.getMessage()); }
        if (sentencia != null) try { sentencia.close(); } catch (SQLException e) { out.println("Error cerrando la sentencia: " + e.getMessage()); }
        if (conexion != null) try { conexion.close(); } catch (SQLException e) { out.println("Error cerrando la conexión: " + e.getMessage()); }
    }
    %>
</body>
</html>
