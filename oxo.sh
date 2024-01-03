#!/bin/bash

############################################################################################################
############################################################################################################
#Funcion presentacion de pantalla derrota/victoria
############################################################################################################
############################################################################################################
function fEstadisticas
{
	numjuegos=0
	tiempo=0
	turnos=0
	i=0
	lineas=$(wc -l < $fichero)
	line="$(head -n $(($i+1)) < $fichero | tail -1 )"
	if test "$line" != ""
	then
		
		tempcorto=$(echo $line | cut -f 6 -d "|")
		templargo=$(echo $line | cut -f 6 -d "|")
		turncorto=$(echo $line | cut -f 7 -d "|")
		turnlargo=$(echo $line | cut -f 7 -d "|")
		numlineaTempC=1
		numlineaTempL=1
		numlineaTurnC=1
		numlineaTurnL=1
		while test $i -lt $lineas
		do
			line="$(head -n $(($i+1)) < $fichero | tail -1 )"
			if test $(echo $line | cut -f 6 -d "|") -lt $tempcorto >/dev/null
			then
				tempcorto=$(echo $line | cut -f 6 -d "|")
				numlineaTempC=$(($i+1))
			fi
			if test $(echo $line | cut -f 6 -d "|") -gt $templargo >/dev/null
			then
				templargo=$(echo $line | cut -f 6 -d "|")
				numlineaTempL=$(($i+1))
			fi
			if test $(echo $line | cut -f 7 -d "|") -lt $turncorto >/dev/null
			then
				turncorto=$(echo $line | cut -f 7 -d "|")
				numlineaTurnC=$(($i+1))
			fi
			if test $(echo $line | cut -f 7 -d "|") -gt $turnlargo >/dev/null
			then
				turnlargo=$(echo $line | cut -f 7 -d "|")
				numlineaTurnL=$(($i+1))
			fi
			tiempo=$(($tiempo + $(echo $line | cut -f 6 -d "|")))
			turnos=$(($turnos + $(echo $line | cut -f 7 -d "|")))
			echo 
			i=$(($i+1))
		done
		numjuegos=$lineas

		tiempoT=$tiempo
		if test $numjuegos -eq 0
		then
			tiempo=0 
		else	
			tiempo=$(($tiempo/$numjuegos))
			turnos=$(($turnos/$numjuegos))
		fi

		if test ${#numjuegos} -le 9
		then
			numVacio=$((10-${#numjuegos}))
			while test $numVacio -gt 0
			do
				numjuegos=$(echo "$numjuegos ")
				numVacio=$(($numVacio-1))
			done
		fi

		if test ${#tiempoT} -le 8
		then
			numVacio=$((8-${#tiempoT}))
			while test $numVacio -gt 0
			do
				tiempoT=$(echo "$tiempoT ")
				numVacio=$(($numVacio-1))
			done
		fi

		if test ${#tiempo} -le 7
		then
			numVacio=$((7-${#tiempo}))
			while test $numVacio -gt 0
			do
				tiempo=$(echo "$tiempo ")
				numVacio=$(($numVacio-1))
			done
		fi
		if test ${#turnos} -le 7
		then
			numVacio=$((7-${#turnos}))
			while test $numVacio -gt 0
			do
				turnos=$(echo "$turnos ")
				numVacio=$(($numVacio-1))
			done
		fi

		tempcorto="$(head -n $numlineaTempC < $fichero | tail -1 )"
		templargo="$(head -n $numlineaTempL < $fichero | tail -1 )"
		turncorto="$(head -n $numlineaTurnC < $fichero | tail -1 )"
		turnlargo="$(head -n $numlineaTurnL < $fichero | tail -1 )"
		i=1
		veces=0
		aux="0"
		while test "$(echo $turncorto | cut -f 8 -d "|" | cut -f $i -d ":")" != ""
		do
			jugada="$(echo $turncorto | cut -f 8 -d "|" | cut -f $i -d ":")"
			if test "$aux" = "0"
			then
				if test "$(echo $jugada | cut -f 3 -d ".")" = "5"
				then
					veces=$(($veces+1))
					aux="1"
				fi
			else	
				if test "$(echo $jugada | cut -f 2 -d ".")" = "5"
				then
					aux="0"
				else 
					veces=$(($veces+1))
				fi
			fi
			i=$(($i+1))
		done
		veces=$(($((100*$veces))/$(($i-1))))
		clear
		tput cup 0 0
		echo "                                                                              "
		echo
		echo
		echo
		echo "                                ---ESTADÍSTICAS---    "
		echo "                                 ---GENERALES---"
		echo " _____________________________________________________________________________ "
		echo "|_____________________________________________________________________________|"
		echo "| |                                                                         | |"
		echo "| |                NÚMERO TOTAL DE PARTIDAS JUGADAS: $numjuegos             | |"
		echo "| |                                                                         | |"
		echo "| |                MEDIA DEL NÚMERO DE MOVIMIENTOS: $turnos                 | |"
		echo "| |                                                                         | |"
		echo "| |                TIEMPO MEDIO DE LAS PARTIDAS JUGADAS: $tiempo            | |"
		echo "| |                                                                         | |"
		echo "| |                TIEMPO TOTAL JUGADO EN SEGUNDOS: $tiempoT                | |"
		echo "| |                                                                         | |"
		echo "| |              (PULSE INTRO PARA VER LAS JUGADAS ESPECIALES)              | |"
		echo "|_|_________________________________________________________________________|_|"	
		echo "|_____________________________________________________________________________|"
		read

		clear
		tput cup 0 0
		echo "                                                                              "
		echo
		echo "                                ---JUGADAS---    "
		echo "                               ---ESPECIALES---"
		echo "                         (PULSE INTRO PARA CONTINUAR)"
		echo
		echo "DATOS DE LA JUGADA MÁS CORTA EN EL TIEMPO:"
		echo "$tempcorto"
		read
	
		clear
		tput cup 0 0
		echo "                                                                              "
		echo
		echo "                                ---JUGADAS---    "
		echo "                               ---ESPECIALES---"
		echo "                         (PULSE INTRO PARA CONTINUAR)"
		echo
		echo "DATOS DE LA JUGADA MÁS LARGA EN EL TIEMPO:"
		echo "$templargo"
		read

		clear
		tput cup 0 0
		echo "                                                                              "
		echo
		echo "                                ---JUGADAS---    "
		echo "                               ---ESPECIALES---"
		echo "                         (PULSE INTRO PARA CONTINUAR)"
		echo
		echo "DATOS DE LA JUGADA MÁS CORTA EN TURNOS:"
		echo "$turncorto"
		read

		clear
		tput cup 0 0
		echo "                                                                              "
		echo
		echo "                                ---JUGADAS---    "
		echo "                               ---ESPECIALES---"
		echo "                           (PULSE INTRO PARA CONTINUAR)"
		echo
		echo "DATOS DE LA JUGADA MÁS LARGA EN TURNOS:"
		echo "$turnlargo"
		read

		clear
		tput cup 0 0
		echo "                                                                              "
		echo
		echo "                                ---JUGADAS---    "
		echo "                               ---ESPECIALES---"
		echo "                           (PULSE INTRO PARA SALIR)"
		echo
		echo "PORCENTAJE DE PARTIDA QUE HA ESTADO OCUPADA LA POSICIÓN CENTRAL EN LA"
		echo "PARTIDA DE MENOS TURNOS: "
		echo "$veces%"
		read
	else
		clear
		tput cup 0 0
		echo
		echo
		echo
		echo
		echo
		echo
		echo
		echo 
		echo "                            ---NO HAY DATOS---                "
		echo "         ---O EL FICHERO DE ESTADÍSTICAS EMPIEZA POR LINEA VACÍA---"
		echo "                         (PULSE INTRO PARA SALIR)"
		read
	fi

}
############################################################################################################
############################################################################################################
#FUNCIÓN ALTAMENTE SECRETA, ESTO ES UN EASTER EGG, NO MIRAR, PASA DE ELLO PLS
############################################################################################################
############################################################################################################
function KONAMI
{
	clear
	tput setaf 15
	tput setab 17
	clear
	echo
	echo
	echo " _____________________________________________________________________________ "
	echo "|_____________________________________________________________________________|"
	echo "| |                                                                         | |"
	echo "| |                           ENHORABUENA $nomUsr                            | |"
	echo "| |                                                                         | |"
	echo "| |                    ¡¡¡¡HAS GANADO SIN HACER NADA!!!!                    | |"
	echo "| |                  es como si estuvieras haciendo trampas...              | |"
	echo "| |                                                                         | |"
	echo "| |            DE TODAS FORMAS PENSARÉ QUE ERES UN JUGADOR LIMPIO           | |"
	echo "| |                                ASÍ QUE                                  | |"
	echo "| |                     TIENES MI MÁXIMO RESPETO, $nomUsr                    | |"
	echo "| |                                                                         | |"
	echo "| |                        (PULSA INTRO PARA SALIR)                         | |"
	echo "|_|_________________________________________________________________________|_|"	
	echo "|_____________________________________________________________________________|"
	echo
	read
}
############################################################################################################
############################################################################################################
#Funcion presentacion de pantalla derrota/victoria
############################################################################################################
############################################################################################################
function pantallaFinal
{
	if test "$ganador" = "X" -a "$comienza" = "1" -o "$ganador" = "O" -a "$comienza" = "2"
	then
		clear
		tput setaf 15
		tput setab 2
		clear
		echo
		echo
		echo " _____________________________________________________________________________ "
		echo "|_____________________________________________________________________________|"
		echo "| |                                                                         | |"
		echo "| |                           ENHORABUENA $nomUsr                            | |"
		echo "| |                      HAS DERROTADO A LAS MÁQUINAS                       | |"
		echo "| |                                                                         | |"
		echo "| |   Primera Ley de Asimov:                                                | |"
		echo "| |   \"Un robot no debe dañar a un ser humano o, por su inacción,           | |"
		echo "| |   dejar que un ser humano sufra daño.\"                                  | |"
		echo "| |                                                                         | |"
		echo "| |                        (PULSA INTRO PARA SALIR)                         | |"
		echo "|_|_________________________________________________________________________|_|"	
		echo "|_____________________________________________________________________________|"
		echo
		read
	else
		clear
		tput setaf 0
		tput setab 9
		clear
		echo
		echo
		echo " _____________________________________________________________________________ "
		echo "|_____________________________________________________________________________|"
		echo "| |                                                                         | |"
		echo "| |                           ENHORABUENA MAQUINA                           | |"
		echo "| |                  EL USB HA SIDO EXPULSADO CORRECTAMENTE                 | |"
		echo "| |                                                                         | |"
		echo "| |   Primera Ley de Asimov:                                                | |"
		echo "| |   \"Un robot no debe dañar a un ser humano o, por su inacción,           | |"
		echo "| |   dejar que un ser humano sufra daño.\"                                  | |"
		echo "| |                                  ...                                    | |"
		echo "| |                           PERO SÍ HUMILLARLO                            | |"
		echo "| |                         BIP BOP... BIP BOP BIP                          | |"
		echo "| |                                                                         | |"
		echo "| |                        (PULSA INTRO PARA SALIR)                         | |"
		echo "|_|_________________________________________________________________________|_|"	
		echo "|_____________________________________________________________________________|"
		read
	fi
}
############################################################################################################
############################################################################################################
#Funcion escritura jugadas
############################################################################################################
############################################################################################################
function jugadas
{	
	if test $numturno -eq 1 
	then
		echo "$turno.0.$casilla" >aux.txt
	elif test $numturno -eq 2
	then
		echo "$turno.0.$casilla" >aux2.txt
		paste -d ":" aux.txt aux2.txt > aux3.txt
	elif test $numturno -le 6
	then 
		if test $(($numturno%2)) -eq 0
		then
			echo "$turno.0.$casilla" >aux.txt
			paste -d ":" aux2.txt aux.txt > aux3.txt
		else
			echo "$turno.0.$casilla" >aux.txt
			paste -d ":" aux3.txt aux.txt > aux2.txt
		fi
	else
		if test $(($numturno%2)) -eq 0
		then
			echo "$turno.$casilla.$move" >aux.txt
			paste -d ":" aux2.txt aux.txt > aux3.txt
		else
			echo "$turno.$casilla.$move" >aux.txt
			paste -d ":" aux3.txt aux.txt > aux2.txt
		fi
	fi
}

############################################################################################################
############################################################################################################
#Funcion mover ficha maquina
############################################################################################################
############################################################################################################
function moverM
{
	tput cup 18 0
	tput setaf 0
	echo "Su rival está decidiendo qué casilla mover. Espere un segundo."
	sleep 1
	aux=0
	while test "$aux" = "0"
	do
		aux=0
		casilla="$(($RANDOM%9+1))"
		if test "${usadas[$(($casilla-1))]}" = "$ficha"
		then
			if test "$regla" = "1" -a "$casilla" != "5" -o "$regla" = "2"
			then
				aux=1
			fi
		fi
	done
	aux=0
	while test "$aux" = "0"
	do
		aux=0
		move="$(($RANDOM%9+1))"
		if test "${usadas[$(($move-1))]}" != "O" -a "${usadas[$(($move-1))]}" != "X"
		then
			aux=1
		fi
	done
	usadas[$(($casilla-1))]=$(($casilla-1))
	usadas[$(($move-1))]=$ficha
	tput setaf 4
	case "$casilla" in
		'1')
			tput cup 6 33
			echo " "
			;;
		'2')
			tput cup 6 39
			echo " "
			;;
		'3')
			tput cup 6 45
			echo " "
			;;
		'4')
			tput cup 9 33
			echo " "
			;;
		'5')
			tput cup 9 39
			echo " "						
			;;
		'6')
			tput cup 9 45
			echo " "
			;;
		'7')
			tput cup 12 33
			echo " "
			;;
		'8')
			tput cup 12 39
			echo " "
			;;
		'9')
			tput cup 12 45
			echo " "
			;;
	esac
	case "$move" in
		'1')
			tput cup 6 33
			echo "$ficha"
			;;
		'2')
			tput cup 6 39
			echo "$ficha"
			;;
		'3')
			tput cup 6 45
			echo "$ficha"
			;;
		'4')
			tput cup 9 33
			echo "$ficha"
			;;
		'5')
			tput cup 9 39
			echo "$ficha"						
			;;
		'6')
			tput cup 9 45
			echo "$ficha"
			;;
		'7')
			tput cup 12 33
			echo "$ficha"
			;;
		'8')
			tput cup 12 39
			echo "$ficha"
			;;
		'9')
			tput cup 12 45
			echo "$ficha"
			;;
	esac
}

