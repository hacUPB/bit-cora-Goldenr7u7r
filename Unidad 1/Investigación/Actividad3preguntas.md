# Experimento 3

- Predecir qué creo que va a suceder

@SCREEN

D=A

@i

M=D

(READKEYBOARD)

@KBD

D=M

@KEYPRESSED

D;JNE

@i

D=M

@SCREEN

D=D-A

@READKEYBOARD

D;JLE

@i

M=M-1

A=M

M=0

@READKEYBOARD

0;JMP

(KEYPRESSED)

@i

D=M

@KBD

D=D-A

@READKEYBOARD

D;JGE

@16

A=M

M=-1

@i

M=M+1

@READKEYBOARD

0;JMP

# Bitacora 3

- **Identifica una instrucción que use la ALU y explica qué hace.**

D=D-A ->    asigna a la variable D el valor del anterior valor de la variable D menos el valor asignado a la variable A (La ALU se encarga de realizar las operaciones lógico matemáticas)

- **¿Para qué sirve el registro PC?**

El registro PC (program counter) guarda la dirección de la siguiente instrucción que se va a ejecutar en la ROM

- **¿Cuál es la diferencia entre @i y @READKEYBOARD?**

@READKEYBOARD es una etiqueta que se creó para saltar a determinado punto del código, mientras que @i es una variable que se crea a necesidad

- **Describe qué se necesita para leer el teclado y mostrar información en la pantalla.**
 
 Para leer el teclado se usa @24576 (=@KBD) y para mostrar información en la pantalla se usa @16384 (=@SCREEN)

- **Identifica un bucle en el programa y explica su funcionamiento.**

(READKEYBOARD)      //Se crea la etiqueta (READKEYBOARD)

@KBD        //Se lee el teclado

D=M       // Si D=0,no hay teclas presionadas; si D≠0, hay teclas presionadas

@KEYPRESSED     

D;JNE       // Si hay una tecla presionada (D≠0), salta a esta dirección de memoria (KEYPRESSED).       De lo contrario (D=0), continua con el siguiente código

- **Identifica una condición en el programa y explica su funcionamiento.**

@READKEYBOARD

D;JGE       //Si D>=0, salta a esta dirección de memoria (READKEYBOARD), de lo contrario, continua con el siguiente código