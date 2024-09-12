<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Usuarios</title>
</head>
<body>
<%
String CedPaciente = request.getParameter("Ced_Paciente");
Connection conexion=null;
Statement sentencia=null;
ResultSet rs=null;
try {
Class.forName("org.postgresql.Driver");

conexion = DriverManager.getConnection(

    "jdbc:postgresql://localhost:5433/Hospital", "postgres","password");

sentencia = conexion.createStatement();
//2
String consultaSQL= "select Ced_Paciente, Nom_Paciente, Email_Paciente, Tel_Paciente, Ciudad, Dir_Paciente, Estado_C from Paciente  WHERE Ced_Paciente = '" + CedPaciente + "'";
//3 y 4
//rs REPETIR consulta
rs=sentencia.executeQuery(consultaSQL);
//5
while(rs.next()) { %>
<div class="container">
<h1>"Registro exitoso"</h1>
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
</div>
 <a href="Registrar.html">Registrar Nuevo Usuario</a>
 <br>
 <center><a href="adminmenu.html">Regresar</a></center>
</body></html>