############################################################################################################
############################################################################################################
#Funcion mover ficha humano
############################################################################################################
############################################################################################################
function moverH
{
	aux=1
	tput setaf 0
	while test $aux -eq 1
	do  
		aux=0
		tput cup 19 0
		echo "                                                                               "
		tput cup 18 0
		echo "INSERTE LA CASILLA (OCUPADA POR $ficha) QUE QUIERA MOVER                           "
		read casilla
		if test $casilla -ge 1 -a $casilla -le 9
		then
			if test "${usadas[$(($casilla-1))]}" = "$ficha"
			then
				if test "$regla" = "2" -o "$regla" = "1" -a "$casilla" != "5"
				then
					tput cup 19 0
					echo "                                                                               "
					echo "                                                                               "
					echo "                                                                               "
					break
				else
					tput cup 20 0
					echo "                                                                              "
					echo "                                                                              " 
					echo "                                                                              "
					tput cup 20 0			
					echo "ATENCIÓN, FICHA CENTRAL ESTÁ EN 1, NO PUEDE MOVER LA FICHA EN POSICIÓN 5"
					sleep 2
					tput cup 18 0
					echo "                                                                              "
					echo "                                                                              " 
					echo "                                                                              "
					echo "                                                                              "
					aux=1
				fi
			else
				tput cup 20 0
				echo "                                                                              "
				echo "                                                                              " 
				echo "                                                                              "
				tput cup 20 0
				echo "ESA CASILLA NO ES SUYA. SELECCIONE UNA QUE LO SEA."
				sleep 2
				tput cup 18 0
				echo "                                                                              "
				echo "                                                                              " 
				echo "                                                                              "
				echo "                                                                              "
				aux=1
			fi
		else
		
			tput cup 20 0
			echo "                                                                              "
			echo "                                                                              " 
			echo "                                                                              "
			tput cup 20 0
			echo "CASILLA FUERA DE RANGO (1-9) O VALOR NO VÁLIDO                " 
			sleep 2
			tput cup 18 0
			echo "                                                                              "
			echo "                                                                              " 
			echo "                                                                              "
			echo "                                                                              "
			aux=1
			
		fi 
	done
	aux=1
	while test $aux -eq 1
	do
		aux=0
		tput cup 18 0
			echo "INSERTE LA CASILLA A LA QUE SE QUIERE MOVER         "
			read move
			if test $move -ge 1 -a $move -le 9
			then
				if test "${usadas[$(($move-1))]}" = "O" -o "${usadas[$(($move-1))]}" = "X"
				then
					tput cup 20 0
					echo "                                                                              "
					echo "                                                                              " 
					echo "                                                                              "
					tput cup 20 0
					echo "ESA CASILLA NO ESTÁ VACÍA. SELECCIONE UNA QUE LO ESTÉ"
					sleep 2
					tput cup 18 0
					echo "                                                                              "
					echo "                                                                              " 
					echo "                                                                              "
					echo "                                                                              " 
					echo "                                                                              "
					aux=1
				else
							
					tput cup 19 0
					echo "                                                                        "
					echo "                                                                        "
					echo "                                                                        "
					break

				fi
			else
				tput cup 20 0
				echo "                                                                       "
				echo "                                                                       " 
				echo "                                                                       "
				tput cup 20 0
				echo "CASILLA FUERA DE RANGO (1-9) O VALOR NO VALIDO                         "
				sleep 2
				tput cup 18 0
				echo "                                                                       "
				echo "                                                                       " 
				echo "                                                                       " 
				echo "                                                                       "
				echo "                                                                       "
				echo "                                                                       "
				aux=1
			fi
	done
	usadas[$(($casilla-1))]=$(($casilla-1))
	usadas[$(($move-1))]=$ficha
	tput setaf 1
	case "$casilla" in
		'1')
			tput cup 6 33
			echo " "
			;;
		'2')
			tput cup 6 39
			echo " "
			;;
		'3')
			tput cup 6 45
			echo " "
			;;
		'4')
			tput cup 9 33
			echo " "
			;;
		'5')
			tput cup 9 39
			echo " "						
			;;
		'6')
			tput cup 9 45
			echo " "
			;;
		'7')
			tput cup 12 33
			echo " "
			;;
		'8')
			tput cup 12 39
			echo " "
			;;
		'9')
			tput cup 12 45
			echo " "
			;;
	esac
	case "$move" in
		'1')
			tput cup 6 33
			echo "$ficha"
			;;
		'2')
			tput cup 6 39
			echo "$ficha"
			;;
		'3')
			tput cup 6 45
			echo "$ficha"
				;;
		'4')
			tput cup 9 33
			echo "$ficha"
			;;
		'5')
			tput cup 9 39
			echo "$ficha"						
			;;
		'6')
			tput cup 9 45
			echo "$ficha"
			;;
		'7')
			tput cup 12 33
			echo "$ficha"
			;;
		'8')
			tput cup 12 39
			echo "$ficha"
			;;
		'9')
			tput cup 12 45
			echo "$ficha"
			;;
	esac
}

