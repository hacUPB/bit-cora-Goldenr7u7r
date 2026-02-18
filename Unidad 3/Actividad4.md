# Actividad 4: Experimentos

### Experimento 1: modificar el segmento de texto:

``` c++
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
