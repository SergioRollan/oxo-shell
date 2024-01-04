# oxo-shell

PROGRAMA QUE EJECUTA EL JUEGO DEL TRES EN RAYA PARA SHELL DE LINUX

AUTORES: SERGIO JUAN ROLLÁN MORALEJO Y FAUSTO SÁNCHEZ HOYA

El resumen de las funcionalidades del juego se clasifica en:
- CAPÍTULO 1: ARCHIVOS DE CONFIGURACIÓN NECESARIOS
- CAPÍTULO 2: PROCESO Y REGLAS DEL JUEGO
- CAPÍTULO 3: OPCIONES DE CONFIGURACIÓN
- CAPÍTULO 4: ESTADÍSTICAS
- CAPÍTULO 5: MODO DE DOS JUGADORES

-----------------------------------------
---------- CAPÍTULO 1: ARCHIVOS DE CONFIGURACIÓN NECESARIOS ----------
-

* Para ejecutar oxo.sh de forma correcta sin que este muestre un mensaje de error nada más comenzar, será necesario que esté presente el archivo "oxo.cfg" en el mismo directorio que "oxo.sh".
* El archivo "oxo.cfg" solo es un fichero de texto que contiene tres líneas y que podrá ser editado de forma transparte desde la propia ejecución del juego.
* Opcionalmente, se puede crear un fichero de estadísticas, cuya ruta se puede especificar desde el juego y se guardará en el fichero "oxo.cfg". En el ejemplo de este repositorio se determina que, por defecto, será un fichero "oxo.estadisticas.txt" que estará en el mismo directorio que el juego y el fichero de configuración, pero el jugador podrá cambiarlo a voluntad.

-----------------------------------------
---------- CAPÍTULO 2: PROCESO Y REGLAS DEL JUEGO ----------
-

* Al comenzar, se le permite al usuario introducir su nombre, que será el que utilizará para dirigirse a él o ella durante las partidas. Posteriormente, se le mostrará el menú principal.
  * Configuración: Permite cambiar las opciones de configuración del juego (capítulo 3 de este documento). 
  * Jugar: Comienza un enfrentamiento entre el jugador y la máquina.
  * Estadísticas: Visualizan el fichero de estadísticas si se ha creado y si se ha jugador al menos una partida.
* Las reglas de las partidas se resumen en:
  * Por turnos, cada contendiente elige una casilla, escribiendo un número del 1 al 9 según indica el juego antes de comenzar.
  * Este proceso se repite tres veces. Al final del proceso habrá tres casillas marcadas con una X, tres casillas marcadas con una O y tres casillas vacías.
  * A partir de este momento, el jugador que tenga el turno deberá escoger una de sus tres fichas (escribiendo el número del 1 al 9 en el que su ficha se encuentra) y moverla a una de las tres casillas vacías (escribiendo, de nuevo, el número que le corresponde).
  * Este proceso se repetirá hasta que uno de los dos contendientes tengas sus tres fichas alineadas horizontal, vertical o diagonalmente, momento en el que habrá ganado la partida.

-----------------------------------------
---------- CAPÍTULO 3: OPCIONES DE CONFIGURACIÓN ----------
-

* En el menú de configuración del juego, el jugador puede elegir quién "empieza", es decir, quién tiene el primer turno de la partida (y por tanto todos los turnos impares) y quién tiene el segundo (y todos los pares). Las opciones son el jugador, la inteligencia artificial o aleatorio decidido en el momento de comenzar.
* El jugador podrá elegir también si se puede mover la casilla del centro durante la partida. Esto supone una desventaja para el jugador que tenga una ficha en esa casilla, y, por tanto, otorgará mayor importancia estratégica a decidir ocuparla, pues a pesar de dar la posibilidad de hacer las dos alineaciones diagonales, descartaría dos verticales y otras dos horizontales.
* Por último, el jugador podrá concretar la ruta de su fichero de estadísticas, si desea que estas se guarden.

-----------------------------------------
---------- CAPÍTULO 4: ESTADÍSTICAS ----------
-

* Cuando el jugador accede al menú de muestreo de sus estadísticas de partida, el juego le mostrará información sobre su partida más corta, su partida más larga, su partida con menor y mayor número de turnos, su tiempo y turnos totales, el número de partidas que ha disputado, la media de tiempo y de movimientos y el porcentaje de tiempo en el que la casilla del centro ha estado ocupada.
* Para mostrar el resumen de una partida, el juego muestra un texto con el siguiente formato: 1.0.5:2.9.3:1.2.1:etc. El carácter ':' separa los turnos de ambos contendientes. En cada turno, se muestras tres números separados por el carácter '.'.
  * El primero de ellos será un '1' si fue un movimiento realizado por el jugador y un '2' si fue un movimiento realizado por la máquina.
  * El segundo será el número de la casilla en la que estaba la ficha antes del movimiento (será un '0' los tres primeros turnos, cuando las fichas aún se están colocando).
  * El tercero será la casilla en la que la ficha se ha colocado finalmente.

-----------------------------------------
---------- CAPÍTULO 5: MODO DE DOS JUGADORES ----------
-

* En un inicio se introdujo este modo como un mero "Easter Egg", pero finalmente se incluyó como una funcionalidad, aunque se mantuvo el método de desbloqueo. Para jugar PvP, el jugador deberá introducir como su nombre la cadena "DOSJUG". Si lo hace, el programa se ejecutará de forma convencional, pero tendrá la única diferencia de que en los turnos en los que normalmente movería la inteligencia articial también moverá el jugador.


