# Actividad 4: Experimentos

### Experimento 1: modificar el segmento de texto:

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/fe87be08-b943-4380-a80e-7de328a9bf87" />

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/ee515a6b-e8cf-468b-badb-d58ca98048a3" />

- **¿Qué ocurre?**

Al ejecutar el programa se produce una excepción del tipo:

**0xC0000005 — Infracción de acceso (Access Violation)**

El error aparece cuando el programa intenta ejecutar la siguiente línea:

``` c++
*reinterpret_cast<int*>(ptr) = 0;
```

En ese momento el sistema detiene la ejecución porque se está intentando escribir en una dirección de memoria protegida.

- **¿Por qué ocurre?**

En el programa se obtiene la dirección de la función main mediante:

``` c++
void* ptr = reinterpret_cast<void*>(&main);
```

Las funciones del programa se almacenan en el segmento de código (text segment) de la memoria. Esta región contiene las instrucciones ejecutables compiladas.

El segmento de código tiene permisos de:

- Lectura

- Ejecución

Pero no permite escritura.

Cuando se realiza:

``` c++
*reinterpret_cast<int*>(ptr) = 0;
```

Se está forzando la dirección de la función *main* a comportarse como si fuera un puntero a entero y luego se intenta escribir un valor en esa dirección. Sin embargo, esa dirección pertenece a una región protegida del sistema.

El sistema operativo detecta el intento de escritura en una zona no autorizada y genera la excepción de infracción de acceso.

- **Conclusión**

La excepción se produce porque se intenta modificar una región de memoria protegida que corresponde al código ejecutable del programa. Esto confirma que el segmento de código solo permite lectura y ejecución, garantizando la integridad y seguridad del programa durante su ejecución.

### Experimento 2: modificar el segmento de datos (constante global):

<img width="1918" height="1079" alt="image" src="https://github.com/user-attachments/assets/058d9969-18bb-4d72-80b2-b372c212a231" />

- **¿Qué ocurre?**
  
El programa normalmente se cae (segmentation fault / access violation) al ejecutar *ptr = 0;. Si no se cae, el comportamiento sigue siendo indefinido e impredecible.

- **¿Por qué?**

mensaje_ro es const char* const, por lo que tanto el literal como el puntero global son constantes. Con (char*)&mensaje_ro se obtiene la dirección del puntero global, no del texto. Al hacer *ptr = 0; se intenta modificar memoria marcada como const, lo que viola las reglas del lenguaje y puede estar protegida como solo lectura por el sistema operativo. Esto produce comportamiento indefinido y, generalmente, un crash.

### Experimento 3: modificar el segmento de datos (variables globales):

``` .c++
#include <iostream>
#include <cstdlib>
using namespace std;
// Variables globales
int global_inicializada = 42;
int global_no_inicializada;

int main() {    // Variable local (stack)    
		int a = 10;    
		int b = 20;
    /**********************************************************        
    EXPERIMENTO 3    
    ***********************************************************/
    cout << "global_inicializada: " << global_inicializada << endl;    
    cout << "global_no_inicializada: " << global_no_inicializada << endl;

    global_inicializada = 69;    
    global_no_inicializada = 666;
    cout << "global_inicializada: " << global_inicializada << endl;    
    cout << "global_no_inicializada: " << global_no_inicializada << endl;
    /********************************************************/
    return 0;
    }
```

### Experimento 4: modificar la variable local estática de una función por fuera de ella:

``` .c++
#include <iostream>
#include <cstdlib>
using namespace std;
// Función de ejemplo que muestra la dirección de su variable local estática
void funcionConStatic() {    
		static int var_estatica = 100;    
		cout << "Dirección de var_estatica (static): " << &var_estatica << endl;
}

int main() {    // Variable local (stack)    
		int a = 10;    
		int b = 20;
    /**********************************************************        
    EXPERIMENTO 4    
    ***********************************************************/
    var_estatica = 42;
    cout << "var_estatica: " << var_estatica << endl;
    /********************************************************/    
    return 0;
    }
```

### Experimento 5: variables locales estática vs no estática:

``` .c++
#include <iostream>
#include <cstdlib>
using namespace std;
// Función de ejemplo que muestra la dirección de su variable local estática
void funcionConStatic() {    
		static int var_estatica = 100;    
		cout << "var_estatica: " << var_estatica << endl;    
		var_estatica++;
}
		
void funcionSinStatic() {    
		int var_no_estatica = 100;    
		cout << "var_no_estatica: " << var_no_estatica << endl;    
		var_no_estatica++;
}

int main() {    // Variable local (stack)    
		int a = 10;    
		int b = 20;
    /**********************************************************        
    EXPERIMENTO 5    
    ***********************************************************/
    for (int i = 0; i < 5; i++) {        
		    cout << "Iteración " << i << endl;        
		    funcionSinStatic();        
		    funcionConStatic();    
		}
    /********************************************************/
    return 0;
    }
```

### Experimento 6: modificar el segmento de heap:

``` .c++
#include <iostream>
using namespace std;
int main() {    // Tamaño del arreglo dinámico    
		int tam = 5;
    // Asignar memoria en el Heap para un arreglo de enteros    
    int* arrayHeap = new int[tam];
    // Inicializar y mostrar los valores y direcciones de memoria    
    for (int i = 0; i < tam; i++) {        
		    arrayHeap[i] = (i + 1) * 10;        
		    cout << "arrayHeap[" << i << "] = " << arrayHeap[i] << " en dirección " << (arrayHeap + i) << endl;    
		    }
    // Liberar la memoria asignada en el Heap    
    delete[] arrayHeap;
    /**********************************************************        
    EXPERIMENTO 6    
    ***********************************************************/
    cout << arrayHeap[0] << endl;

    /********************************************************/
    return 0;
    }
```
