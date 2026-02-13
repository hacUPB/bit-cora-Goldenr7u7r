# Actividad 2 

### 1. Programa en ensamblador (Hack ASM)

``` .js
// Dibuja una línea horizontal negra de 16 pixeles en la esquina superior izquierda
// La pantalla comienza en la dirección 16384 (SCREEN)
// Un word (16 bits) representa 16 pixeles horizontales
// Para encender los 16 pixeles del primer word se escribe 1111111111111111 (binario) = -1 (en 16 bits)

@16384
M=-1           // Enciende los 16 pixeles del primer word (línea de 16 pixeles)

(END)
@END
0;JMP          // Bucle infinito para finalizar el programa
```

### 2. Traducción a C++

``` .js
// Dibuja una línea horizontal negra de 16 pixeles en la esquina superior izquierda
// SCREEN comienza en la dirección 16384
// Cada word representa 16 pixeles

int main() {

    short memory[32768] = {0};     // Simulación de la memoria del Hack
    const int SCREEN = 16384;      // Dirección base de la pantalla

    memory[SCREEN] = -1;           // 0xFFFF: enciende los 16 bits del primer word

    while (true) { }               // Bucle infinito

    return 0;
}
```

### 3. Simulación paso a paso (Predice – Ejecuta – Observa – Reflexiona)

#### Paso 1
- **Instrucción:** @16384
- **Predicción:** El registro A tomará el valor 16384.
- **Ejecución:** Se carga 16384 en A.
- **Observación:** A = 16384.
- **Reflexión:** Ahora M representa RAM[16384], el primer word de SCREEN.

#### Paso 2
- **Instrucción:** M=-1
- **Predicción:** Se escribirá -1 (1111111111111111) en RAM[16384] y se encenderán 16 pixeles seguidos.
- **Ejecución:** Se guarda -1 en RAM[16384].
- **Observación:** RAM[16384] = -1. En la pantalla aparece una línea horizontal negra de 16 pixeles en la esquina superior izquierda.
- **Reflexión:** Como un word tiene 16 bits, ponerlo en 1 en todos sus bits prende los 16 pixeles de ese bloque.

#### Paso 3
- **Instrucción:** (END)
- **Predicción:** Es una etiqueta, no ejecuta una operación.
- **Ejecución/Observación:** Se marca el final del programa.
- **Reflexión:** Se usa para hacer el salto infinito.

#### Paso 4
- **Instrucción:** @END
- **Predicción:** A tomará la dirección de la etiqueta END.
- **Ejecución:** Se carga la dirección de END en A.
- **Observación:** A = (dirección de END).
- **Reflexión:** Se prepara el salto incondicional.

#### Paso 5
- **Instrucción:** 0;JMP
- **Predicción:** El programa saltará indefinidamente a END.
- **Ejecución:** Salto incondicional a END.
- **Observación:** El programa queda en un bucle infinito.
- **Reflexión:** Esto “detiene” el programa para que no siga ejecutando otras posiciones de memoria.
