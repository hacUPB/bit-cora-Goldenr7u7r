# Actividad 5

Programa 1 (C++ → ASM)

C++:
int a = 10;
int* p;
p = &a;
*p = 20;

``` .js
// Programa 1: a = 10; p = &a; *p = 20;

// a = 10
@10
D=A
@a
M=D

// p = &a  (guardar en p la DIRECCIÓN de a)
@a
D=A
@p
M=D

// *p = 20  (ir a la dirección guardada en p y escribir 20 ahí)
@20
D=A
@p
A=M
M=D

(END)
@END
0;JMP
```

## Simulación paso a paso (Predice – Ejecuta – Observa – Reflexiona)

#### Paso 1
- **Instrucción:** @10
- **Predice:** A tomará el valor 10.
- **Observa:** A = 10.
- **Reflexiona:** Se prepara el valor constante 10.

#### Paso 2
- **Instrucción:** D=A
- **Predice:** D quedará en 10.
- **Observa:** D = 10.
- **Reflexiona:** D almacena el valor que vamos a guardar en a.

#### Paso 3
- **Instrucción:** @a
- **Predice:** A tomará la dirección asociada al símbolo a.
- **Observa:** A = (dir de a).
- **Reflexiona:** El símbolo a representa una posición de RAM.

#### Paso 4
- **Instrucción:** M=D
- **Predice:** RAM[a] se vuelve 10.
- **Observa:** a = 10.
- **Reflexiona:** Ya se inicializó la variable a.

#### Paso 5
- **Instrucción:** @a
- **Predice:** A toma la dirección de a.
- **Observa:** A = (dir de a).
- **Reflexiona:** Vamos a guardar esta dirección dentro de p.

#### Paso 6
- **Instrucción:** D=A
- **Predice:** D quedará con la dirección de a.
- **Observa:** D = (dir de a).
- **Reflexiona:** Esto es equivalente a &a en C++.

#### Paso 7
- **Instrucción:** @p
- **Predice:** A toma la dirección del símbolo p.
- **Observa:** A = (dir de p).
- **Reflexiona:** p es una variable que guardará una dirección.

#### Paso 8
- **Instrucción:** M=D
- **Predice:** p guardará la dirección de a.
- **Observa:** p = (dir de a).
- **Reflexiona:** Ahora p “apunta a” a.

#### Paso 9
- **Instrucción:** @20 y D=A
- **Predice:** D quedará con el valor 20.
- **Observa:** D = 20.
- **Reflexiona:** Es el valor que queremos escribir en *p.

#### Paso 10
- **Instrucción:** @p
- **Predice:** A toma la dirección de p.
- **Observa:** A = (dir de p).
- **Reflexiona:** Para dereferenciar, primero leemos la dirección almacenada en p.

#### Paso 11
- **Instrucción:** A=M
- **Predice:** A cambiará a la dirección guardada en p (o sea, la dirección de a).
- **Observa:** A = (dir de a).
- **Reflexiona:** Esto simula *p (ir a donde apunta p).

#### Paso 12
- **Instrucción:** M=D
- **Predice:** RAM[dir de a] se vuelve 20, entonces a pasa a 20.
- **Observa:** a = 20.
- **Reflexiona:** Se modificó a a través del puntero, como en C++.