############################################################################################################
############################################################################################################
#Funcion lectura casilla de la maquina
############################################################################################################
############################################################################################################
function casillaM
{
	tput cup 18 0
	tput setaf 0
	echo "SU RIVAL ESTÁ DECIDIENDO QUÉ CASILLA RELLENAR. ESPERE UN SEGUNDO"
	sleep 1
	while true
		do
			casilla="$(($RANDOM%9+1))"
			if test "${usadas[$(($casilla-1))]}" != "O" -a "${usadas[$(($casilla-1))]}" != "X"
			then
				usadas[$(($casilla-1))]="$ficha"
				tput setaf 4
				case "$casilla" in
					'1')
						tput cup 6 33
							echo "$ficha"
						;;
					'2')
						tput cup 6 39
							echo "$ficha"
						;;
					'3')
						tput cup 6 45
							echo "$ficha"
						;;
					'4')
						tput cup 9 33
							echo "$ficha"
						;;
					'5')
						tput cup 9 39
							echo "$ficha"						
						;;
					'6')
						tput cup 9 45
							echo "$ficha"
						;;
					'7')
						tput cup 12 33
							echo "$ficha"
						;;
					'8')
						tput cup 12 39
							echo "$ficha"
						;;
					'9')
						tput cup 12 45
							echo "$ficha"
						;;
				esac
				break
			fi
		done
}
############################################################################################################
############################################################################################################
#Funcion lectura casilla del humano
############################################################################################################
############################################################################################################
function casillaH
{
	aux=1
	tput setaf 0
	while test $aux -eq 1
	do  
		aux=0
		tput cup 19 0
		echo "                                                                        "
		tput cup 18 0
		echo "INSERTE LA CASILLA (1-9) QUE QUIERA RELLENAR                                 "
		read casilla
		if test $casilla -ge 1 -a $casilla -le 9
		then
			if test "${usadas[$(($casilla-1))]}" = "O" -o "${usadas[$(($casilla-1))]}" = "X"
			then
				tput cup 20 0
				echo "                                                                       "
				echo "                                                                       " 
				echo "                                                                       "
				tput cup 20 0
				echo "LA CASILLA YA ESTÁ OCUPADA, INSERTE OTRA"
				sleep 2
				tput cup 18 0
				echo "                                                                       "
				echo "                                                                       " 
				echo "                                                                       "
				echo "                                                                       " 
				aux=1
			else
				usadas[$(($casilla-1))]="$ficha"
				tput cup 19 0
				echo "                                                                        "
				tput setaf 1
				case "$casilla" in
					'1')
						tput cup 6 33
							echo "$ficha"
						;;
					'2')
						tput cup 6 39
							echo "$ficha"
						;;
					'3')
						tput cup 6 45
							echo "$ficha"
						;;
					'4')
						tput cup 9 33
							echo "$ficha"
						;;
					'5')
						tput cup 9 39
							echo "$ficha"						
						;;
					'6')
						tput cup 9 45
							echo "$ficha"
						;;
					'7')
						tput cup 12 33
							echo "$ficha"
						;;
					'8')
						tput cup 12 39
							echo "$ficha"
						;;
					'9')
						tput cup 12 45
							echo "$ficha"
						;;
				esac
				break
			fi
		else
			tput cup 20 0
			echo "                                                                       "
			echo "                                                                       " 
			echo "                                                                       "
			tput cup 20 0
			echo "CASILLA FUERA DE RANGO (1-9) O VALOR NO VÁLIDO"
			sleep 2
			tput cup 18 0
			echo "                                                                       "
			echo "                                                                       " 
			echo "                                                                       "
			echo "                                                                       "
			aux=1
		fi 
	done 
}
############################################################################################################
############################################################################################################
#Funcion de escritura del fichero de estadísticas 
############################################################################################################
############################################################################################################
function escrituraEst
{
	cd $(dirname $ruta)
	fichero=$(basename $ruta)
	echo "$partida" > partida.txt 
	echo "$fecha" > fecha.txt
	echo "$comienza" > comienza.txt
	echo "$regla" > central.txt
	if test "$ganador" = "X" -a "$comienza" = "1" -o "$ganador" = "O" -a "$comienza" = "2"
	then
		echo "1" >ganador.txt
	else
		echo "2" >ganador.txt
	fi
	echo "$tiempo" > tiempo.txt
	echo "$(($numturno-1))" >movimientos.txt
	paste -d "|" partida.txt fecha.txt > final1.txt
	paste -d "|" final1.txt comienza.txt > final2.txt
	paste -d "|" final2.txt central.txt > final3.txt
	paste -d "|" final3.txt ganador.txt > final4.txt
	paste -d "|" final4.txt tiempo.txt > final5.txt
	paste -d "|" final5.txt movimientos.txt >final6.txt
	paste -d "|" final6.txt destruccion.txt >>$fichero
	rm partida.txt
	rm fecha.txt
	rm comienza.txt
	rm central.txt
	rm ganador.txt
	rm tiempo.txt
	rm movimientos.txt
	rm destruccion.txt
	rm final1.txt
	rm final2.txt
	rm final3.txt
	rm final4.txt
	rm final5.txt
	rm final6.txt
	cd $rutaOrg
}
############################################################################################################
############################################################################################################
#Funcion inicio del juego
############################################################################################################
############################################################################################################
function fjuego
{
	tput setaf 0
	partida=$$
	fecha=$(date +"%d-%m-%Y")
	inicio=$(perl -e 'print time."\n";')
	numturno=1
	tput setaf 0
	turno="$comienza"
	ganador=0
	usadas=(0 1 2 3 4 5 6 7 8)
	clear
	echo
	echo
	echo
	echo
	echo
	echo "                                    |     |     "
	echo "                                    |     |     "
	echo "                               _____|_____|_____" 
	echo "                                    |     |     "
	echo "                                    |     |     "
	echo "                               _____|_____|_____" 
	echo "                                    |     |     "
	echo "                                    |     |     "
	echo "                                    |     |     "
	echo
	while test "$ganador" = "0"
	do 
		if test "$turno" = "1"
		then
			tput cup 1 0
			tput setaf 0	
			echo "TURNO DE $nomUsr                                               TURNO NÚMERO: $numturno"
			echo "FICHA A JUGAR: "
			tput cup 2 15
			tput setaf 1
			if test "$comienza" = "1"
			then
				ficha=X
			else	
				ficha=O
			fi
			echo "$ficha"
			if test $numturno -le 6
			then 
				casillaH
			else
				moverH
			fi
			jugadas
			turno=2
		else
			tput cup 1 0
			tput setaf 0 
			echo "TURNO DE LA MAQUINA                                           TURNO NÚMERO: $numturno"
			echo "FICHA A JUGAR: "
			tput cup 2 15
			tput setaf 4
			if test "$comienza" = "2"
			then
				ficha=X
			else	
				ficha=O
			fi
			echo "$ficha"
			if test $numturno -le 6 
			then 
				if test "$DOSJUG" != "1"
				then
					casillaM
				else
					casillaH
				fi
			else
				if test "$DOSJUG" != "1"
				then
					moverM
				else
					moverH
				fi
			fi
			jugadas
			turno=1
			
		fi
		if test $numturno -ge 5
		then
			if test "${usadas[0]}" = "${usadas[1]}" -a "${usadas[0]}" = "${usadas[2]}"
			then
				ganador="${usadas[0]}"

				elif test "${usadas[3]}" = "${usadas[4]}" -a "${usadas[3]}" = "${usadas[5]}"
				then
					ganador="${usadas[3]}"
					
					elif test "${usadas[6]}" = "${usadas[7]}" -a "${usadas[6]}" = "${usadas[8]}"
					then
						ganador="${usadas[6]}"
				
						elif test "${usadas[0]}" = "${usadas[3]}" -a "${usadas[0]}" = "${usadas[6]}"
						then
							ganador="${usadas[0]}"

							elif test "${usadas[1]}" = "${usadas[4]}" -a "${usadas[1]}" = "${usadas[7]}"
							then
								ganador="${usadas[1]}"
								
								elif test "${usadas[2]}" = "${usadas[5]}" -a "${usadas[2]}" = "${usadas[8]}"
								then
									ganador="${usadas[2]}"
			
									elif test "${usadas[0]}" = "${usadas[4]}" -a "${usadas[0]}" = "${usadas[8]}"
									then
										ganador="${usadas[0]}"

										elif test "${usadas[2]}" = "${usadas[4]}" -a "${usadas[2]}" = "${usadas[6]}"
										then
											ganador="${usadas[2]}"
			fi									
		fi
		numturno="$(($numturno+1))"
	done
	if test $(($numturno%2)) -eq 0
	then
		cat aux2.txt > destruccion.txt
	else
		cat aux3.txt > destruccion.txt
	fi
	rm aux.txt
	rm aux2.txt
	rm aux3.txt
	fin=$(perl -e 'print time."\n";')
	tiempo=$(($fin - $inicio))
	sleep 1
	pantallaFinal
	clear 
	echo 
	echo
	echo
	echo
	echo
	echo
	echo "ESTADÍSITCAS: "
	echo "PARTIDA: $partida"
	echo "FECHA: $fecha"
	echo "COMIENZOP: $comienza"	
	echo "CENTRAL: $regla"
	if test "$ganador" = "X" -a "$comienza" = "1" -o "$ganador" = "O" -a "$comienza" = "2"
	then
		echo "GANADOR: 1"
	else
		echo "GANADOR: 2"
	fi
	echo "TIEMPO: $tiempo"
	echo "MOVIMIENTOS: $(($numturno-1))"
	echo "JUGADA: $(cat destruccion.txt)"
	echo 
	echo "                           (PULSE INTRO PARA CONTINUAR)"
	read
	escrituraEst
}
############################################################################################################
############################################################################################################
#Funcion presentacion del juego
############################################################################################################
############################################################################################################
function presentacionjuego
{
	tput setab 2
	tput setaf 0
	aux=0
	comienza=$(grep "^C" < oxo.cfg | cut -c 10)
	regla=$(grep "^F" < oxo.cfg | cut -c 14)
	clear
	echo
	echo
	echo
	echo
	echo "                                    |     |     "
	echo "                                 1  |  2  |  3  "
	echo "                               _____|_____|_____" 
	echo "                                    |     |     "
	echo "                                 4  |  5  |  6  "
	echo "                               _____|_____|_____" 
	echo "                                    |     |     "
	echo "                                 7  |  8  |  9  "
	echo "                                    |     |     "
	echo
	echo
	tput setaf 15
	if test "$comienza" = "3"
	then
		comienza="$(($RANDOM%2+1))"
	fi
	echo " _____________________________________________________________________________ "
	echo "|_____________________________________________________________________________|"
	echo "| |                                                                         | |"
	if test "$comienza" = "1"
	then
		echo "| |                   JUGADOR: X               MAQUINA: O                   | |"
		echo "| |                            COMIENZA: HUMANO                             | |"

		elif test "$comienza" = "2"
		then 
			echo "| |                   JUGADOR: O               MAQUINA: X                   | |"
			echo "| |                            COMIENZA: MAQUINA                            | |"
		else
			clear
			echo 
			echo
			echo
			echo
			echo
			echo
			echo " _____________________________________________________________________________ "
			echo "|_____________________________________________________________________________|"
			echo "| |                                                                         | |"
			echo "| |                           ERROR EN LA DETECCIÓN                         | |"
			echo "| |                      DE LA CONFIGURACION DE COMIENZO                    | |"
			echo "| |                                                                         | |"
			echo "| |                                 POR FAVOR                               | |"
			echo "| |                 VAYA A CONFIGURACIÓN Y ACTUALICE LA VARIABLE            | |"
			echo "| |                                                                         | |"
			echo "| |                          PULSE INTRO PARA VOLVER                        | |"		
			echo "|_|_________________________________________________________________________|_|"	
			echo "|_____________________________________________________________________________|"	
			aux=1
			read
	fi
	if test "$aux" = "0"
	then
		if test "$regla" = "1"
		then
			echo "| |           NO SE PUEDE MOVER LA FICHA CENTRAL DURANTE LA PARTIDA         | |"
			echo "| |                                                                         | |"
			echo "| |                           PRESS ENTER TO START                          | |"	
			echo "|_|_________________________________________________________________________|_|"	
			echo "|_____________________________________________________________________________|"
			read
		elif test "$regla" = "2"
		then
			echo "| |           SÍ SE PUEDE MOVER LA FICHA CENTRAL DURANTE LA PARTIDA         | |"
			echo "| |                                                                         | |"
			echo "| |                           PRESS ENTER TO START                          | |"	
			echo "|_|_________________________________________________________________________|_|"	
			echo "|_____________________________________________________________________________|"
			read
		else
			clear
			echo 
			echo
			echo
			echo
			echo
			echo
			echo " _____________________________________________________________________________ "
			echo "|_____________________________________________________________________________|"
			echo "| |                                                                         | |"
			echo "| |                           ERROR EN LA DETECCIÓN                         | |"
			echo "| |                     DE LA CONFIGURACION DE FICHACENTRAL                 | |"
			echo "| |                                                                         | |"
			echo "| |                                 POR FAVOR                               | |"
			echo "| |                 VAYA A CONFIGURACIÓN Y ACTUALICE LA VARIABLE            | |"
			echo "| |                                                                         | |"
			echo "| |                          PULSE INTRO PARA VOLVER                        | |"		
			echo "|_|_________________________________________________________________________|_|"	
			echo "|_____________________________________________________________________________|"	
			aux=1
			read
		fi
	fi
}

