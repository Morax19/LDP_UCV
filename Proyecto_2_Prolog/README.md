Parte 1:

Primero que nada nos dimos cuenta que el laberinto tiene una estructura de tipo grafo, una vez definida el tipo del laberinto,
para empezar definimos los siguientes predicados:

 lista_vacia([]): Comprueba que una lista este vacia, este predicado se usara en generar_laberinto().

 generar_laberinto(): Este predicado es un obligatorio y solicitado por el grupo docente, genera el laberinto asociado a esta ejecucion, usando el predicado lista_vacia para comprobar que los argumentes no sean vacios.

 validar_conexiones,validar_zombies,validar_suministros y validar_supervivientes: Predicados auxiliares que verifican que las estructuras recibidas esten correctas.

 Con estos predicados, Se completaria la primera parte.

 Parte 2:

Primero identificamos el caso base o cuando se detendra la recursividad, esta se detiene cuando existe una conexion donde se cumpla que el nodo donde se encuentra el superviviente unifique con el nodo final del laberinto, y este retornara en una lista ambos nodos.

camino_seguro: Es un predicado obligatorio solicitado por el grupo docente y este consta de dos partes la condicion de parada explicada anteriormente y su parte de recursividad. Esta comprueba donde se encuentra el superviviente y unifica con una variable Siguiente, comprobamos que en ese nodo "Siguiente" no exista un zombie, si no existe un zombie no unifica retorna false y al negarlo con el operador \+, nos aseguramos que en ese nodo no exista un zombie por lo tanto podemos continuar.

Parte 3:
Se ataco el problema utilizando la misma logica que en el apartado 2, con una pequeña variacion.

camino_con_suministro: Este predicado recive el nodo de inicio y el nombre del superviviente y el camino, con el nombre del superviviente podemos unificar para hallar el nodo en donde el se encuentra, para de esta manera tener el nodo Inicial, Final(posicion del superviviente) y Camino donde se guardara el recorrido del laberinto. 

camino_con_suministro_aux: Es un predicado auxiliar que es el encargado de realizar el backtracking de la logica principal,

contar_suministro: Este predicado lo usamos para guardar un valor con la cantidad de suministros en el laberinto, este valor es un entero.

camino_con_suminitro inicializa la estructura de las variables que se usaran para empezar el recorrido, llamando el predicado contar_suministro que guarda una de estas variables necesarias, una vez iniciado la busqueda con camino_con_suministro_aux primero se comprueba que en el nodo donde esta parado el superviviente exista un suministro en caso de que exista, a nuestra variable "ContSuministro" que contiene cuantos suministros hay se decrementa en 1, y se repite la logica comprobando que no exista un zombie en el siguiente nodo y llamamos al predicado de forma recursiva, guardando cuantos suministros quedan actualmente y el camino que llevamos recorrido. Finalizando con la condicion de parada cuando no existan suministros (la variable ContSuministros=0) y cuando el nodo donde me encuentro sea igual al nodo final (Inicio=Fin)