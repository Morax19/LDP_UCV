/**
 * *Acá estaba definiendo lo que yo considero deben ser los predicados base, es decir:
 *
 * ! conectado debe unificar dadas 2 ubicaciones, si ambas son iguales debería fallar porque se
 * ! entiende ya que una posición del laberinto está conectada consigo misma. 

conectado(Begin,End):-
    Begin \= End.

 * ! zombie debe unificar dada cualquier posición, ya que se evalua primero que suministro() y superviviente(),
 * ! sin embargo, por validación agregué que es true si la posición dada no unifica para ningún suministro ni superviviente.

zombie(PositionZ):-
    \+ suministro(_, PositionZ),
    \+ superviviente(_, PositionZ).


 * ! suministro no debe unificar si ya hay un Zombie o un superviviente en la posicion dada

suministro(Name, PositionS):-
    \+ zombie(PositionS),
    \+ superviviente(_, PositionS).


 * ! superviviente no debe unificar si ya hay un zombie o un suministro en la posicion dada

superviviente(Name, PositionSp):-
    \+ suministro(_, PositionSp),
    \+ zombie(PositionSp).

    * * Toda esta sección está comentada porque al momento de evaluar "generar_laberinto()" obtuve el error: 
    * * "No permission to modify static procedure", ya que el "assert()" modifica los predicados definidos aca arriba
    * * Los predicados acá definidos funcionan por si solos pero no con "generar_laberinto" y viceversa.
*/

/**
 * ? La regla generar_laberinto tal cual está acá definida almacena en la base de conocimiento los valores dados,
 * ? el problema viene porque no valida nada, solo almacena, por tanto se tiene la respuesta true en casos inválidos.
 
 * ? Posible solución: En lugar de hacer el asserta, se debe guardar el resultado de evaluar los predicados y no 
 * ? el predicado en si, de esa forma no se modifican los predicados ya definidos.

 * ? Otra posible solución sería hacer las validaciones en generar_laberinto antes de hacer los asserta().

*/

generar_laberinto(Conexiones, Zombies, Suministros, Supervivientes):-
    length(Conexiones, LenC),
    LenC > 0,    
    forall(member([B, E], Conexiones), asserta(conectado(B, E))),
    length(Zombies, LenZ),
    LenZ > 0,
    forall(member(Z, Zombies), asserta(zombie(Z))),
    length(Suministros, LenS),
    LenS > 0,
    forall(member([S, P], Suministros), asserta(suministro(S, P))),
    length(Supervivientes, LenSp),
    LenSp > 0,
    forall(member([Sp, Sp_P], Supervivientes), asserta(superviviente(Sp, Sp_P))).