# Actividad 4

### Código 1

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/59337eaa-f8ee-4045-a978-76628f52d67e" />

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/49d48a98-f7af-4ce2-86b6-5df2be1c4571" />

#### ¿Qué sucede?

Primero, con las líneas comentadas, el programa compila y se ejecuta normal, no da ningún error.

Pero cuando descomenté estas líneas:

``` c++
ac.protectedVar = 20;
ac.privateVar = 30;
```

el programa ya no compila y Visual Studio muestra errores.

#### ¿Por qué sucede esto?

Pasa porque esas variables no tienen el mismo nivel de acceso.

`publicVar` sí se puede usar desde fuera de la clase, pero `protectedVar` y `privateVar` no.

En el caso de `protected`, solo se puede usar dentro de la clase o en clases que hereden de ella. Y `private` solo se puede usar dentro de la misma clase.

Como `main()` está fuera de la clase `AccessControl`, no tiene permiso para acceder a esas variables.

#### ¿Qué puedo concluir?

Puedo concluir que los modificadores de acceso sí controlan desde dónde se pueden usar las variables.

- `public` se puede usar en cualquier parte

- `protected` es más restringido

- `private` es aún más limitado

Entonces el encapsulamiento sirve para proteger los datos y evitar que cualquier parte del programa los modifique directamente.

### Código 2

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/d973c22d-4436-478d-89ca-5c0756548609" />

#### ¿Qué pasa?

Al intentar compilar el programa, aparece un error de compilación.

El error ocurre en esta línea:

``` c++
std::cout << obj.secret1 << std::endl;
```

#### ¿Por qué pasa?

Pasa porque `secret1` es una variable privada (`private`), entonces no se puede acceder directamente desde `main()`.

En cambio, el método `printMembers()` sí funciona, porque está dentro de la clase, y desde ahí sí se puede acceder a los datos privados.

#### ¿Qué puedo concluir?

Puedo concluir que aunque el objeto sí tiene esos datos guardados, el compilador no permite acceder a ellos directamente si son `private`.

Es decir, el encapsulamiento funciona en tiempo de compilación, porque el error aparece antes de que el programa se ejecute.

### Código 3

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/6e949b2c-2fae-43aa-9c3d-77262c49cd98" />

#### ¿Qué puedo concluir?

Puedo concluir que el encapsulamiento sí evita el acceso directo a los datos privados cuando uno escribe el código normal, pero no significa que esos datos estén “escondidos” de verdad en memoria.

Con `reinterpret_cast` el programa logra leer directamente lo que hay dentro del objeto, aunque esas variables sean `private`. O sea, en tiempo de ejecución sí se puede saltar esa restricción si uno accede a la memoria de forma directa.

Entonces entendí que el encapsulamiento se controla sobre todo en tiempo de compilación, no como una protección absoluta en memoria.

## En mis palabras, ¿qué es el encapsulamiento? ¿Por qué es importante?

Para mí, el encapsulamiento es una forma de controlar el acceso a los datos de un objeto.

Es importante porque evita que cualquier parte del programa cambie variables que no debería cambiar, y así ayuda a mantener el código más ordenado y más seguro.

También sirve para que los datos se manejen de una forma controlada, en vez de dejar todo abierto.
