#!/bin/bash
# Version 0.2
# Description: easy menu to start/stop/watch rtorrent
# by allanon
# GPLv3

st=0
R_START='/usr/bin/screen -R rtorrent -D /usr/bin/rtorrent'
R_WATCH='/usr/bin/screen -R rtorrent'

## DEFINIZIONE FUNZIONI MENU
function menu_servizi {
	clear
	echo ":: $1 ::"
	echo
	status
	echo
	echo "azioni possibili sul servizio Rtorrent"
	echo
	echo
	echo " g) Guarda"
	echo " r) Riavvia"
	echo " a) Avvia"
	echo " f) Ferma"
	echo " k) Killa"
	echo " q) esci"
	echo 
	raccogli_scelta
	case "$SCELTA" in
		"r")
			if [ $st ]; then 
				kill -2 $PIDOF
				$2			
				continua
			else
				echo "Rtorrent fermo - Avvio il servizio"
				$R_START
				$2
				[ $st ] && echo 'Rtorrent avviato correttamente' || echo 'Impossibile avviare Rtorrent' 
				continua
			fi
		;;
		"a")
			if [ $st ]; then 
				echo "Servizio già attivo"
				continua
			else
				$R_START
				$2 
				[ $st ] && echo 'Rtorrent avviato correttamente' || echo 'Impossibile avviare Rtorrent' 

				continua
			fi
		;;
		"f")
			if [ $st ]; then 
				kill -2 $PIDOF		
				screen -r	
			else
				echo "Rtorrent spento"
				continua
			fi
		;;
		"k")
			if [ $st ]; then 
				kill -9 $PIDOF			
				screen -r	
			else
				echo "Rtorrent spento"
				continua
			fi
		;;
		"g")
			if [ $st ]; then 
				$R_WATCH
			else
				echo "Rtorrent non attivo"
				continua
			fi
		;;
		"q")
			exit
		;;
	esac
}


function continua {
	echo;read -s -n1 -p "Premi un tasto per continuare.."
}

function status {
	if [ `pidof rtorrent` ]; then 
		st=1
		PIDOF=`pidof rtorrent`
		echo "++ rtorrent attivo ++"
	else
		st=0
		echo "--> rtorrent non attivo <--"
	fi
}

function raccogli_scelta {
	echo
	read -s -n1 -p "Scegli..." SCELTA
	echo
}
#######
while true
do
menu_servizi "MENU SERVIZIO RTORRENT" "$RTORRENT"
done
