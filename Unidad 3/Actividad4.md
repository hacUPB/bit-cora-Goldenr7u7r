# Actividad 4: Experimentos

### Experimento 1: modificar el segmento de texto:

``` .c++
#include <iostream>
#include <cstdlib>
using namespace std;

int main()
    {    
		// Variable local (stack)    
		int a = 10;    
		int b = 20;
    /**********************************************************        
    EXPERIMENTO 1    
    ***********************************************************/
    void* ptr = reinterpret_cast<void*>(&main);    
    cout << "Voy a modificar la memoria en la dirección: " << ptr << endl;    
    *reinterpret_cast<int*>(ptr) = 0;
    /********************************************************/
    return 0;
    }
```
- **¿Qué ocurre?**
  
Al ejecutar el programa, lo más común es que se produzca un crash justo cuando intenta hacer:
*reinterpret_cast<int*>(ptr) = 0;
En algunos casos raros puede no fallar de inmediato, pero aun así el resultado es impredecible.

- **¿Por qué?**
  
Porque ptr apunta a la dirección de main, es decir, al segmento de código (text segment) donde están las instrucciones del programa. En sistemas modernos ese segmento suele estar protegido como solo lectura y ejecutable (RX), por lo que no se permite escribir ahí. Al intentar escribir, el sistema operativo bloquea la operación y termina el programa.

- Además, en C++ convertir un puntero a función (&main) a void* y luego tratarlo como int* para escribir en esa dirección implica comportamiento indefinido (no está garantizado por el estándar), así que aunque “parezca funcionar” en alguna máquina, no es portable ni seguro.
  
### Experimento 2: modificar el segmento de datos (constante global):

``` .c++
#include <iostream>
#include <cstdlib>
using namespace std;
// Constante global
const char* const mensaje_ro = "Hola, memoria de solo lectura";

int main() {    
		// Variable local (stack)    
		int a = 10;    
		int b = 20;

    /**********************************************************        
    EXPERIMENTO 2    
    ***********************************************************/
    char* ptr = (char*)&mensaje_ro;    
    cout << "Voy a modificar la memoria en la dirección: " << ptr << endl;    
    *ptr = 0;
    /********************************************************/
    return 0;
    }
```

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
