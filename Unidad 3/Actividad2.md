``` .js

#include <iostream>
using namespace std;

// Función que modifica el parámetro pasado por valor

void modificarPorValor(int n) 
{
	cout << "Dentro de modificarPorValor, valor inicial: " << n << endl;
	n += 5;
	cout << "Dentro de modificarPorValor, valor modificado: " << n << endl;
}

// Función que modifica el parámetro pasado por referencia

void modificarPorReferencia(int& n) 
{
	cout << "Dentro de modificarPorReferencia, valor inicial: " << n << endl;
	n += 5;
	cout << "Dentro de modificarPorReferencia, valor modificado: " << n << endl;
}

// Función que modifica el parámetro utilizando punteros

void modificarPorPuntero(int* n) 
{
	cout << "Dentro de modificarPorPuntero, valor inicial: " << *n << endl;
	*n += 5;
	cout << "Dentro de modificarPorPuntero, valor modificado: " << *n << endl;
}

int main() 
{
	int a = 10;    
	int b = 10;    
	int c = 10;

	cout << "Valor inicial de a (paso por valor): " << a << endl;    
	cout << "Valor inicial de b (paso por referencia): " << b << endl;    
	cout << "Valor inicial de c (paso por puntero): " << c << endl;

	cout << "\nLlamando a modificarPorValor(a)..." << endl;    
	modificarPorValor(a);    cout << "Después de modificarPorValor, valor de a: " << a << endl;

	cout << "\nLlamando a modificarPorReferencia(b)..." << endl;  
	modificarPorReferencia(b);    
	cout << "Después de modificarPorReferencia, valor de b: " << b << endl;

	cout << "\nLlamando a modificarPorPuntero(&c)..." << endl;    
	modificarPorPuntero(&c);    
	cout << "Después de modificarPorPuntero, valor de c: " << c << endl;

	return 0;
}
```
---

### Paso por valor

``` .js
void modificarPorValor(int n)
```

##### ¿Qué ocurre aquí?

- Se crea una copia de la variable que se pasa.
- Los cambios afectan solo a la copia.
- La variable original NO se modifica.

---

### Paso por referencia

``` .js
void modificarPorReferencia(int& n)
```
##### ¿Qué significa el &?

- n es una referencia a la variable original.
- No se crea copia.
- Se trabaja directamente con la variable original.

---

### Paso por puntero

``` .js
void modificarPorPuntero(int* n)
```

##### ¿Qué es un puntero?

Un puntero guarda la dirección de memoria de una variable.

En main:

``` .js
modificarPorPuntero(&c);
```

- &c significa "la dirección de memoria de c".
- Dentro de la función usamos *n para acceder al valor.
