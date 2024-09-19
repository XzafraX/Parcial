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
    <title>Información de Médicos</title>
    <style>
        /* Estilos básicos */
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #38ff52; /* Fondo verde */
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
            width: 80%; /* Ajusta el ancho del contenedor */
            max-width: 800px; /* Ancho máximo */
            overflow-x: auto; /* Habilita el scroll horizontal si es necesario */
            position: relative; /* Necesario para posicionar el botón de regreso */
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 0 auto; /* Centra la tabla */
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #38ff52; /* Color de fondo para el encabezado */
            color: #fff;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9; /* Color de fondo para filas pares */
        }
        .actions {
            text-align: center;
        }
        .actions button {
            background-color: #38ff52;
            color: #fff;
            border: none;
            padding: 5px 10px;
            margin: 0 5px;
            font-size: 14px;
            cursor: pointer;
            border-radius: 4px;
        }
        .actions button:hover {
            background-color: #38ff52;
        }
        .back-button {
            background-color: #38ff52;
            color: #fff;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 4px;
            display: block;
            margin: 20px auto 0;
        }
        .back-button:hover {
            background-color: #2bdd43;
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
String consultaSQL= "select Ced_Medico, Nom_Medico, Email_Medico, Tel_Medico,Categoria from Medico";
//3 y 4
//rs REPETIR consulta
rs=sentencia.executeQuery(consultaSQL);
//5
%>
    <!-- Contenedor para la tabla -->
    <div class="container">
        <h1>Lista de Médicos</h1>
        <!-- Tabla de información -->
        <table>
            <thead>
                <tr>
                    <th>Nombre</th>
                    <th>Cédula</th>
                    <th>Número de Teléfono</th>
                    <th>Área</th>
                    <th>Email</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <!-- Ejemplo de datos estáticos -->
                <tr>
                    <td>Juan Pérez</td>
                    <td>123456789</td>
                    <td>555-1234</td>
                    <td>Médico general</td>
                    <td>perez@outlook.edu.co</td>
                    <td class="actions">
                        <button href="medicadd.html" onclick="alert('Editar Juan Pérez')">Editar</button> <br>
                        <button onclick="alert('Eliminar Juan Pérez')">Eliminar</button>
                    </td>
                </tr>
                <tr>
                    <td>María López</td>
                    <td>987654321</td>
                    <td>555-5678</td>
                    <td>Laboratorio</td>
                    <td>Maria99@gmail.com</td>
                    <td class="actions">
                        <button href="medicadd.html" onclick="alert('Editar María López')">Editar</button> <br>
                        <button onclick="alert('Eliminar María López')">Eliminar</button>
                    </td>
                </tr>
                <!-- Agrega más filas según sea necesario -->
                <% while(rs.next()) {%>
                    <tr>
    <td> <%=rs.getString("Nom_Medico")%></td> 
    <td> <%=rs.getString("Ced_Medico")%></td> 
    <td> <%=rs.getString("Tel_Medico")%></td> 
    <td> <%=rs.getString("Categoria")%></td> 
    <td> <%=rs.getString("Email_Medico")%></td>
    <td class="actions">
    <a href="Eliminar_Medico.jsp?Ced_Medico=<%= rs.getString("Ced_Medico") %>">
        <button>Eliminar</button>
         <a href="medicoEdit.jsp?Ced_Medico=<%= rs.getString("Ced_Medico") %>">
        <button>Editar</button>
    </a>
    </td>
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
            </tbody>
        </table>
        <!-- Botón para regresar al menú principal -->
        <button class="back-button" onclick="window.location.href='../Admin/adminmenu.html'">Regresar al Menú Principal</button>
    </div>
</body>
</html>
