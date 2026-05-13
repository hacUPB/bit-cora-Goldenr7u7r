@5
D=M        // D = RAM[5]

@10
D=D-A      // D = RAM[5] - 10

@MENOR
D;JLT      // Si RAM[5] < 10, salta a MENOR

// Caso: RAM[5] >= 10
@7
M=0        // RAM[7] = 0
@FIN
0;JMP

(MENOR)
@7
M=1        // RAM[7] = 1

(FIN)
@FIN
0;JMP      // Bucle infinito (fin del programa)