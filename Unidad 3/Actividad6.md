# Actividad 6: Hola Objeto: creación de un objeto en el stack

### Código en C++

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/e8762e7e-4c09-4c7b-8df4-b6f44b2529c2" />

**Ejecución**

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/54015fca-92af-4a66-a76d-a229c474a6d8" />

### Código en C#

**Ejecución**

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/30e8a31d-2cbc-4b9d-b127-2e4b18cd6302" />

##### Reflexión final

1. **¿Cuál es la diferencia entre un constructor y un destructor en C++?**

El constructor es un método especial que se ejecuta automáticamente cuando se crea un objeto. Su función es inicializar los atributos del objeto y preparar su estado inicial.

El destructor es un método especial que se ejecuta automáticamente cuando el objeto deja de existir. Su función es liberar recursos o realizar tareas finales antes de que el objeto sea eliminado de memoria.

En el experimento se observa que el constructor se ejecuta al crear el objeto *Punto(10, 20)* y el destructor se ejecuta cuando el programa termina y el objeto sale de su ámbito.

2. **¿Cuál es la diferencia entre un objeto y una clase en C++?**

Una clase es una plantilla o definición que describe cómo será un tipo de objeto. Define sus atributos y métodos.

Un objeto es una instancia concreta de esa clase. Es decir, es una entidad real en memoria creada a partir de la clase.

La clase define la estructura; el objeto ocupa espacio en memoria y contiene valores específicos.

3. **¿Qué diferencia notas entre el objeto Punto en C++ y en C#?**

En C++ el objeto *Punto p(10, 20)*; se crea directamente como una variable local. En este caso, el objeto se almacena en el stack, ya que es una variable automática dentro de *main()*.

En C#, el objeto se crea con:

``` c#
Punto p = new Punto(10, 20);
```

Aquí el objeto se almacena en el heap, y la variable p contiene una referencia a ese objeto.

La diferencia principal es que en C++ el objeto puede vivir directamente en el stack, mientras que en C# los objetos de clase siempre se almacenan en el heap.

4. **¿Qué es p en C++ y qué es p en C#?**

En C++:

``` c++
Punto p(10, 20);
```

p es el objeto en sí mismo. Es una instancia real almacenada en memoria (en este caso, en el stack).

En C#:

``` c#
Punto p = new Punto(10, 20);
```

p no es el objeto directamente. Es una referencia que apunta a un objeto almacenado en el heap.

Por lo tanto:

- En C++ → p es el objeto.

- En C# → p es una referencia a un objeto.

5. **¿En qué parte de memoria se almacena p en C++ y en C#?**

En C++:

+ El objeto p se almacena en el stack (porque es una variable local dentro de main()).

En C#:

+ La variable p (la referencia) se almacena en el stack.

+ El objeto Punto se almacena en el heap.

6. **¿Qué observaste con el depurador acerca de p? ¿Qué es un objeto en C++?**

En el depurador de C++ se puede observar que p tiene una dirección de memoria propia y contiene directamente los valores x e y. Esto indica que el objeto existe físicamente en esa ubicación de memoria.

En C#, el depurador muestra que p contiene una referencia (una dirección) que apunta a un objeto en el heap.

Según lo observado, un objeto en C++ es una estructura real en memoria que contiene directamente sus atributos y ocupa espacio propio. No es simplemente una referencia, sino una instancia concreta almacenada en una región específica de memoria.
