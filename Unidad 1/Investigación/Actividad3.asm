@SCREEN     //@16384
D=A
@i
M=D

(READKEYBOARD)      //Etiquetas, sirve para saltar a este punto de código
@KBD        //@24576
D=M     //almacena en D la posición de la tecla presionada
@KEYPRESSED
D;JNE       //Si D no es igual a cero, salte a esta dirección de memoria (KEYPRESSED)
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