############################################################################################################
############################################################################################################
#Funcion de manejo del fichero configuracion-estadisticas
############################################################################################################
############################################################################################################
function estadistica
{ 
	clear
	echo "VAS A CAMBIAR LA RUTA DE LAS ESTADISTICAS DE LA PARTIDA"
	echo "INSERTE SU RUTA:"
	echo 
	echo 
	echo 
	echo 
	echo 
	echo 
	echo 
	echo 
	echo 
	tput setaf 15
	echo " _____________________________________________________________________________ "
	echo "|_____________________________________________________________________________|"
	echo "| |                                                                         | |"
	echo "| |    ESTADISTICA SERÁ UNA VARIABLE INTERNA DEL PROGRAMA QUE CONTENDRÁ     | |"
	echo "| |      LA RUTA DONDE ESTÁ ALMACENADO EL FICHERO CON LAS ESTADÍSTICAS      | |"
	echo "| |                                                                         | |"
	echo "| |    V) VOLVER                                                            | |"	
	echo "|_|_________________________________________________________________________|_|"	
	echo "|_____________________________________________________________________________|"
	tput cup 2 0
	tput setaf 0
	read ruta
	while test "$ruta" != "v" -a "$ruta" != "V"
	do
		if test "$ruta" != ""
		then
			if test -a $ruta
			then
				if test -r $ruta
				then
					if test -w $ruta
					then
						tput cup 0 0
						tput setaf 0
						echo "VAS A CAMBIAR LA RUTA DE LAS ESTADISTICAS DE LA PARTIDA"
						echo "INSERTE SU RUTA:"
						echo "                                                                               "
						echo "RUTA ADMITIDA                                                                  "
						echo "                                                                               "
						echo "                                                                               "
						echo "                                                                               "
						echo "                                                                               "
						echo "                                                                               "
						echo "                                                                               "
						echo "                                                                               "
						tput setaf 15
						echo " _____________________________________________________________________________ "
						echo "|_____________________________________________________________________________|"
						echo "| |                                                                         | |"
						echo "| |    ESTADISTICA SERÁ UNA VARIABLE INTERNA DEL PROGRAMA QUE CONTENDRÁ     | |"
						echo "| |      LA RUTA DONDE ESTÁ ALMACENADO EL FICHERO CON LAS ESTADÍSTICAS      | |"
						echo "| |                                                                         | |"
						echo "| |    V) VOLVER                                                            | |"	
						echo "|_|_________________________________________________________________________|_|"	
						echo "|_____________________________________________________________________________|"
						tput cup 2 0
						tput setaf 0
						grep "^C" < oxo.cfg >aux1.txt
						grep "^F" < oxo.cfg >aux2.txt
						echo "ESTADISTICAS=$ruta" >aux3.txt
						paste -d "\n" aux1.txt aux3.txt > final.txt
						paste -d "\n" final.txt aux2.txt > oxo.cfg
						rm aux1.txt
						rm aux2.txt
						rm aux3.txt
						rm final.txt
						sleep 1
						break
					else
						tput cup 0 0
						tput setaf 0
						echo "VAS A CAMBIAR LA RUTA DE LAS ESTADISTICAS DE LA PARTIDA"
						echo "INSERTE SU RUTA:"
						echo "                                                                              "
						echo "ATENCION, EL FICHERO NO TIENE PERMISOS DE ESCRITURA                           "
						echo "                                                                              "
						echo "                                                                              "
						echo "                                                                              "
						echo "                                                                              "
						echo "                                                                              "
						echo "                                                                              "
						echo "                                                                              "
						tput setaf 15
						echo " _____________________________________________________________________________ "
						echo "|_____________________________________________________________________________|"
						echo "| |                                                                         | |"
						echo "| |    ESTADISTICA SERÁ UNA VARIABLE INTERNA DEL PROGRAMA QUE CONTENDRÁ     | |"
						echo "| |      LA RUTA DONDE ESTÁ ALMACENADO EL FICHERO CON LAS ESTADÍSTICAS      | |"
						echo "| |                                                                         | |"
						echo "| |    V) VOLVER                                                            | |"	
						echo "|_|_________________________________________________________________________|_|"	
						echo "|_____________________________________________________________________________|"
						tput cup 2 0
						tput setaf 0
						read ruta
					fi
				else
					tput cup 0 0
					tput setaf 0
					echo "VAS A CAMBIAR LA RUTA DE LAS ESTADISTICAS DE LA PARTIDA"
					echo "INSERTE SU RUTA:"
					echo "                                                                               "
					echo "ATENCION, EL FICHERO NO TIENE PERMISOS DE LECTURA                              "
					echo "                                                                               "
					echo "                                                                               "
					echo "                                                                               "
					echo "                                                                               "
					echo "                                                                               "
					echo "                                                                               "
					echo "                                                                               "
					tput setaf 15
					echo " _____________________________________________________________________________ "
					echo "|_____________________________________________________________________________|"
					echo "| |                                                                         | |"
					echo "| |    ESTADISTICA SERÁ UNA VARIABLE INTERNA DEL PROGRAMA QUE CONTENDRÁ     | |"
					echo "| |      LA RUTA DONDE ESTÁ ALMACENADO EL FICHERO CON LAS ESTADÍSTICAS      | |"
					echo "| |                                                                         | |"
					echo "| |    V) VOLVER                                                            | |"	
					echo "|_|_________________________________________________________________________|_|"	
					echo "|_____________________________________________________________________________|"
					tput cup 2 0
					tput setaf 0
					read ruta
				fi
			else
				tput cup 0 0
				tput setaf 0
				echo "VAS A CAMBIAR LA RUTA DE LAS ESTADISTICAS DE LA PARTIDA"
				echo "INSERTE SU RUTA:"
				echo "                                                                               "
				echo "ATENCION, LA RUTA QUE HA ESPECIFICADO ES ERRÓNEA                               "
				echo "                                                                               "
				echo "                                                                               "
				echo "                                                                               "
				echo "                                                                               "
				echo "                                                                               "
				echo "                                                                               "
				echo "                                                                               "
				tput setaf 15
				echo " _____________________________________________________________________________ "
				echo "|_____________________________________________________________________________|"
				echo "| |                                                                         | |"
				echo "| |    ESTADISTICA SERÁ UNA VARIABLE INTERNA DEL PROGRAMA QUE CONTENDRÁ     | |"
				echo "| |      LA RUTA DONDE ESTÁ ALMACENADO EL FICHERO CON LAS ESTADÍSTICAS      | |"
				echo "| |                                                                         | |"
				echo "| |    V) VOLVER                                                            | |"	
				echo "|_|_________________________________________________________________________|_|"	
				echo "|_____________________________________________________________________________|"
				tput cup 2 0
				tput setaf 0
				read ruta
			fi
		else
			cd $rutaOrg	
			tput cup 0 0
			tput setaf 0
			echo "VAS A CAMBIAR LA RUTA DE LAS ESTADISTICAS DE LA PARTIDA"
			echo "INSERTE SU RUTA:"
			echo "                                                                              "
			echo "ATENCION, EL FORMATO DEBE SER: [RUTA]NOMBRE_DEL_FICHERO                       "
			echo "                                                                              "
			echo "                                                                              "
			echo "                                                                              "
			echo "                                                                              "
			echo "                                                                              "
			echo "                                                                              "
			echo "                                                                              "
			tput setaf 15
			echo " _____________________________________________________________________________ "
			echo "|_____________________________________________________________________________|"
			echo "| |                                                                         | |"
			echo "| |    ESTADISTICA SERÁ UNA VARIABLE INTERNA DEL PROGRAMA QUE CONTENDRÁ     | |"
			echo "| |      LA RUTA DONDE ESTÁ ALMACENADO EL FICHERO CON LAS ESTADÍSTICAS      | |"
			echo "| |                                                                         | |"
			echo "| |    V) VOLVER                                                            | |"	
			echo "|_|_________________________________________________________________________|_|"	
			echo "|_____________________________________________________________________________|"
			tput cup 2 0
			tput setaf 0
			read ruta
		fi
	done
}


