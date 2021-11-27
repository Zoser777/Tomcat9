#!/bin/bash
#####
#Made by z0s3r
#####
#Este programa sirve para instalar y configurar Tomcat9 en Ubuntu y UbuntuServer.

#Comprueba que eres root
if [ $(whoami) != "root" ]; then


        echo " --------------------------------- ";
        echo "Tienes que ser root para ejecutar este script";
        echo "Ejecuta "sudo -i" y vuelve a ejecutar el archivo";
        echo "Cuidado con lo que ejecutas";
        echo " -------------------------------- ";
        exit 1

else

        echo " --------------------------------- ";
        echo " Iniciando programa ";
        echo " --------------------------------- ";


fi


read -p " Nombre de usuario en el sistema : " user;




echo " "
echo " --------------------------------- ";
echo " Actualizando sistema ";
echo " --------------------------------- ";
echo " "


sudo apt update &>/dev/null



#instalando java

sleep 3;

echo " "
echo " --------------------------------- ";
echo " Instalando JDK de JAVA ";
echo " --------------------------------- ";
echo " "


sudo apt install default-jdk -y


#Paso 2
#creando grupo tomcat

sleep 3;

echo " "
echo " --------------------------------- ";
echo " Configurando usuarios de TOMCAT ";
echo " --------------------------------- ";
echo " ";


sudo groupadd tomcat &>/dev/null
sudo useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat &>/dev/null



#paso 3

cd /tmp

sleep 3;


echo " ";
echo " --------------------------------- ";
echo " Descargando Tomcat9 ";
echo " --------------------------------- ";
echo " ";


sudo apt install curl -y

curl -O https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.55/bin/apache-tomcat-9.0.55.tar.gz

sudo mkdir /opt/tomcat &>/dev/null

sleep 3;


echo " ";
echo " --------------------------------- ";
echo " Descomprimiendo Tomcat9";
echo " --------------------------------- ";
echo " ";


sudo tar xzvf apache-tomcat-*tar.gz -C /opt/tomcat --strip-components=1 &>/dev/null

sleep 3;




echo " ";
echo " --------------------------------- ";
echo " Concediendo permisos necesarios";
echo " --------------------------------- ";
echo " ";

sleep 3;

cd /opt/tomcat

sudo chgrp -R tomcat /opt/tomcat
sudo chmod -R g+r conf
sudo chmod g+x conf
sudo chown -R tomcat webapps/ work/ temp/ logs/




echo " ";
echo " --------------------------------- ";
echo " Comprobando si Tomcat está operativo";
echo " --------------------------------- ";
echo " ";


#Se copia el archivo tomcat.service en /etc/systems/system

cd /home/$user/tomcat/
sudo cp -f tomcat.service /etc/systemd/system/

sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo systemctl status tomcat &>/dev/null

sleep 3;


echo " ";
echo " --------------------------------- ";
echo " Tomcat está funcionando ";
echo " --------------------------------- ";
echo " ";




echo " ";
echo " --------------------------------- ";
echo " Configurando entorno de red";
echo " --------------------------------- ";
echo " ";

echo " ";
echo " --------------------------------- ";
echo " Instalando ufw ";
echo " --------------------------------- ";
echo " ";


sudo apt install ufw -y


sleep 2;


echo " ";
echo " --------------------------------- ";
read -p " Tienes puesto el adaptador solo-anfrition?(si o no): " adap;
echo " --------------------------------- ";
echo " ";


#Cogemos la IP del sistema

if [ "$adap" == "si" ]
then

xx=$(hostname -I | cut -d " " -f2);

else

xx=$(hostname -I | cut -d " " -f1);

fi



tt=$(echo $xx | cut -d "." -f1)

sudo ufw allow 8080 &>/dev/null;


sleep 3;

echo " ";
echo " --------------------------------- ";
echo " Puedes acceder a http://$xx:8080"
echo " para comprobar que todo funciona";
echo " --------------------------------- ";
echo " ";




sleep 3;





echo " ";
echo " --------------------------------- ";
echo " Configurando usuario y contraseña para directorio manager en tomcat ";
echo " --------------------------------- ";
echo " ";

sudo systemctl enable tomcat

echo " ";
echo " --------------------------------- ";
read -p "Ingrese un usuario para el directorio manager: " y
read -p "Ingrese una contraseña: " yy
echo " --------------------------------- ";
echo " ";


#Insertando usuario y contraseña en el archivo /por/tomcat/conf

nn="<user username=\"$y\" password=\"$yy\" roles=\"manager-gui,admin-gui\"/>";

nt=$(echo $nn);


sed -i "58s|.*| $nt |" tomcat-users.xml
cp -f tomcat-users.xml /opt/tomcat/conf/




#Permitiendo acceso a tomcat desde la IP seleccionada


case $tt in

	"10")
		rm context2.xml
		sudo cp -f context.xml /opt/tomcat/webapps/manager/META-INF/
		sudo cp -f context.xml /opt/tomcat/webapps/host-manager/META-INF/
		;;

	"192")

		mv context3.xml context.xml
                sudo cp -f context.xml /opt/tomcat/webapps/manager/META-INF/
                sudo cp -f context.xml /opt/tomcat/webapps/host-manager/META-INF/
		;;


	"198")
		mv context2.xml context.xml
		sudo cp -f context.xml /opt/tomcat/webapps/manager/META-INF/
		sudo cp -f context.xml /opt/tomcat/webapps/host-manager/META-INF/
		;;


	*)


		echo " ";
		echo " --------------------------------";
		echo "Tu IP no está registrada en nuestros archivos context";
		echo "Tienes que convigurar tu mismo el archivo context y cambiar el valor de la ip";
		echo "Después has de mover el archivo a /manager/META-INF y a /host-manager/META-INF";
		echo "Por último has un service tomcat restart";
		echo " --------------------------------";
		echo " ";
		echo "Saliendo del programa";
		exit 1;
		;;


esac

sleep 3;


service tomcat restart


echo " ";
echo " --------------------------------- ";
echo " Tomcat9 instalado con éxito ";
echo " --------------------------------- ";
echo " ";

exit 1;
