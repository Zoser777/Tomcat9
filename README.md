

# Tomcat9

Script que automatiza la descarga e instalación de Tomcat y puesta a punto de un usuario y contraseña para Tomcat Manager. 

Para acelerar su ejecución es recomendable primero hacer un update (apt update) y descargar el JFDK de Java por nuestra cuenta. En caso cotrario, esto lo realiza el script.

# Uso del Script

Para poder usar el Script, debes situarte en /home/%user% y desde ahí ejecutar _git clone https://github.com/Zoser777/tomcat_ , esto clonara este repositorio y tendrás todos los archivos que aquí se encuentran. 

Una vez descargado, debes entrar en el directorio tomcat y darle permisos de ejecución al archivo _tomcatfull.sh_ y ejecutarlo con privilegios de administrador. 
(sudo ./tomcatfull.sh o sudo bash tomcatfull.sh)


# Que hace el script?

El script realizará los siguientes pasos:

  · Actualizar los repositorios.
  · Instalar el JDK de JAVA.
  · Configurar el usuario y grupo de Tomcat.
  · Instalar tomcat desde su pagina principal _https://dlcdn.apache.org/tomcat_
  · Instalar ufw para controlar el firewall del sistema.
  · Crear un usuario y contraseña para Manager.


# Conclusión

Una vez finalizado el script, se puede eliminar el directorio de Tomcat creado con el gitclone. 

Espero que sea de utilidad. 