############################################################################################################
############################################################################################################
#Funcion de manejo del fichero configuracion-FICHACENTRAL
############################################################################################################
############################################################################################################
function fichacentral
{
	clear
	echo "VAS A CAMBIAR LA OPCION DE MOVILIDAD DE LA FICHA CENTRAL"
	echo "¿A QUÉ VALOR QUIERES CAMBIAR LA VARIABLE FICHACENTRAL?"
	echo 
	echo 
	echo 
	echo 
	echo 
	echo 
	echo 
	echo 
	echo 
	echo 
	tput setaf 15
	echo " _____________________________________________________________________________ "
	echo "|_____________________________________________________________________________|"
	echo "| |                                                                         | |"
	echo "| |    FICHACENTRAL SERÁ UNA VARIABLE INTERNA DEL PROGRAMA QUE TENDRÁ UN    | |"
	echo "| |   VALOR ENTRE 1 Y 2. SEGÚN ESTE VALOR, AL PRINCIPIO DE LA PARTIDA:      | |"
	echo "| |                                                                         | |"
	echo "| |    1) NO SE PODRÁ MOVER DURANTE EL TRANSCURSO DE LA PARTIDA             | |"
	echo "| |    2) SE PODRÁ MOVER DURANTE EL TRANSCURSO DE LA PARTIDA                | |"
	echo "| |    V) VOLVER                                                            | |"	
	echo "|_|_________________________________________________________________________|_|"	
	echo "|_____________________________________________________________________________|"
	tput cup 2 0
	tput setaf 0
	read num
	while test "$num" != "v" -a "$num" != "V"
	do
		if test "$num" != "1" -a "$num" != "2" 
		then
			tput cup 2 0
			echo "                                        "
			echo "POR FAVOR, INSERTE UN NÚMERO ENTRE 1 Y 2"
			tput cup 2 0
			echo "     "
			tput cup 2 0
			read num
			
		else
			grep "^C" < oxo.cfg >aux1.txt
			echo "FICHACENTRAL=$num" >aux2.txt
			grep "^E" < oxo.cfg >aux3.txt
			paste -d "\n" aux1.txt aux3.txt > final.txt
			paste -d "\n" final.txt aux2.txt > oxo.cfg
			rm aux1.txt
			rm aux2.txt
			rm aux3.txt
			rm final.txt
			echo "HAS CAMBIADO LA CONFIGURACION A $num           "
			sleep 2
			break
		fi
	done
}
############################################################################################################
############################################################################################################
#Funcion de manejo del fichero configuracion-comienzo
############################################################################################################
############################################################################################################
function comienzo
{
	clear
	echo "VAS A CAMBIAR EL COMIENZO DE LA PARTIDA"
	echo "¿A QUÉ VALOR QUIERES CAMBIAR LA VARIABLE COMIENZO?"
	echo 
	echo 
	echo 
	echo 
	echo 
	echo 
	echo 
	echo 
	echo 
	tput setaf 15
	echo " _____________________________________________________________________________ "
	echo "|_____________________________________________________________________________|"
	echo "| |                                                                         | |"
	echo "| |    COMIENZO SERÁ UNA VARIABLE INTERNA DEL PROGRAMA QUE TENDRÁ UN        | |"
	echo "| |   VALOR ENTRE 1 Y 3. SEGÚN ESTE VALOR, AL PRINCIPIO DE LA PARTIDA:      | |"
	echo "| |                                                                         | |"
	echo "| |    1) COMENZARÁ EL USUARIO                                              | |"
	echo "| |    2) COMENZARÁ LA INTELIGENCIA ARTIFICIAL                              | |"
	echo "| |    3) EL COMIENZO SE DECIDIRÁ DE FORMA ALEATORIA EN CADA EJECUCIÓN      | |"
	echo "| |    V) VOLVER                                                            | |"	
	echo "|_|_________________________________________________________________________|_|"	
	echo "|_____________________________________________________________________________|"
	tput cup 2 0
	tput setaf 0
	read num
	while test "$num" != "v" -a "$num" != "V"
	do
		if test "$num" != "1" -a "$num" != "2" -a "$num" != "3"
		then
			tput cup 2 0
			echo "                                        "
			echo "POR FAVOR, INSERTE UN NÚMERO ENTRE 1 Y 3"
			tput cup 2 0
			echo "     "
			tput cup 2 0
			read num
		else
			echo "COMIENZO=$num" >aux1.txt
			grep "^F" < oxo.cfg >aux2.txt
			grep "^E" < oxo.cfg >aux3.txt
			paste -d "\n" aux1.txt aux3.txt > final.txt
			paste -d "\n" final.txt aux2.txt > oxo.cfg
			rm aux1.txt
			rm aux2.txt
			rm aux3.txt
			rm final.txt
			echo "HAS CAMBIADO LA CONFIGURACION A $num                            "
			sleep 2
			break
		fi
		
	done
	

}
############################################################################################################
############################################################################################################
#Funcion del menu de configuracion
############################################################################################################
############################################################################################################
function configuracion
{
	tput setaf 0
	clear
	echo "LA CONFIGURACIÓN ACTUAL ES:"
	echo
	cd $rutaOrg
	cat oxo.cfg
	echo 
	tput setaf 1
	echo " _____________________________________________________________________________ "
	echo "|_____________________________________________________________________________|"
	echo "| |                                                                         | |"
	echo "| |                           MENÚ CONFIGURACIÓN                            | |"
	echo "| |                                                                         | |"
	echo "| |                             C)COMIENZO                                  | |"
	echo "| |                             F)FICHACENTRAL                              | |"
	echo "| |                             E)ESTADISTICAS                              | |"
	echo "| |                             V)VOLVER                                    | |"	
	echo "|_|_________________________________________________________________________|_|"	
	echo "|_____________________________________________________________________________|"
	echo
	tput setaf 0
	echo "INTRODUZCA UNA OPCIÓN:"
	read selecC	
	case "$selecC" in 
		'C'|'c')
			comienzo
			;;
		'F'|'f')
			fichacentral
			;;
		'E'|'e')
			estadistica
			;;
		'v'|'V')
			selecC='v'		
			;;
		* )
			echo "OPCIÓN NO VÁLIDA"
			sleep 1
			;;
			
	esac
}
############################################################################################################
############################################################################################################
#Funcion comprobacionCFG
############################################################################################################
############################################################################################################
function comprobacionCFG
{
	tput setab 0
	tput setaf 1
	clear
	if ls -l oxo.cfg
	then
		tput cup 0 0
		echo "                                                                            "
		tput cup 0 0
		i=0
		lineas=$(wc -l < oxo.cfg)
		while test $i -le $lineas
		do
			linea="$(head -n $(($i+1)) < oxo.cfg | tail -1 )"
			case "$i" in
				'0')
					if test "$(echo $linea | cut -c 1-9)" != "COMIENZO="
					then
						clear
						echo "                                                                                "
						echo
						echo
						echo
						echo
						echo
						echo
						echo
						echo
						echo
						echo "    ATENCIÓN: EL FORMATO DEL FICHERO OXO.CFG NO COINCIDE CON EL NECESARIO"
						echo "                        PARA LA EJECUCIÓN DEL PROGRAMA"
						echo
						echo "                            PULSE INTRO PARA SALIR"
						read
						clear
						exit 0
					fi
					;;
				'1')	
					if test "$(echo $linea | cut -c 1-13)" != "FICHACENTRAL="
					then
						clear
						echo "                                                                                "
						echo
						echo
						echo
						echo
						echo
						echo
						echo
						echo
						echo
						echo "    ATENCIÓN: EL FORMATO DEL FICHERO OXO.CFG NO COINCIDE CON EL NECESARIO"
						echo "                        PARA LA EJECUCIÓN DEL PROGRAMA"
						echo
						echo "                            PULSE INTRO PARA SALIR"
						read
						clear
						exit 0
					fi
					;;
				'2')
					if test "$(echo $linea | cut -c 1-13)" != "ESTADISTICAS="
					then
						clear
						echo "                                                                                "
						echo
						echo
						echo
						echo
						echo
						echo
						echo
						echo
						echo
						echo "    ATENCIÓN: EL FORMATO DEL FICHERO OXO.CFG NO COINCIDE CON EL NECESARIO"
						echo "                        PARA LA EJECUCIÓN DEL PROGRAMA"
						echo
						echo "                            PULSE INTRO PARA SALIR"
						read
						clear
						exit 0
					fi
					;;
			esac
		i=$(($i+1))
		done 
		
	else
		clear
		echo "                                                                                "
		echo
		echo
		echo
		echo
		echo
		echo
		echo
		echo
		echo
		echo "    ATENCIÓN: EL FICHERO OXO.CFG, IMPRESCINDIBLE PARA LA EJECUCIÓN DEL JUEGO"
		echo "              NO EXISITE O NO SE ENCUENTRA EN EL MISMO DIRECTORIO"
		echo 
		echo "                            PULSE INTRO PARA SALIR"
		read
		clear
		exit 0
	fi
}

