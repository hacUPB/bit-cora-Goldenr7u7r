# Actividad 3 

## 1. Programa en ensamblador (Hack ASM)

``` .js
// Mueve una línea horizontal de 16 pixeles (1 word) a izquierda/derecha usando teclado
// SCREEN = 16384, KEYBOARD = 24576
// Teclas (ASCII): 'd' = 100 (derecha), 'i' = 105 (izquierda), 'e' = 101 (sin mover)
// La línea se mueve por WORDS (saltos de 16 pixeles). No se verifica si se sale de la pantalla.

@SCREEN
D=A
@pos
M=D            // pos = SCREEN (posición inicial)

@pos
A=M
M=-1           // Dibuja la línea inicial (16 pixeles)

(LOOP)
@pos
A=M
M=0            // Borra la línea en la posición actual

@24576
D=M            // D = KEYBOARD (0 si no hay tecla)

@100
D=D-A
@MOVE_RIGHT
D;JEQ          // Si tecla == 'd' -> mover derecha

@24576
D=M
@105
D=D-A
@MOVE_LEFT
D;JEQ          // Si tecla == 'i' -> mover izquierda

@24576
D=M
@101
D=D-A
@DRAW
D;JEQ          // Si tecla == 'e' -> no mover, solo dibujar

// Si no se presiona 'd', 'i' o 'e', se queda en la misma posición y dibuja
@DRAW
0;JMP

(MOVE_RIGHT)
@pos
M=M+1          // pos = pos + 1 (mueve 16 pixeles a la derecha)
@DRAW
0;JMP

(MOVE_LEFT)
@pos
M=M-1          // pos = pos - 1 (mueve 16 pixeles a la izquierda)
@DRAW
0;JMP

(DRAW)
@pos
A=M
M=-1           // Dibuja la línea en la nueva (o misma) posición

@LOOP
0;JMP          // Repite el ciclo
```

## 2. Traducción a C++ (equivalente de alto nivel)

``` .js
// Mueve una línea horizontal de 16 pixeles usando teclado
// d: derecha, i: izquierda, e: no mover

#include <iostream>
using namespace std;

int main() {

    short memory[32768] = {0};
    const int SCREEN = 16384;

    int pos = SCREEN;          // Posición (word) actual dentro de SCREEN
    memory[pos] = -1;          // Dibuja la línea inicial

    while (true) {
        memory[pos] = 0;       // Borra la línea actual

        char key;
        cin >> key;            // Simulación de teclado (en Hack sería KEYBOARD)

        if (key == 'd') pos = pos + 1;
        else if (key == 'i') pos = pos - 1;
        else if (key == 'e') pos = pos; // No mover

        memory[pos] = -1;      // Dibuja la línea en la posición actualizada
    }

    return 0;
}
```

## 3. Simulación paso a paso (Predice – Ejecuta – Observa – Reflexiona)

### Inicialización

#### Paso 1
- **Instrucción:** @SCREEN, D=A, @pos, M=D
- **Predicción:** pos quedará apuntando a 16384.
- **Observación:** pos = 16384.
- **Reflexión:** pos guarda la dirección del word de pantalla donde está la línea.

#### Paso 2
- **Instrucción:** @pos, A=M, M=-1
- **Predicción:** Se dibuja una línea de 16 pixeles en la esquina superior izquierda.
- **Observación:** RAM[16384] = -1.
- **Reflexión:** -1 equivale a 1111111111111111, encendiendo 16 pixeles.

### Ciclo principal (una iteración)

#### Paso 3
- **Instrucción:** @pos, A=M, M=0
- **Predicción:** Se borra la línea de la posición actual.
- **Observación:** RAM[pos] = 0.
- **Reflexión:** Se limpia antes de redibujar para que no queden “rastros”.

#### Paso 4
- **Instrucción:** @24576, D=M
- **Predicción:** D tendrá el código de la tecla presionada (o 0 si nada).
- **Observación:** D = KEYBOARD.
- **Reflexión:** KEYBOARD entrega el código ASCII de la tecla.

#### Paso 5 (caso ejemplo: se presiona ‘d’)
- **Instrucciones:** comparación con 100 y salto a MOVE_RIGHT
- **Predicción:** Si la tecla es ‘d’, se ejecuta pos = pos + 1.
- **Observación:** pos aumenta en 1.
- **Reflexión:** Cambiar el word de SCREEN mueve la línea 16 pixeles a la derecha.

#### Paso 6
- **Instrucción:** @pos, A=M, M=-1
- **Predicción:** Se dibuja la línea en la nueva posición.
- **Observación:** RAM[pos] = -1.
- **Reflexión:** La línea aparece desplazada.

#### Paso 7
- **Instrucción:** @LOOP, 0;JMP
- **Predicción:** El programa repite indefinidamente.
- **Observación:** Se reinicia el ciclo.
- **Reflexión:** Se mantiene interactivo continuamente.
