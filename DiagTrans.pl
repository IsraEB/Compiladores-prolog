
/*

MODO DE CODIFICACION


     l          +
0 -------> 1 --------> 2 r(x)
           |
           |    o
	    ---------> 3 r(y)*

	                         _ a
		                | |
     /           /	   a    V /  o
4 -------> 5 --------> 6 ------> 7------> 8 r(omite)*


t(0,l,1).                 Transición de 0 con letra a 1
t(1,'+',2).		  Transición de 1 con + a 2
t(1,o,3).		  Transición de 1 con otro a 3
t(4,'/',5).		  Transición de 4 con / a 5
t(5,'/',6).		  Transición de 5 con / a 6
t(6,a,7).		  Transición de 6 con any a 7
t(7,a,7).		  Transición de 7 con any a 7
t(7,o,8).		  Transición de 7 con otro a 8

a(2,n,t(x)).              Estado de aceptación normal token x.
a(3,a,t(y)).              Estado de aceptación asterisco token y.
a(8,a,omite).             Estado de aceptación asterisco token omite.

pr('si',a).               Palabra reservada any case
pr('For',m).              Palabra reservada match case

token(t(id),u).           Token id debe venir en mayusculas

cambio_diagrama(0,4).	  No pasa por el diagrama 0, cambia al 4

COSIDERACIONES DE LAS TRANSICIONES

 l -  Significa cualquier letra mayúscula o minúscula.
 d -  Significa cualquier dígito del 0 al 9.
 m -  Significa cualquier letra minúscula.
 y -  Significa cualquier letra mayúscula.
 o -  Significa cualquier otro caracter.
 a -  "any" significa cualquier caracter excepto nueva línea \n.
'a' - significa el caracter a en específico.

CONSIDERACIONES DE LOS ESTADOS DE ACEPTACION

 n - Significa que el estado es normal, no sale por otro y
     por lo tanto no tiene asterisco

 a - Significa que el estado sale por otro y tiene asterisco

 El caso particular del token 'omite', quiere decir que el token no
 interesa y no se escribe en el archivo de salida, esto se usa para los
 delimitadores (espacio, tab, newline) y también es útil para desechar
 los comentarios.

CONSIDERACIONES DE LAS PALABRAS RESERVADAS

  Sólo que se encuentre un token id, se compara contra la lista
  de palabras reservadas:

     pr('si',a).       Si se codifica 'a' (any case) se asume que
                       el token devuelto es 'si' para el
		       lexema escrito en cualquier caso o
		       combinacion: SI, si, Si, sI.
     pr('Si',m).       Si se codifica 'm' (match) el lexema debe
                       coincidir exactamente con 'Si'.

   Si el lexema id no se asocia con ninguna palabra reservada ya sea
   codificada con a o m, entonces se asume que en efecto es un token id,
   y se pasa a validar si se espera que el token id deba venir en
   minúsculas (l), mayúsculas(u) o en cualquier combinación (a).

   Por ello siempre debe existir una codificación como:

   token(t(id),u).

   Donde el segundo argumento puede ser u (upper case), l (lower case) o
   a (any case). Si el token no concuerda con lo declarado, se manda un
   error lexicográfico.


   GENERACION DEL ARCHIVO DE SALIDA

 Si no hay error lexicográfico, el analizador guarda en el archivo de
 salida una estructura estandar que contiene el token encontrado según
 el diagrama, el lexema que corresponde con el token, el renglón y la
 columna del archivo fuente donde se encontró el token. La estructura
 estandar es:

       cadena(t(token),'lexema',renglon,columna).

    Por ejemplo:

       cadena(t(dat), 'Dat', 1, 1).
       cadena(t(id), 'A', 1, 5).
       cadena(t(;), ;, 1, 6).
       cadena(t(id), 'X1', 4, 5).
       cadena(t(asig), <-, 13, 6).
       cadena(t(num), '0.7071', 13, 9).
       cadena(fin,nulo,0,0).

 Sin embargo, si el usuario sabe programar en prolog, puede agregar las
 reglas que requiera para generar una salida diferente, consultando
 la estructura cadena(t(token),'lexema',renglon,columna) que crea el
 analizador léxico durante su ejecución.

 Para que se genere la estructura estándar mencionada arriba se debe
 codificar una sola vez la siguiente regla:

      salida(estandar).

 Si el usuario desea una salida distinta personalizada, en lugar de la
 regla de arriba, el usuario debe programar su propia regla sustituyendo
 la regla de arriba por:

      salida(FILE):-
          (codificar aqui lo requerido)

 En la variable FILE se recibirá el archivo que se proporcionó como
 salida, para que se manipule a conveniencia la estructura estandar
 cadena(t(token),'lexema',renglon,columna).

 La regla salida(FILE) puede invocar a tantas reglas como el usuario
 quiera crear.

EJEMPLO DE DIAGRAMAS DE TRANSICION Y CODIFICACION:


	  _ l o d
         | |
    l	 V /      _
0 ----->  1  -----------> 2
        | ^ ^	        | |
        | | |     l     | |
        | |  -----------  |
        | |		  |
        | |       d       |
        |  ---------------
        |
        |     otro
         -------------> 3 r(id)*



	 _ d		    _ d
        | |		   | |
    d	V /   .        d   V /
4 -----> 5 ------> 6 -----> 7
         |		    |
         |	       otro |
         |		    |
         |	otro	    V
          ----------------> 8 r(num)*



    >		             =
9 -----> 10 --------------------------------> 11 r(mai)
|        |                                    ^
|        |   otro                             |
|         ---------> 12 r(>)*                 |
|                                             |
|                                             |
|   <         -                               |
|------> 13 -----> 14 r(asig)                 |
|	 |                                    |
|	 |        =		            > |
|        |------------------> 15 r(mei)       |
|	 |                    ^               |
|	 |  otro	      |               |
|	  --------> 16 r(<)*  |               |
|                             |	              |
|                             |               |
|   =                 <       |               |
 ------> 17 ------------------                |
	 |                                    |
	 |------------------------------------
	 |
	 |   |          =
	 |------> 18 ------> 19 r(dif)
	 |
	 |        otro
	  -----------------> 20 r(=)*




	       _ delim
              | |
     delim    V /    otro
21 ---------> 22 -----------> 23 r(omite)*



                             _ any
			    | |
       "            any     V /	   "
24 ---------> 25 ---------> 26 ----------> 27 r(cad)


	  +
28 --------------> 29 r(+)
  |
  |       -
   --------------> 30 r(-)
  |
  |       *
   --------------> 31 r(*)            _ any
  |                                  | |
  |	  /                 /        V /   otro
   --------------> 32 -------------> 45 ----------> 46 r(omite)*
  |                 |
  |                 |
  |                 |     otro
  |                  --------------> 47 r(/)*
  |
  |       ;
   --------------> 33 r(;)
  |
  |       (
   --------------> 34 r(()
  |
  |	  )
   --------------> 35 r())
  |
  |       [
   --------------> 36 r([)
  |
  |       ]
   --------------> 37 r(])
  |
  |       ^
   --------------> 38 r(^)
  |
  |	  |
   --------------> 39 r(|)
  |
  |	  ¬
   --------------> 40 r(¬)
  |
  |	  .
   --------------> 41 r(.)



*/