############################################################################################################
############################################################################################################
#Funcion pantallainicio
############################################################################################################
############################################################################################################
function pantallainicio
{
	tput setab 3
	tput setaf 0
	clear
	echo "                                                                               "
	echo "                              O.X.O. - FOR LINUX                               "
	echo "                                                                               "
	echo "                                                                               "
	echo "                        EL  MEJOR JUEGO DE TRES EN RAYA                        "
	echo "                        ¡¡AHORA EN TU PROPIA TERMINAL!!                        "
	echo "                                                                               "
	echo " _____________________________________________________________________________ "
	echo "|_____________________________________________________________________________|"
	echo "| |                                                                         | |"
	echo "| |                                                                         | |"
	echo "| |                         PRESS ENTER TO CONTINUE                         | |"
	echo "| |                                                                         | |"
	echo "|_|_________________________________________________________________________|_|"	
	echo "|_____________________________________________________________________________|"
	echo
	echo
	echo
	echo
	echo
	echo
	echo "© 2019 Copyright Fausto-Sergio	                                             "
	tput cup 12 39
	read
}

############################################################################################################
############################################################################################################
#Funcion lecturaUsuario
############################################################################################################
############################################################################################################
function lecturaUsuario
{
	tput setab 3
	tput setaf 0
	clear
	echo
	echo
	echo
	echo
	echo
	echo
	echo
	echo " _____________________________________________________________________________"
	echo "|_____________________________________________________________________________|"
	echo "| |                                                                         | |"
	echo "| |                                                                         | |"
	echo "| |              INSERTE SU NOMBRE DE USUARIO (MAX 6 CARACTERES)            | |"
	echo "| |                                                                         | |"
	echo "| |                                                                         | |"
	echo "|_|_________________________________________________________________________|_|"	
	echo "|_____________________________________________________________________________|"
	echo
	tput cup 12 36
	read nomUsr
	aux=1
	while test "$aux" = "1"
	do
		aux=0
		if test "$nomUsr" = ""
		then
			tput cup 12 0
			echo "| |                                                                         | |"
			echo "| |                  POR FAVOR, INSERTE UN NOMBRE DE USUARIO                | |"
			tput cup 17 0
			sleep 1
			tput cup 12 0
			echo "| |                                                                         | |"
			echo "| |                                                                         | |"
			tput cup 12 36
			aux=1
			read nomUsr
	
		elif test ${#nomUsr} -gt 6
		then
			tput cup 12 0
			echo "| |                                                                         | |"
			echo "| |                    NOMBRE DE USUARIO DEMASIADO LARGO                    | |"
			tput cup 17 0
			sleep 1
			tput cup 12 0
			echo "| |                                                                         | |"
			echo "| |                                                                         | |"
			tput cup 12 36
			aux=1
			read nomUsr
		fi
	done
	if test ${#nomUsr} -lt 6
	then
		numVacio=$((6-${#nomUsr}))
		while test $numVacio -gt 0
		do
			nomUsr=$(echo "$nomUsr ")
			numVacio=$(($numVacio-1))
		done
	fi
	tput cup 12 0
	if test "$nomUsr" = "gyermo" -o "$nomUsr" = "GYERMO"
	then
		echo "| |                           BIENVENIDO, OH, ALTEZA                        | |"
		echo "| |                         ME INCLINO ANTE SU GRANDEZA                     | |"
		sleep 1
	else
		echo "| |                            BIENVENIDO/A, $nomUsr                         | |"
	fi
	echo "| |                                                                         | |"
	echo "|_|_________________________________________________________________________|_|"	
	echo "|_____________________________________________________________________________|"
	if test "$nomUsr" = "DOSJUG" -o "$nomUsr" = "dosjug"	
	then
		DOSJUG="1"
		nomUsr="FIGURA"
	fi
	tput cup 16 0 
	sleep 2
}
############################################################################################################
############################################################################################################
#Funcion loading
############################################################################################################
############################################################################################################
function loading
{
	i=0
	tput setab 3
	tput setaf 0
	clear
	echo
	echo
	echo
	echo
	echo
	echo
	echo
	echo
	echo
	echo
	echo
	echo
	echo
	echo
	echo
	echo
	echo
	echo
	echo
	echo "                                 _____________________________________________"
	echo "                                |                                             |"
	echo "                       LOADING: |                                             |"
	echo "                                |_____________________________________________|"
	sleep 1
	while test $i -lt 3
	do
		case "$i" in
			'0')
				tput cup 21 33
	 			echo "||||||||||||||                               |         "
				;;
			'1')
				tput cup 21 33
	 			echo "|||||||||||||||||||||||||||||                |       "
				;;
			'2')
				tput cup 21 33
	 			echo "||||||||||||||||||||||||||||||||||||||||||||||       "
				;;
		esac
		sleep 1
		i=$(($i+1))
	done
}

############################################################################################################
############################################################################################################
#Main
############################################################################################################
##########################################################################################################
resize -s 25 80 >/dev/null
if test $# -eq 0
then
	DOSJUG="0"
	exec 2>/dev/null
	comprobacionCFG
	rutaOrg="$(pwd)"
	pantallainicio
	lecturaUsuario	
	loading
	loading
	while true
	do
		cd $rutaOrg
		tput setab 6
		tput setaf 1 
		clear
		echo "                                   ---OXO---"
		echo " _____________________________________________________________________________ "
		echo "|_____________________________________________________________________________|"
		echo "| |                                                                         | |"
		echo "| |                             MENÚ  PRINCIPAL                             | |"
		echo "| |                                                                         | |"
		echo "| |                             C)CONFIGURACIÓN                             | |"
		echo "| |                             J)JUGAR                                     | |"
		echo "| |                             E)ESTADÍSTICAS                              | |"
		echo "| |                             S)SALIR                                     | |"	
		echo "|_|_________________________________________________________________________|_|"	
		echo "|_____________________________________________________________________________|"
		echo
		tput setaf 0
		echo "INTRODUZCA UNA OPCIÓN:"
		read selec
		case "$selec" in
			'C'|'c')
				selecC='a'
				while test "$selecC" != 'v'
				do
					configuracion
				done
				;;
			'J'|'j')
				ruta=$(grep "^E" < "oxo.cfg" | cut -c 14-)
				if test -a $ruta 
				then
					if test -r $ruta
					then
						if test -w $ruta
						then
							loading
							presentacionjuego
						else
							cd $rutaOrg
							clear
							echo 
							echo
							echo
							echo
							echo
							echo
							echo " _____________________________________________________________________________ "
							echo "|_____________________________________________________________________________|"
							echo "| |                                                                         | |"
							echo "| |                                 ERROR EN EL                             | |"
							echo "| |                           FICHERO DE ESTADÍSTICAS                       | |"
							echo "| |                                                                         | |"
							echo "| |                                 POR FAVOR                               | |"
							echo "| |                        AÑÁDALE PERMISOS DE ESCRITURA                    | |"
							echo "| |                                                                         | |"
							echo "| |                          PULSE INTRO PARA VOLVER                        | |"		
							echo "|_|_________________________________________________________________________|_|"	
							echo "|_____________________________________________________________________________|"	
							aux=1
							read
						fi
					else
						cd $rutaOrg
						clear
						echo 
						echo
						echo
						echo
						echo
						echo
						echo " _____________________________________________________________________________ "
						echo "|_____________________________________________________________________________|"
						echo "| |                                                                         | |"
						echo "| |                                 ERROR EN EL                             | |"
						echo "| |                           FICHERO DE ESTADÍSTICAS                       | |"
						echo "| |                                                                         | |"
						echo "| |                                 POR FAVOR                               | |"
						echo "| |                        AÑÁDALE PERMISOS DE LECTURA                      | |"
						echo "| |                                                                         | |"
						echo "| |                          PULSE INTRO PARA VOLVER                        | |"		
						echo "|_|_________________________________________________________________________|_|"	
						echo "|_____________________________________________________________________________|"	
						aux=1
						read
					fi	
				else
					cd $rutaOrg
					clear
					echo 
					echo
					echo
					echo
					echo
					echo
					echo " _____________________________________________________________________________ "
					echo "|_____________________________________________________________________________|"
					echo "| |                                                                         | |"
					echo "| |                           ERROR EN LA DETECCIÓN                         | |"
					echo "| |                         DEL FICHERO DE ESTADÍSTICAS                     | |"
					echo "| |                                                                         | |"
					echo "| |                                 POR FAVOR                               | |"
					echo "| |                   VAYA A CONFIGURACIÓN Y ACTUALICE LA RUTA              | |"
					echo "| |                                                                         | |"
					echo "| |                          PULSE INTRO PARA VOLVER                        | |"		
					echo "|_|_________________________________________________________________________|_|"	
					echo "|_____________________________________________________________________________|"	
					aux=1
					read
				fi
				if test "$aux" = "0"
				then
					fjuego
				fi				
				;;
			'E'|'e')
				tput setaf 1
				ruta=$(grep "^E" < "oxo.cfg" | cut -c 14-)
				if test -a $ruta 
				then
					if test -r $ruta
					then
						if test -w $ruta
						then
							cd $(dirname $ruta)
							fichero=$(basename $ruta)
							clear
							fEstadisticas
						else
							cd $rutaOrg
							clear
							echo 
							echo
							echo
							echo
							echo
							echo
							echo " _____________________________________________________________________________ "
							echo "|_____________________________________________________________________________|"
							echo "| |                                                                         | |"
							echo "| |                                 ERROR EN EL                             | |"
							echo "| |                           FICHERO DE ESTADÍSTICAS                       | |"
							echo "| |                                                                         | |"
							echo "| |                                 POR FAVOR                               | |"
							echo "| |                        AÑÁDALE PERMISOS DE ESCRITURA                    | |"
							echo "| |                                                                         | |"
							echo "| |                          PULSE INTRO PARA VOLVER                        | |"		
							echo "|_|_________________________________________________________________________|_|"	
							echo "|_____________________________________________________________________________|"	
							read
						fi
					else
						cd $rutaOrg
						clear
						echo 
						echo
						echo
						echo
						echo
						echo
						echo " _____________________________________________________________________________ "
						echo "|_____________________________________________________________________________|"
						echo "| |                                                                         | |"
						echo "| |                                 ERROR EN EL                             | |"
						echo "| |                           FICHERO DE ESTADÍSTICAS                       | |"
						echo "| |                                                                         | |"
						echo "| |                                 POR FAVOR                               | |"
						echo "| |                        AÑÁDALE PERMISOS DE LECTURA                      | |"
						echo "| |                                                                         | |"
						echo "| |                          PULSE INTRO PARA VOLVER                        | |"		
						echo "|_|_________________________________________________________________________|_|"	
						echo "|_____________________________________________________________________________|"	
						read
					fi	
				else
					cd $rutaOrg
					clear
					echo 
					echo
					echo
					echo
					echo
					echo
					echo " _____________________________________________________________________________ "
					echo "|_____________________________________________________________________________|"
					echo "| |                                                                         | |"
					echo "| |                           ERROR EN LA DETECCIÓN                         | |"
					echo "| |                         DEL FICHERO DE ESTADÍSTICAS                     | |"
					echo "| |                                                                         | |"
					echo "| |                                 POR FAVOR                               | |"
					echo "| |                   VAYA A CONFIGURACIÓN Y ACTUALICE LA RUTA              | |"
					echo "| |                                                                         | |"
					echo "| |                          PULSE INTRO PARA VOLVER                        | |"		
					echo "|_|_________________________________________________________________________|_|"	
					echo "|_____________________________________________________________________________|"	
					read
				fi
				;;
			'S'|'s')
				tput setab 0
				tput setaf 7
				clear
				exit 0
				;;
			'WWSSADADBA')
				KONAMI
				;;
			* )
				echo "OPCIÓN NO VÁLIDA"
				sleep 1
				;;
		esac
	done
