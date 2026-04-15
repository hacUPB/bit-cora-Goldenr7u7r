# Actividad 8: Funciones y objetos en C++

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/41acc16a-ce6b-49b5-9b30-7962c05f35a3" />

**Ejecución del código**

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/49161529-8baa-449b-bdf9-6987aa2cff6e" />

##### Reflexión final

1. **¿Qué ocurre después de llamar a la función `cambiarNombre`? ¿Por qué aparece Destructor: `Punto cambiado(70, 80) destruido.`?**

Después de llamar a `cambiarNombre(original, "cambiado")`, el nombre que se modifica es el del parámetro `p` dentro de la función, no el del objeto `original`.

Esto ocurre porque la función está declarada así:

``` c++
void cambiarNombre(Punto p, string nuevoNombre)
```

Aquí `p` se pasa por valor, lo que significa que al entrar a la función se crea una copia del objeto `original`. Esa copia se llama `p`.

Dentro de la función se cambia el nombre de esa copia:

``` c++
p.name = nuevoNombre;
```

Cuando la función termina, la copia `p` sale de su ámbito y por eso se llama automáticamente su destructor. Esa es la razón por la que aparece el mensaje:

``` c++
Destructor: Punto cambiado(70, 80) destruido.
```

Es el destructor de la copia local `p`, no del objeto `original`.

2. **¿Por qué `original` sigue existiendo luego de llamar `cambiarNombre`?**

`original` sigue existiendo porque es un objeto creado en `main()` y su tiempo de vida depende del ámbito de `main()`. Como `main()` todavía no ha terminado, `original` sigue en memoria y no se destruye.

El objeto `original` solo se destruye al final de `main()`, cuando sale de su ámbito, y ahí aparece el mensaje:

`Destructor: Punto original(70, 80) destruido.`

3. **¿En qué parte del mapa de memoria se encuentra `original` y en qué parte se encuentra `p`? ¿Son el mismo objeto?**

- `original` es una variable local creada en `main()`, por lo tanto se encuentra en el stack.

- `p` (el parámetro de la función) también es una variable local dentro de `cambiarNombre`, así que también se encuentra en el stack.

Sin embargo, no son el mismo objeto.

Aunque ambos están en el stack, `p` es una copia independiente de `original`. Esto se evidencia porque:

- Se destruye `p` al salir de la función (`Destructor: Punto cambiado...`)

- `original` sigue existiendo y mantiene su nombre original después de la llamada.

#### Modificando la función `cambiarNombre`

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/02665839-c878-4eb1-88d1-c4763f6eaa32" />

1. **¿Qué ocurre ahora? ¿Por qué?**
   
Al modificar la función a:

``` c++
void cambiarNombre(Punto& p, string nuevoNombre) {
    p.name = nuevoNombre;
}
```

ahora el objeto `original` sí cambia su nombre a `"cambiado"` después de llamar a la función.

Esto ocurre porque el parámetro se está pasando por referencia (`Punto& p`). En este caso no se crea una copia del objeto, sino que `p` es un alias del objeto original. Por lo tanto, cualquier modificación realizada dentro de la función afecta directamente al objeto `original`.

Ya no se crea un objeto temporal ni se ejecuta un destructor intermedio, porque no existe una copia; solo hay un único objeto que se modifica directamente en memoria.

#### Modificando la función `cambiarNombre` y `main`

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/d370578a-ab4c-4a1a-a64d-28b6d11294e2" />

1. **¿Qué ocurre ahora? ¿Por qué?**

Ahora el objeto `original` sí cambia su nombre a `"cambiado"` después de llamar a la función.

Esto ocurre porque se está pasando un puntero al objeto (`&original`). El parámetro `p` contiene la dirección de memoria del objeto original, y al usar `p->name` se está modificando directamente ese objeto en memoria.

No se crea ninguna copia del objeto, por lo tanto no aparece ningún destructor intermedio. Solo existe un único objeto, que es el que se modifica directamente.

2. **¿Cuál es la diferencia entre pasar un objeto por valor, por referencia y por puntero?**

- **Paso por valor:** Se crea una copia del objeto. Las modificaciones dentro de la función afectan solo a la copia, no al objeto original. La copia se destruye al salir de la función.

- **Paso por referencia:** No se crea copia. El parámetro es un alias del objeto original. Las modificaciones dentro de la función afectan directamente al objeto original.

- **Paso por puntero:** Se pasa la dirección de memoria del objeto. La función trabaja con esa dirección y puede modificar el objeto original usando el operador `->`. Tampoco se crea copia.

En resumen, por valor se trabaja con una copia; por referencia y por puntero se trabaja directamente sobre el objeto original.
