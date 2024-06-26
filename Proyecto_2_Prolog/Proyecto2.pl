%--------------------------------------------------------------------------------------------------------------------------------------------------------------

lista_vacia([]).

%--------------------------------       PARTE 1         -------------------------------------------------------------------------------------------------------

generar_laberinto(Conexiones, Zombies, Suministros, Supervivientes):-
%   Limipar base de conocimiento antes  de CUALQUIER iteración de generar_laberinto
    \+ (lista_vacia(Conexiones); lista_vacia(Zombies); lista_vacia(Suministros); lista_vacia(Supervivientes)),
    validar_conexiones(Conexiones),
    validar_zombies(Zombies),
    validar_suministros(Suministros),
    validar_supervivientes(Supervivientes).

validar_conexiones([]):- !.                                         %   Condición de parada.
validar_conexiones([H | T]):-                                       %   Recibe una lista de listas, que contienen las 2 posiciones a conectar.
    H = [H1 | T1],                                                  %   Sabemos entonces que H es una lista con H1 (elemento) y T1 (lista).
    T1 = [X | _],                                                   %   T1 es una lista tipo [b] asi que obtenemos el elemento y el resto no nos importa.
    H1 \= X, asserta(conectado(H1, X)),                             %   Se guarda en la base de conocimiento conectado(H1, X), si son diferentes.
    validar_conexiones(T).                                          %   Llamada recursiva con el siguiente elemento de la lista de listas.

validar_zombies([]):- !.                                            %   Condición de parada.
validar_zombies([H | T]):-                                          %   Recibe una lista de posiciones.
%   \+ (conectado(H, _); conectado(_, H)),                          %   Se valida que el elemento exista en el laberinto usando el predicado conectado().
    asserta(zombie(H)),                                             %   Se guarda en la base de conocimiento el predicado zombie(H).
    validar_zombies(T).                                             %   Llamada recursiva con el siguiente elemento de la lista.

validar_suministros([]):- !.                                        %   Condición de parada.
validar_suministros([H | T]):-                                      %   Recibe una lista de listas que contienen el nombre de un suministro y la posición.
    H = [H1 | T1],                                                  %   Se separa la lista, en H se tiene el nombre y T1 es una lista con la posición.
    T1 = [X | _],                                                   %   Se obtiene la posición del suministro.
    \+ zombie(X),                                                   %   Se valida que no exista un zombie en la posición obtenida.
    asserta(suministro(H1, X)),                                     %   Se guarda en la base de conocimiento el predicado suministro(H1, X).
    validar_suministros(T).                                         %   Llamada recursiva para el siguiente elemento de la lista de listas.

validar_supervivientes([]):- !.                                     %   Condición de parada.
validar_supervivientes([H | T]):-                                   %   Recibe una lista de listas, que contienen el nombre y posición de un superviviente.
    H = [H1 | T1],                                                  %   Sabemos que el primer elemento es una lista con el nombre del superviviente (H1).
    T1 = [X | _],                                                   %   T1 es una lista de la que obtendremos la posición del superviviente.
    \+ (zombie(X); suministro(_, X)),                               %   Se valida que no haya ni un zombie, ni un suministro en la posición 
    asserta(superviviente(H1, X)),                                  %   Se almacena en la base de conocimiento el predicado superviviente(H1, X).
    validar_supervivientes(T).                                      %   Llamada recursiva para el siguiente elemento en la lista de listas.

%---------------------------------      PARTE 2         -------------------------------------------------------------------------------------------------------

camino_seguro(Inicio, Fin, Camino):-                                %   Se recibe un vertice incio del grafo, un vertice fin y se guarda el camino.
    conectado(Inicio, Fin),                                         %   Se verifica si hay una conexión entre los vertices,
    \+ zombie(Fin),                                                 %   Caso base, el inicio está conectado con el fin.
    Camino = [Inicio, Fin], !.                                      %   Se almacena el camino.

camino_seguro(Inicio, Fin, [Inicio | Camino]):-                     %   Se reciben un vertice inicio (X) y de fin (Y), y una lista.
    conectado(Inicio, Siguiente),                                   %   Acá se hace el backtraking de Prolog con las conexiones de X.
    \+ zombie(Siguiente),                                           %   Se valida que en el vértice siguiente no hay zombie.
    camino_seguro(Siguiente, Fin, Camino).                          %   Llamada recursiva para el siguiente.

%-------------------------------        PARTE 3          -------------------------------------------------------------------------------------------------------


contar_suministro(Contador):-                                       %   Predicado que nos permite contar la cantidad de suministros
    findall(X, suministro(X, _), ListaSuministro),                  %   que existen en la base de conocimiento. Se retorna una 
    length(ListaSuministro, Contador).                              %   variable contador que unifica con la cantidad de suministros.

%---------------------------------------------------------------------------------------------------------------------------------------------------------------


camino_con_suministro_aux(X, X, 0, Camino):-                     %   Predicado auxiliar para realizar el backtracking                                                 %   Caso de parada, llegamos al nodo final
   Camino = [X], !.                                              %   Se retrona el camino para concatenar con los anteriores.

camino_con_suministro_aux(X, Fin, ContSuministro, [X | Camino]):-
    (suministro(_,X) -> ContAux is ContSuministro-1;ContAux is ContSuministro),
    conectado(X,Siguiente),
    \+ zombie(Siguiente),
    camino_con_suministro_aux(Siguiente,Fin,ContAux,Camino),!.
    
camino_con_suministro(Inicio, NombreSuperviviente, Camino):-
    superviviente(NombreSuperviviente, Fin),                            %   Obtener fin. Ya que la variable unifica con la posicion.
    contar_suministro(Contador),
    camino_con_suministro_aux(Inicio, Fin, Contador, Camino).
