#!/bin/bash
timestamp() {
  date '+%Y-%m-%d %H:%M:%S'
}
annio=`date +"%Y"`
mes=`date +"%b"`

RUTA_BKP=/u03/Backup/Dominios

# Eliminacion de Archivos Antiguos
echo  "$(timestamp) - Se buscan archivos de más de 20 días para eliminar"
sudo find "/u03/Backup/Dominios/" -mtime +5 -type f -exec rm {} \;
echo "========================================="
echo "=========RESPALDO DOMINIO DEV============"
echo "========================================="
# Respaldo Dominio OSB
if [ -d "$RUTA_BKP/$annio"/"$mes/" ]; then
  echo "$(timestamp) - La carpeta Backup existe, no se vuelve a crear"
else
  mkdir -p "$RUTA_BKP/$annio"/"$mes/"
  echo  "$(timestamp) - Se crea carpeta para backup semanal"
fi
 echo "========================================="
 echo  "$(timestamp) - Se inicia proceso de Respaldo AdminServer Dominio OSB"
 OSBDIR=osb122dev
 OSBFILE=AdminOSB-`date +%d%b%Y`
 CARPETA="$RUTA_BKP/$annio"/"$mes/"
 cd /u02/app
 sudo tar -cvzf $OSBFILE.tar.gz $OSBDIR/ > /dev/null 2>&1
 sudo chown osb122dev.oinstall $OSBFILE.tar.gz
   if [ -f $OSBFILE.tar.gz ]; then
		echo "$(timestamp) - ${OSBFILE}.tar.gz fue creado correctamente"
    else
		echo "$(timestamp) - No fue creado correctamente"
   fi
 sudo mv $OSBFILE.tar.gz $CARPETA
 echo "$(timestamp) - ${OSBFILE}.tar.gz * Copiado en carpeta Backup"
 sleep 5
 
# Respaldo Dominio OHS
echo "========================================="
 echo  "$(timestamp) - Se inicia proceso de Respaldo AdminServer Dominio OHS"
 OHSDIR=ohs122dev
 OHSFILE=AdminOHS-`date +%d%b%Y`
 cd /u02/app
 sudo tar -cvzf $OHSFILE.tar.gz $OHSDIR/ > /dev/null 2>&1
 sudo chown ohs122dev.oinstall $OHSFILE.tar.gz
   if [ -f $OHSFILE.tar.gz ]; then
		echo "$(timestamp) - ${OHSFILE}.tar.gz fue creado correctamente"
    else
		echo "$(timestamp) - No fue creado correctamente"
   fi
 sudo mv $OHSFILE.tar.gz $CARPETA
 echo "$(timestamp) - ${OHSFILE}.tar.gz * Copiado en carpeta Backup"
 sleep 5

# Respaldo Dominio BPM
echo "========================================="
 echo  "$(timestamp) - Se inicia proceso de Respaldo AdminServer Dominio BPM"
 BPMDIR=bpm122dev
 BPMFILE=AdminBPM-`date +%d%b%Y`
 cd /u02/app
 sudo tar -cvzf $BPMFILE.tar.gz $BPMDIR/ > /dev/null 2>&1
 sudo chown bpm122dev.oinstall $BPMFILE.tar.gz
   if [ -f $BPMFILE.tar.gz ]; then
		echo "$(timestamp) - ${BPMFILE}.tar.gz fue creado correctamente"
    else
		echo "$(timestamp) - No fue creado correctamente"
   fi
 sudo mv $BPMFILE.tar.gz $CARPETA
 echo "$(timestamp) - ${BPMFILE}.tar.gz * Copiado en carpeta Backup"
 sleep 5

# Respaldo Dominio SOA
echo "========================================="
 echo  "$(timestamp) - Se inicia proceso de Respaldo AdminServer Dominio SOA"
 SOADIR=soa122dev
 SOAFILE=AdminSOA-`date +%d%b%Y`
 cd /u02/app
 sudo tar -cvzf $SOAFILE.tar.gz $SOADIR/ > /dev/null 2>&1
   if [ -f $SOAFILE.tar.gz ]; then
        sudo chown soa122dev:oinstall $SOAFILE.tar.gz
		echo "$(timestamp) - ${SOAFILE}.tar.gz fue creado correctamente"
    else
		echo "$(timestamp) - No fue creado correctamente"
   fi
 sudo mv $SOAFILE.tar.gz $CARPETA
 echo "$(timestamp) - ${SOAFILE}.tar.gz * Copiado en carpeta Backup"
 sleep 5 

# Respaldo Dominio ODI
echo "========================================="
 echo  "$(timestamp) - Se inicia proceso de Respaldo AdminServer Dominio ODI"
 ODIDIR=odi122dev
 ODIFILE=AdminODI-`date +%d%b%Y`
 cd /u02/app
 sudo tar -cvzf $ODIFILE.tar.gz $ODIDIR/ > /dev/null 2>&1
 sudo chown odi122dev.oinstall $ODIFILE.tar.gz
   if [ -f $ODIFILE.tar.gz ]; then
		echo "$(timestamp) - ${ODIFILE}.tar.gz fue creado correctamente"
    else
		echo "$(timestamp) - No fue creado correctamente"
   fi
 sudo mv $ODIFILE.tar.gz $CARPETA
 echo "$(timestamp) - ${ODIFILE}.tar.gz * Copiado en carpeta Backup"
 sleep 5  
 
# Respaldo Dominio WLP - Producer
echo "========================================="
 echo  "$(timestamp) - Se inicia proceso de Respaldo AdminServer Dominio WLP"
 WLPDIR=wlp122dev
 WLPFILE=AdminWLP-`date +%d%b%Y`
 cd /u02/app
 sudo tar -cvzf $WLPFILE.tar.gz $WLPDIR/ > /dev/null 2>&1
 sudo chown wlp122dev.oinstall $WLPFILE.tar.gz
   if [ -f $WLPFILE.tar.gz ]; then
		echo "$(timestamp) - ${WLPFILE}.tar.gz fue creado correctamente"
    else
		echo "$(timestamp) - No fue creado correctamente"
   fi
 sudo mv $WLPFILE.tar.gz $CARPETA
 echo "$(timestamp) - ${WLPFILE}.tar.gz * Copiado en carpeta Backup"
 sleep 5

# Respaldo Dominio WLC - Consumer
echo "========================================="
 echo  "$(timestamp) - Se inicia proceso de Respaldo AdminServer Dominio WLC"
 WLCDIR=wlc122dev
 WLCFILE=AdminWLC-`date +%d%b%Y`
 cd /u02/app
 sudo tar -cvzf $WLCFILE.tar.gz $WLCDIR/ > /dev/null 2>&1
 sudo chown wlc122dev.oinstall $WLCFILE.tar.gz
   if [ -f $WLCFILE.tar.gz ]; then
		echo "$(timestamp) - ${WLCFILE}.tar.gz fue creado correctamente"
    else
		echo "$(timestamp) - No fue creado correctamente"
   fi
 sudo mv $WLCFILE.tar.gz $CARPETA
 echo "$(timestamp) - ${WLCFILE}.tar.gz * Copiado en carpeta Backup"
 sleep 5  
