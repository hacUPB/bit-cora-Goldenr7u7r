# Actividad 7: Objetos en el heap: creación y observación

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/ac6cb8b2-11ad-45fe-b115-6eb3d0b259e4" />

**Breakpoint pStack**

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/5014c41a-d1bc-4443-8932-ffec6081f7e3" />

**Breakpoint pHead**

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/8704e4db-4bb0-4459-93fb-0783d4bdb354" />

**Ejecución total del código**

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/2ad1fc58-3704-4ff0-9663-0359ecaaacc8" />

##### Reflexión final

1. **Diferencia entre objetos creados en el stack y en el heap**

Un objeto creado en el stack se almacena directamente en la memoria automática de la función donde fue declarado. Su tiempo de vida depende del ámbito en el que se encuentra: cuando la función termina, el objeto se destruye automáticamente y se ejecuta su destructor.

En cambio, un objeto creado en el heap se almacena en memoria dinámica. Este tipo de objeto no se destruye automáticamente al finalizar la función, sino que debe liberarse manualmente utilizando delete. Si no se libera, se produce una fuga de memoria.

En resumen:

- Stack: memoria automática y destrucción automática.

- Heap: memoria dinámica y destrucción manual.

2. **pStack ¿Es un objeto o una referencia a un objeto?**

pStack es un objeto.

Se declara directamente como:

``` c++
Punto pStack(30, 40);
```

No es un puntero ni una referencia. Es la instancia real del objeto y sus atributos están almacenados directamente en esa ubicación de memoria.

**3. pHeap ¿Es un objeto o una referencia a un objeto?**

pHeap es un puntero, es decir, una referencia a un objeto.

Se declara así:

``` c++
Punto* pHeap = new Punto(50, 60);
```

Aquí, el objeto real se crea en el heap con new. La variable pHeap no contiene el objeto directamente, sino la dirección de memoria donde se encuentra almacenado ese objeto.

Por lo tanto, pHeap apunta al objeto creado dinámicamente en el heap.

4. **Observación en Memory1 y comparación con Locals**

Al escribir en la ventana Memory1 la dirección &pHeap, se observa el contenido de memoria donde está almacenado el puntero.

En esa dirección aparece un valor hexadecimal que coincide con la dirección almacenada en pHeap en la pestaña Locals.

Esto significa que:

- &pHeap es la dirección donde se guarda el puntero.

- El contenido almacenado en esa dirección es otra dirección, que corresponde al objeto en el heap.

- El puntero no contiene el objeto, sino la dirección del objeto.

En la pestaña Locals se observa que pHeap tiene una dirección específica. En Memory1, al inspeccionar &pHeap, aparece exactamente esa misma dirección como contenido. Esto confirma que un puntero es simplemente una variable que almacena una dirección de memoria.

**Conclusión**

Un objeto en el stack existe directamente en memoria automática y se destruye al salir del ámbito.

Un objeto en el heap vive en memoria dinámica y debe liberarse manualmente.

- pStack es el objeto real almacenado directamente en el stack.

- pHeap es un puntero que contiene la dirección de un objeto almacenado en el heap.

El análisis en el depurador confirma que los punteros almacenan direcciones de memoria y no el objeto en sí.
