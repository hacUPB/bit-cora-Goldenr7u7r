# Actividad 5: Copia de objetos y su ubicación en memoria

### Código en C++

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/cd16f562-e700-4acd-896c-1fea7b444c86" />

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/d5c35c38-ebd5-4339-8400-4f517079922a" />

---

**Ejecución**

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/492899a5-8535-4cd6-b459-086014d0a091" />

### Código en C#

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/af58737f-e50d-4228-a1f4-85fe3fa671eb" />

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/aa8a773c-0dc2-430d-8097-9a1ac21d9cee" />

---

**Ejecución**

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/3ef2df34-27b4-484c-b6c9-e74ff9c8cff5" />

#### Reflexión final

1. **¿Qué ocurre al copiar un objeto en C++ y en C#? ¿Qué diferencias encuentras?**

En C++, cuando se realiza la instrucción:

``` c++
Punto copia = original;
```
se crea un nuevo objeto en memoria que contiene una copia de los valores del objeto original. Es decir, se copian los atributos name, x y y al nuevo objeto. Esta copia es independiente del objeto original.

Por esta razón, cuando se modifican los valores de copia, el objeto original no se ve afectado. Ambos existen como objetos distintos en memoria.

En cambio, cuando se declara:

``` c++
Punto* p = &original;
``` 
no se crea un nuevo objeto, sino que p almacena la dirección de memoria de original. Por lo tanto, cualquier modificación realizada a través del puntero afecta directamente al objeto original, ya que ambos hacen referencia al mismo espacio en memoria.

En C#, cuando se realiza la instrucción:

``` c#
Punto copia = original;
```
no se crea un nuevo objeto. En C#, las clases son tipos por referencia, por lo que copia simplemente almacena la referencia al mismo objeto que original. Esto significa que ambos apuntan al mismo objeto en el heap.

Por esta razón, al modificar los valores de copia, también se modifican los valores de original, ya que no son objetos distintos, sino dos referencias al mismo objeto.

2. **¿Qué es copia en C++ y en C#? ¿Es una copia independiente de original?**

- En C++, copia es un nuevo objeto creado a partir del original. Es una copia independiente que ocupa un espacio diferente en memoria. Modificar copia no altera el objeto original.

- En C#, copia es una variable que contiene una referencia al mismo objeto que original. No es una copia independiente. Ambos nombres apuntan al mismo objeto en memoria, por lo que cualquier modificación afecta a los dos.

##### Conclusión

La principal diferencia observada es que en C++ la copia de un objeto genera una nueva instancia independiente (cuando se copia por valor), mientras que en C# la copia de una clase genera una nueva referencia al mismo objeto en memoria. Esto demuestra la diferencia fundamental entre tipos por valor y tipos por referencia en ambos lenguajes.
