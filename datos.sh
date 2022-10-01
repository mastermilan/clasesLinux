#!/bin/bash
####################################
#Created By Arindam Mitra###########
#Modificado por LRV#################
####################################
 
#HOSTNAME :-
HOSTN=`/bin/hostname`
#OPERATING SYSTEM :-
OS=`cat /etc/redhat-release`
#ARCHITECTURE :-
ARCH=`/bin/uname -p`
#HYPERVISOR TYPE
HTYPE=`dmidecode | grep -m 1 "Product Name" | cut -d ":" -f 2`
if [ "$HTYPE"  = " VMware Virtual Platform" ]
        then HTYPE="VMware Hypervisor"
else
        HTYPE="OTHERS"
fi
 
#HYPERVISOR MANUFACTURER :-
MANUFAC=`/usr/sbin/dmidecode --type system | grep Manufacturer | cut -d ":" -f2`
 
#PRODUCT NAME :-
PRODUCTNAME=`/usr/sbin/dmidecode | grep "Product Name: V" | cut -d ":" -f2 | awk '$1=$1'`
 
#CPU Info/Type
CPUI=`cat /proc/cpuinfo | grep "model name" | cut -d ":" -f2`
 
#CPU Usage
CPU=`top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}'`
 
#CPU Details
CPUOM=`/usr/bin/lscpu | grep "CPU op" | cut -d ":" -f2 | awk '$1=$1'`
CPUC=`lscpu | grep -E '^Thread|^Core|^Socket|^CPU\(' | grep CPU | cut -d ":" -f2 | awk '$1=$1'`
CPUS=`lscpu | grep -E '^Thread|^Core|^Socket|^CPU\(' | grep Socket | cut -d ":" -f2 | awk '$1=$1'`
CPUMHZ=`/usr/bin/lscpu | grep -i "CPU MHz" | cut -d ":" -f2 | awk '$1=$1'`
 
#MEMORY DETAILS
MEMUSAGE=`top -n 1 -b | grep "Mem"`
MAXMEM=`grep MemTotal /proc/meminfo | awk '{print $2}'`
USEDMEM=`free | grep Mem | awk '{print $3/$2 * 100.0}'`
USEDMEM1=`expr $USEDMEM \* 100`

 
#SWAP DETAILS
SWAPFS=`swapon -s | grep -vE '^Filename' | awk '{ printf $1}'`
SWAPS=`swapon -s | grep -vE '^Filename' | awk '{ printf $3}'`
SWAPU=`swapon -s | grep -vE '^Filename' | awk '{ printf $4}'`
SWAPP=`swapon -s | grep -vE '^Filename' | awk '{ printf $5}'`
 
#DISK 
DISK=`df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ printf $5 " " $1" | "}'`
 
#NETWORK DETAILS
#IP=`ifconfig eth0 | grep "inet addr" | cut -d ":" -f2 | awk '{printf $1}'`
IP=`ifconfig eth0 | grep "inet" | awk '{printf $2}'`
SM=`/sbin/ifconfig eth0 | awk '/netmask/{print $4}'`
MAC=`cat /etc/sysconfig/network-scripts/ifcfg-eth0 | grep -i UUID | cut -d "=" -f2`

#UPTIME
UPTIME=`uptime`
 
#OUTPUT :-
echo -ne "\n"
echo "###################SERVER-DETAILS######################"
echo "1.  HOSTNAME = $HOSTN "
echo "2.  OPERATING SYSTEM = $OS"
echo "3.  ARCHITECTURE = $ARCH"
echo "4.  HYPERVISOR = $HTYPE"
echo "5.  MANUFACTURER = $MANUFAC"
echo "6.  PRODUCT NAME = $PRODUCTNAME"
echo "7.  CPU TYPE = $CPUI"
echo "8.  CPU USAGE = $CPU"
echo "9.  CPU OP-MODE(s) = $CPUOM"
echo "10. NO. OF CPU = $CPUC"
echo "11. NO. OF CPU SOCKETS = $CPUS"
echo "12. CPU SPEED IN MHz = $CPUMHZ"
echo "13. MAXIMUM MEMORY = $MAXMEM"
echo "14. USED MEMORY = $USEDMEM"
echo "15. SWAP DETAILS :-"
echo "       a. File System = $SWAPFS"
echo "       b. Size = $SWAPS"
echo "       c. Used = $SWAPU"
echo "       d. Priority = $SWAPP"
echo "16. DISK DETAILS [% Usage, FileSystem] = $DISK"
echo "17. IP ADDRESS = $IP"
echo "18. SUBNET MASK = $SM"
echo "19. UUID = $MAC"
echo "20. UPTIME = $UPTIME"
echo "###################SERVER-DETAILS######################"
echo -ne "\n"
