#!/bin/bash

echo -n "#Architecture : "; uname -a
#echo:write -n:no new line | uname:system informations -a:all
echo -n "#CPU physical : "; nproc --all
#nproc:nombre de processeurs physiques (lscpu)
echo -n "#vCpu : "; cat /proc/cpuinfo | grep processor | wc -l
#/proc/cpuinfo:info cpu |grep : search | wc : count -l : lines
echo -n "#Memory Usage: "; free -m | awk 'NR==2{printf "%s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2}'
#free:display amount of free and used memory in the systen -m:mebibytes | awk: scripting language for text processing NR : line 2
echo -n "#Disk Usage: "; df --total -h | awk '$1 == "total" {printf("%d/%dGb (%.2f%%)\n", $3, $2, $3 / $2)}'
#df:report file system disk space usage -h:human readble: size in power of 1024 | $1 == total : line total
echo -n "#CPU Load: "; top -bn1 | grep '%Cpu(s)' | awk '{printf("%.2f%%\n", $2 + $4)}'
#top :afficher les taches execut2e par cpu real time -b : traitement par lot battch mode -n : nombre d'iteration (actualiser) | us : user cpu time, ni :user nice cpu time low priority
echo -n "#Last boot: "; who -b | awk '{print $3 " " $4}'
#who : show who is logged on -b : boot
echo -n "#LVM use: "; lsblk | grep lvm | awk '{if ($1) {print "yes"; exit;} else {print "no"} }'
echo -n "#Connection TCP: ";cat /proc/net/sockstat | awk '$1 == "TCP:" {print $3}' | tr '\n' ' ' &&  echo "ESTABLISHED"
#/proc/net/sockstat : connection info | TCP : Transmission Control Protocol | muse : the number of TCP sockets in use (listening)
echo -n "#User log: "; users | wc -w
#users: user logged in | wc - w :count words
echo -n "#Network: "; echo -n "IP " && hostname -I | tr '\n' '(' && ip link | awk '$1 == "link/ether" {print $2}' | tr '\n' ')' && printf "\n"
#hostname -I : IP | ip link : network device configuration | tr : translate or delete
echo -n "#SUDO: "; grep "COMMAND" /var/log/sudo/sudo.log | wc -l | tr '\n' ' ' && echo "cmd"
