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
Connection conexion=null;
Statement sentencia=null;
ResultSet rs=null;
try {
Class.forName("org.postgresql.Driver");

conexion = DriverManager.getConnection(

    "jdbc:postgresql://localhost:5433/Hospital", "postgres","password");

sentencia = conexion.createStatement();
//2
String consultaSQL= "select Nombre,Email,Pswd,CPswd,Genero,Fecha,Direccion from usuarios";
//3 y 4
//rs REPETIR consulta
rs=sentencia.executeQuery(consultaSQL);
//5
while(rs.next()) { %>

<tr>
<td> <%=rs.getString("Nombre")%></td> 
<td> <%=rs.getString("Email")%></td> 
<td> <%=rs.getString("Pswd")%></td> 
<td> <%=rs.getString("CPswd")%></td> 
<td> <%=rs.getString("Genero")%></td> 
<td> <%=rs.getString("Fecha")%></td> 
<td> <%=rs.getString("Direccion")%></td> 
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
<a href="index.jsp">Volver</a>
</body></html>