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
    <title>Solicitar Cita con Médico General</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #0270ca;
        }
        .container {
            max-width: 600px;
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
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }
        input[type="date"],
        input[type="time"],
        select {
            width: 100%;
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
    <div class="container">
        <h1>Solicitar Cita con Médico General</h1>
        <form action="CitaG.jsp" method="POST">
            <label for="fecha">Selecciona la fecha:</label>
            <input type="date" id="fecha" name="fecha" required>
            
            <label for="hora">Selecciona el horario:</label>
            <input type="time" id="hora" name="hora" required>
            
            <label for="medico">Selecciona el médico general:</label>
            <select id="Ced_Medico" name="Ced_Medico" required>
                <%
                // Conexión a la base de datos para obtener los médicos generales
                Connection conexion = null;
                Statement sentencia = null;
                ResultSet rs = null;

                try {
                    Class.forName("org.postgresql.Driver");
                    conexion = DriverManager.getConnection("jdbc:postgresql://localhost:5433/Hospital", "postgres", "password");
                    sentencia = conexion.createStatement();

                    // Consulta SQL para obtener los médicos generales
                    String consultaSQL = "SELECT Ced_Medico, Nom_Medico FROM Medico WHERE Categoria = 'Medico General'";
                    rs = sentencia.executeQuery(consultaSQL);

                    // Llenar el select con los médicos
                    while (rs.next()) {
                        String Ced_Medico = rs.getString("Ced_Medico");
                        String Nom_Medico = rs.getString("Nom_Medico");
                        // Generar la opción con el ID y nombre del médico
                        out.println("<option value='" + Ced_Medico + "'>" + Nom_Medico + "</option>");
                    }

                } catch (Exception e) {
                    out.println("Error al cargar los médicos: " + e.getMessage());
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (sentencia != null) try { sentencia.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conexion != null) try { conexion.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
            </select>
            
            <label for="descripcion">Descripción de la cita:</label>
            <textarea id="descripcion" name="descripcion" rows="4" placeholder="Escribe una descripción de la cita (opcional)"></textarea>
            
            <button type="submit">Solicitar Cita</button>
        </form>
        <br>
        <center><a href="../Paciente/usermenu.html">Cancelar</a></center>
    </div>

</body>
</html>
