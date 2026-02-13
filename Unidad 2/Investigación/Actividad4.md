# Actividad 4 

---

##  1. Análisis de equivalencia entre while y for

El programa original con while y el programa con for realizan exactamente la misma operación: calcular la suma de los números del 1 al 100.

Ambos programas:
- Inicializan las variables con i = 1 y sum = 0.
- Evalúan la condición i <= 100.
- Si la condición se cumple, ejecutan el cuerpo del ciclo.
- Dentro del ciclo suman el valor de i a sum.
- Incrementan i en 1.
- Terminan cuando i > 100.

Por lo tanto, ambos son equivalentes porque producen el mismo resultado final.

---

## 2. Conversión del ciclo for a ensamblador (Hack ASM)

``` .js
// Suma 1 + ... + 100 usando un ciclo for

@sum
M=0            // sum = 0 (inicialización de la suma)

@i
M=1            // i = 1 (inicialización del contador)

(FOR_COND)
@i
D=M            // D = i
@100
D=D-A          // D = i - 100
@FOR_END
D;JGT          // Si i > 100, termina el ciclo

@i
D=M            // D = i
@sum
M=M+D          // sum = sum + i

@i
M=M+1          // i = i + 1 (incremento)

@FOR_COND
0;JMP          // Volver a evaluar la condición

(FOR_END)
@FOR_END
0;JMP          // Bucle infinito para finalizar el programa
```
---

## 3. Comprobación en el simulador

Al ejecutar el programa en el simulador:

- El valor final de sum es 5050.
- El valor final de i es 101.

Esto confirma que el programa suma correctamente los números del 1 al 100.

---

## 4. Conclusiones

En lenguaje ensamblador no existe una diferencia real entre un ciclo while y un ciclo for. Ambos se traducen en:
- Inicialización de variables.
- Evaluación de una condición.
- Uso de saltos condicionales.
- Ejecución del cuerpo del ciclo.
- Incremento de la variable de control.
- Salto de regreso al inicio del ciclo.

La diferencia entre while y for es únicamente sintáctica en lenguajes de alto nivel. En ensamblador, la estructura generada es prácticamente la misma.
