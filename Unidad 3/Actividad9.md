 # Actividad 9: Objetos con miembros estáticos y variables de instancia

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/d9683472-a3a8-4917-981c-6a3a499288e5" />

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/a4b041c8-3c8c-4f28-ae08-828519550c11" />

**Ejecución del código**

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/262edaab-93f1-4612-a01a-cf53f32a3196" />

#### Reflexión final

1. **Conclusiones sobre miembros estáticos vs miembros de instancia en C++ (memoria, pros/cons, cuándo usarlos)**

En C++, un miembro de instancia (por ejemplo `valor`) pertenece a cada objeto por separado. Esto significa que cada instancia de `Contador` tiene su propia copia de `valor`, y su valor depende únicamente de las operaciones realizadas sobre ese objeto. En memoria, `valor` se almacena dentro del bloque de memoria del objeto (donde sea que viva el objeto: stack o heap).

En cambio, un miembro estático (por ejemplo `Contador::total`) pertenece a la clase, no a cada objeto. Existe una sola copia compartida por todas las instancias. Por eso, cada vez que se crea un nuevo `Contador`, el constructor incrementa `total` y todas las instancias “ven” el mismo valor. En memoria, `total` no está dentro de cada objeto; se almacena en un área global del programa (segmento de datos).

**Ventajas de miembros estáticos:**

+ Permiten compartir información entre todas las instancias (ej: contador de objetos creados).

+ No duplican datos por objeto (ahorran memoria si el dato es común).

+ Útiles para constantes, contadores globales de clase, configuraciones compartidas, factories, etc.

**Desventajas de miembros estáticos:**

+ Estado global compartido: puede causar errores si se modifica desde muchos lugares.

+ No es “por objeto”: no sirve si cada instancia necesita su propio estado.

+ En programas con múltiples hilos, puede requerir sincronización para evitar condiciones de carrera.

**Cuándo es útil:**

+ Cuando un dato debe ser compartido por todos los objetos (como total).

+ Para llevar estadísticas globales de la clase (cantidad de instancias, registros, etc.).

+ Para valores que conceptualmente pertenecen a la clase y no a un objeto específico.

2.  **¿En qué segmento de memoria están c1, c2, c3 y Contador::total?**

+ `c1` y `c2` son objetos creados directamente en `main()`:

     + Se almacenan en el stack (memoria automática), porque son variables locales.

+ `Contador::total` es un miembro estático:

     + Se almacena en el segmento de datos del programa (zona global: `.data` o `.bss` dependiendo de inicialización).

     + No está dentro de `c1`, `c2` ni `c3`.

+ `c3` requiere cuidado:

     + `c3` no es el **objeto**, `c3` es un **puntero** (una variable que guarda una dirección).

     + La variable `c3` (el puntero) está en el stack porque es una variable local de `main()`.

     + El objeto creado con `new Contador(15)` está en el **heap** (memoria dinámica), porque `new` reserva memoria dinámica.
