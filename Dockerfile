# Usa una imagen base de Tomcat
FROM tomcat:9.0-jdk17

# Copia el archivo .war a la carpeta webapps de Tomcat
COPY Parcial.war /usr/local/tomcat/webapps

# Expone el puerto 8080 (puerto predeterminado de Tomcat)
EXPOSE 8080

# Comando para iniciar Tomcat
CMD ["catalina.sh", "run"]