elif test "$1" = "-g"
then
	tput setab 1
	tput setaf 15
	clear
	echo
	echo
	echo " _____________________________________________________________________________ "
	echo "|_____________________________________________________________________________|"
	echo "| |                                                                         | |"
	echo "| |               ESTE MARAVILLOSO VIDEOJUEGO SOLO DISPONIBLE               | |"
	echo "| |                   EN LAS MEJORES TERMINALES DE LINUX                    | |"
	echo "| |                                                                         | |"
	echo "| |                      HA SIDO PROGRAMADO Y CUIDADO                       | |"
	echo "| |                         CON MUCHO MIMO Y AMOR                           | |"
	echo "| |                                  POR:                                   | |"
	echo "| |                                                                         | |"	
	echo "| |                -EL AGUERRIDO, VALIENTE, APUESTO Y HERMOSO               | |"
	echo "| |                     FAUSTO SÁNCHEZ HOYA 70937831N B2                    | |"
	echo "| |                                                                         | |"	
	echo "| |                -EL CABALLEROSO, IMPONENTE, SENSUAL Y SABIO              | |"
	echo "| |                  SERGIO JUAN ROLLÁN MORALEJO 70965798B B2               | |"
	echo "| |                                                                         | |"
	echo "| |                        (PULSA INTRO PARA SALIR)                         | |"
	echo "|_|_________________________________________________________________________|_|"	
	echo "|_____________________________________________________________________________|"
	echo
	read
	tput setab 0
	tput setaf 7
	clear
else
	tput setab 0
	tput setaf 1
	clear
	echo
	echo 
	echo
	echo
	echo
	echo
	echo
	echo "                  ESTE PROGRAMA NO ADMITE ESE/ESOS ARGUMENTO/S"
	echo "                    PARA INVOCAR EL PROGRAMA CORRECTAMENTE"
	echo "                DEBE EMPLEAR UNA DE LAS SIGUIENTES POSIBILIDADES:"
	echo 
	echo "              NO ARGUMENTOS: SE EJECUTA EL PROGRAMA DE FORMA NORMAL"
	echo "                   -g: PANTALLA CON LOS COMPONENTES DEL GRUPO"
	echo
	echo
	echo "                           (PULSE INTRO PARA SALIR)"
	read
	clear
	exit 0
fi



exit 0
