<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modificar Cita con Laboratorio</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #0270ca; /* Color de fondo */
        }
        .container {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        button.edit-btn {
    background-color: #28a745;
}
button.delete-btn {
    background-color: #dc3545;}
        h1 {
            text-align: center;
            color: #0270ca;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }
        input[type="date"],
        input[type="time"],
        select {
            width: 97%;
            padding: 8px;
            margin-bottom: 16px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        button {
            display: block;
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<%
    
    int ID_Lab = Integer.parseInt(request.getParameter("ID_Lab"));

    Connection conexion = null;
    Statement sentencia = null;
    ResultSet rs = null;
    try {
        Class.forName("org.postgresql.Driver");
        conexion = DriverManager.getConnection(
            "jdbc:postgresql://localhost:5433/Hospital", "postgres", "password");
        sentencia = conexion.createStatement();
        
        // Consulta SQL
        String consultaSQL = "SELECT Citas_Lab.ID_Lab, Citas_Lab.Descripcion_Lab, Citas_Lab.Fecha_CLab, Citas_Lab.Hora,Citas_Lab.Ced_Medico, Medico.Nom_Medico " +
                             "FROM Citas_Lab " +
                             "JOIN Medico ON Citas_Lab.Ced_Medico = Medico.Ced_Medico WHERE ID_Lab=" + ID_Lab;
        rs = sentencia.executeQuery(consultaSQL);
        if (rs.next()) {
            String fechaActual = rs.getString("Fecha_CLab");
            String horaActual = rs.getString("Hora");
            String medicoActual = rs.getString("Nom_Medico");
            String medico = rs.getString("Ced_Medico");
            String descripcion = rs.getString("Descripcion_Lab");
            

%>
    <div class="container">
        <h1>Modificar Cita con Laboratorio</h1>
        <form action="ActuCL.jsp" method="POST">
                      <input type="hidden" name="ID_Lab" value="<%= ID_Lab %>"> 
            
            <label for="fecha">Modificar la fecha:</label>
            <input type="date" id="fecha" name="fecha" value="<%= fechaActual %>" required>
            
            <label for="hora">Modificar el horario:</label>
            <input type="time" id="hora" name="hora" value="<%= horaActual %>" required>
            
            <label for="medico">Modificar el Médico de laboratorio:</label>
            <select id="medico" name="medico" required>
                <option value="<%= medico %>"><%= medicoActual %></option>
                <!-- Aquí puedes añadir más opciones de médicos -->
            </select>
            <label for="descripcion">Descripción de la cita:</label>
            <textarea id="descripcion" name="descripcion" rows="4"><%= descripcion %></textarea>
            
            <button type="submit" onclick="alert('Cita modificada con éxito.')">Modificar Cita</button>
        </form>
        <br>
        <center><a href="../CitasLab/verCitaLaboratorio.jsp">Cancelar Modificacion</a></center>
    </div>
    <%
        } else {
            out.println("No se encontraron datos para la cita.");
        }
    } catch (ClassNotFoundException e) {
        out.println("Error en la carga del driver: " + e.getMessage());
    } catch (SQLException e) {
        out.println("Error accediendo a la base de datos: " + e.getMessage());
    } finally {
        // Cerrar recursos
        if (rs != null) try { rs.close(); } catch (SQLException e) { }
        if (sentencia != null) try { sentencia.close(); } catch (SQLException e) { }
        if (conexion != null) try { conexion.close(); } catch (SQLException e) { }
    }
%>
</body>
</html>
