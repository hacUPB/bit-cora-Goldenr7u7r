# Actividad 3: Mapa de memoria de un programa escrito en C++

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/dae269fd-5262-41fc-a790-a4215f9286c1" />

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/7d1cd33d-e7fd-497e-bccf-d90f2fb004b1" />

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/e2f15a49-5d7a-411e-90c4-d972d15e1bda" />


| Tipo de variable                   | Variable                                                  |
| ---------------------------------- | --------------------------------------------------------- |
| Variables globales y estáticas     | global_inicializada, global_no_inicializada, var_estatica | 
| Heap                               | arr                                                       |
| Stack                              | a, b, c, tamArray, arrayHeap                              |

**Variables globales y estáticas**
``` c++
int global_inicializada = 42;
int global_no_inicializada;
static int var_estatica = 100;
```

**Heap**
``` c++
int* arr = new int[tam];
```

**Stack**
``` c++
int a = 10;
int b = 20;
int c = suma(a, b);
int tamArray = 10;
int* arrayHeap = crearArrayHeap(tamArray);
```

- La constante global:

``` c++
const char* const mensaje_ro = "Hola, memoria de solo lectura";
```

Se almacena en la sección **segmento de código**

**Explicación del mapa de memoria**

Las variables globales y estáticas se almacenan en el segmento de datos, ya que existen durante toda la ejecución del programa. La variable *global_inicializada* se ubica en la sección de datos inicializados, mientras que *global_no_inicializada* se ubica en la sección de datos no inicializados (.bss). La variable *var_estatica*, aunque esté dentro de una función, también se almacena en el segmento de datos porque tiene duración estática.

Las variables locales como *a*, *b*, *c*, *tamArray* y el puntero *arrayHeap* se almacenan en el stack, ya que solo existen mientras la función *main()* está en ejecución.

La memoria reservada con *new* (el arreglo *arr*) se almacena en el heap, que es la región destinada a memoria dinámica y debe liberarse manualmente con *delete*.

El literal *"Hola, memoria de solo lectura"* se almacena en la sección de solo lectura (.rodata), mientras que el puntero *mensaje_ro* se encuentra en el segmento de datos apuntando a esa dirección.

Las funciones del programa se almacenan en el segmento de código (text segment), donde se ubican las instrucciones ejecutables.
