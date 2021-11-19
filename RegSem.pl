
/************************************************************************
            GENERACIÓN DE CODIGO, REGLAS SEMANTICAS

  Este archivo debe tener al menos dos reglas:

       entorno_de_codigo.
       gencod(_).

   Use la regla entorno_de_codigo para inicializar todas sus estructuras
   por ejemplo:

        entorno_de_codigo:-
	      retractall(direccion(_)),
	      asserta(direccion(0)),
	      retractall(rdir(_)).

   Use la regla gencod(X) para realizar alguna acción. Lo que se
   recibirá en la variable X, es la producción que acaba de utilizar
   el parser LL en ese momento, o el pop para el terminal T que se ha
   sacado de la pila, entonces recibirá:

                  - p(n)
                  - pop(t(T))

   donde n es el número de la producción y T el terminal.

   Para el parser LR la variable X en gencod(X) en lugar de recibir
   pop(t(T)) o p(n) recibe la accion del parser, es decir:

                  - shift(n)
		  - goto(n)
		  - reduce(n)

   En ambos parsers es posible obtener el token con el que se está
   trabajando en el momento que ocurre una acción, en el parser se usa
   la estructura:

                  - token(TOKEN,LEXEMA,RENGLON,COLUMNA)

   TOKEN siempre tiene la forma t(<token>), LEXEMA contiene el lexema
   para el token, y RENGLON y COLUMNA la posición donde se encontró en
   el programa fuente. Ejemplo:

       token(t(id),'suma',12,3).
       token(t(opar),'+',12,7).
       token(t(num),'3.14159268',15,23).
       token(t(if),'if',16,1).

   También es posible en ambos parser sobtener la produccion usada por
   medio de n (p(n) en el LL y reduce(n) en el LR), con n se puede
   consultar la estructura produccion(N,PI,PD), donde N es el número de
   la producción PI es la parte izquierda y PD una lista con los
   elementos de la parte derecha. Ejemplo:

       produccion(3,'E',[nt('E'),t(+),nt('T')]).
       produccion(4,'E',[nt('E'),t(-),nt('T')]).
       produccion(5,'T',[t(num)]).
       produccion(6,'T',[epsilon]).

   Ejemplo para generar el código cuando se realiza un shift(9):

        gencod(shift(9)):-
	      token(_,LEXEMA,_,_),
	      sym(LEXEMA,DIR),
	      asserta(ldir(DIR)),!.


   ARCHIVO DE SALIDA CON EL CODIGO GENERADO

   La responsabilidad de escribir el código generado a un archivo de
   salida es del usuario, debe escribir las reglas para producir un
   archivo de salida. Mediante:

         arch_sal(X)

   puede obtener en la variable X el nombre del archivo de salida que
   introdujo el usuario en el programa de parser, todo lo necesario
   para generarlo corresponde al usuario.

*************************************************************************/

entorno_de_codigo.

gencod(_).