token(t(id),u).          % u (Upper case), l (Lower case), a (Any case)

pr('si',a).              % a (Any case), m (Match case)
pr('dat',a).
pr('finsi',a).
pr('mientras',a).
pr('finm',a).

t(0,l,1).
t(1,l,1).
t(1,d,1).
t(1,'_',2).
t(1,o,3).
t(2,l,1).
t(2,d,1).
t(4,d,5).
t(5,d,5).
t(5,'.',6).
t(5,o,8).
t(6,d,7).
t(7,d,7).
t(7,o,8).
t(9,'>',10).
t(9,'<',13).
t(9,'=',17).
t(10,'=',11).
t(10,o,12).
t(13,'-',14).
t(13,'=',15).
t(13,o,16).
t(17,'<',15).
t(17,'>',11).
t(17,'|',18).
t(17,o,20).
t(18,'=',19).
t(21,' ',22).
t(21,'\t',22).
t(21,'\n',22).
t(22,' ',22).
t(22,'\t',22).
t(22,'\n',22).
t(22,o,23).
t(24,'"',25).
t(25,a,26).
t(26,'"',27).
t(26,a,26).
t(28,'+',29).
t(28,'-',30).
t(28,'*',31).
t(28,'/',32).
t(32,'/',45).
t(32,o,47).
t(45,a,45).
t(45,o,46).
t(28,';',33).
t(28,'(',34).
t(28,')',35).
t(28,'[',36).
t(28,']',37).
t(28,'^',38).
t(28,'|',39).
t(28,'¬',40).
t(28,'.',41).

a(3,a,t(id)).
a(8,a,t(num)).
a(11,n,t(mai)).
a(12,a,t(>)).
a(14,n,t(asig)).
a(15,n,t(mei)).
a(16,a,t(<)).
a(19,n,t(dif)).
a(20,a,t(=)).
a(23,a,omite).
a(27,n,t(cad)).
a(29,n,t(+)).
a(30,n,t(-)).
a(31,n,t(*)).
a(46,a,omite).
a(47,a,token(/)).
a(33,n,t(';')).
a(34,n,t('(')).
a(35,n,t(')')).
a(36,n,t('[')).
a(37,n,t(']')).
a(38,n,t('^')).
a(39,n,t('|')).
a(40,n,t('¬')).
a(41,n,t('.')).

cambio_diagrama(0,4).
cambio_diagrama(4,9).
cambio_diagrama(9,21).
cambio_diagrama(21,24).
cambio_diagrama(24,28).

salida(estandar).

