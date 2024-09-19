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
    <title>Edición de Usuarios - CuritasEPS</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #0a75cd;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background-color: #f5f5dc;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            text-align: center;
            width: 80%;
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
            color: white;
        }
        button.edit-btn {
    padding: 8px 12px;
    background-color: #28a745; /* Verde para editar */
    color: #fff;
    border: none;
    border-radius: 5px;
    font-size: 14px;
    cursor: pointer;
}
        button {
            padding: 5px 10px;
            margin: 2px;
            border: none;
            border-radius: 4px;
            color: white;
            cursor: pointer;
        }
        a.delete-btn:hover, a.edit-btn:hover {
    opacity: 0.9;
}

    </style>
</head>
<body>
<%
Connection conexion=null;
Statement sentencia=null;
ResultSet rs=null;
try {
Class.forName("org.postgresql.Driver");

conexion = DriverManager.getConnection(

    "jdbc:postgresql://localhost:5433/Hospital", "postgres","password");
sentencia = conexion.createStatement();
//2
String consultaSQL= "select Ced_Paciente, Nom_Paciente, Email_Paciente, Tel_Paciente, Ciudad, Dir_Paciente, Estado_C from Paciente";
//3 y 4
//rs REPETIR consulta
rs=sentencia.executeQuery(consultaSQL);
//5
%>
    <div class="container">
        <h1>Lista de Usuarios</h1>
        <table>
            <thead>
                <tr>
                    <th>Nombre</th>
                    <th>Cédula</th>
                    <th>Teléfono</th>
                    <th>Ciudad</th>
                    <th>Direccion</th>
                    <th>Estado Civil</th>
                    <th>Correo</th>
                </tr>
                <% while(rs.next()) {%>
                <tr>
<td> <%=rs.getString("Nom_Paciente")%></td> 
<td> <%=rs.getString("Ced_Paciente")%></td> 
<td> <%=rs.getString("Tel_Paciente")%></td> 
<td> <%=rs.getString("Ciudad")%></td> 
<td> <%=rs.getString("Dir_Paciente")%></td> 
<td> <%=rs.getString("Estado_C")%></td> 
<td> <%=rs.getString("Email_Paciente")%></td>
</tr> 
<% }
}catch (ClassNotFoundException e) {
out.println("Error en la carga del driver"
+ e.getMessage());
}catch (SQLException e) {
out.println("Error accediendo a la base de datos"
+ e.getMessage());
}
finally {
//6
if (rs != null) {
try {rs.close();} catch (SQLException e)
{out.println("Error cerrando el resultset" + e.getMessage());}
}
if (sentencia != null) {
try {sentencia.close();} catch (SQLException e)
{out.println("Error cerrando la sentencia" + e.getMessage());}
}
if (conexion != null) {
try {conexion.close();} catch (SQLException e)
{out.println("Error cerrando la conexion" + e.getMessage());}
}
}
%>
            </thead>
            <tbody id="userTableBody">
            </tbody>
        </table>
        <a href="Registrar.html" ></a>
        <button class ="edit-btn">Registrar Nuevo Usuario</button>
        <br>
        <center><a href="adminmenu.html" style="color: red">Regresar</a></center>
    </div>
</body></html>
