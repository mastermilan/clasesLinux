#!bin/bash  -
# Inicio de Script 
# Crontab cada 5 minutos, user root
# Autor: LRV

timestamp() {
  date +"%T"
}

LOG_PATH=/var/log/ping
INI_DATE=`date +%d-%m-%Y`
ID=`date +%d%m`
LOG_FILE=$LOG_PATH/salida${ID}.log


echo "$(timestamp) Comienza revisión de página"   | tee --append  $LOG_FILE
 ping -q -c5 www.lun.com > /dev/null
 if [ $? -eq 0 ]
 then
			echo "$(timestamp) Página Activa"   | tee --append  $LOG_FILE
			   else
		   echo "$(timestamp) Página Caida"     | tee --append  $LOG_FILE
fi	

echo "$(timestamp) Fin revisión de sitio"   | tee --append  $LOG_FILE
