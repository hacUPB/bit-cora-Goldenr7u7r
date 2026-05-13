# Actividad 1

---

## 1. Programa en ensamblador (Hack ASM)

``` .js
// Dibuja un punto negro en la esquina superior izquierda de la pantalla
// La pantalla comienza en la dirección 16384 (SCREEN)
// El primer bit del primer word corresponde al pixel superior izquierdo

@16384
M=1            // Escribe 1 en el primer word de SCREEN

(END)
@END
0;JMP          // Bucle infinito para finalizar el programa
```

## 2. Traducción a C++

``` .js
// Dibuja un punto negro en la esquina superior izquierda de la pantalla
// SCREEN comienza en la dirección 16384
// Cada word representa 16 pixeles

int main() {

    short memory[32768] = {0};     // Simulación de la memoria del Hack
    const int SCREEN = 16384;      // Dirección base de la pantalla

    memory[SCREEN] = 1;            // Enciende el primer pixel

    while (true) { }               // Bucle infinito

    return 0;
}
```

## 3. Simulación paso a paso

#### Paso 1
- **Instrucción:** @16384
- **Predicción:** El registro A tomará el valor 16384.
- **Observación:** A = 16384.

#### Paso 2
- **Instrucción:** M=1
- **Predicción:** Se escribirá 1 en la dirección 16384.
- **Observación:** RAM[16384] = 1. Se enciende el pixel superior izquierdo.

#### Paso 3
- **Instrucción:** (END)
*Etiqueta que marca el final del programa.*

#### Paso 4
- **Instrucción:** @END
*El registro A toma la dirección de la etiqueta END.*

#### Paso 5
- **Instrucción:** 0;JMP
*Se realiza un salto incondicional a END, generando un bucle infinito.*
