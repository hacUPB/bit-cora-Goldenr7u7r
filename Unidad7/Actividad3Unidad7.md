# Actividad 3

## Análisis del ejemplo del triángulo simple parte 1

### Primer "reporta en tu bitácora"

**Cambia los valores de bufferWidth y bufferHeight: divide por 2**

---

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/8b118ab9-9a8e-4e08-a05a-6b3e78159922" />

**Cambia los valores de bufferWidth y bufferHeight: divide por 4**

---

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/909b401e-5f51-4898-b5f0-f6b140c12905" />

**Cambia los valores de bufferWidth y bufferHeight: multiplica por 2**

---

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/3a2f96e4-4523-4925-8cf3-ad752502be46" />

**Cambia los valores de bufferWidth y bufferHeight: multiplica por 4**

---

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/9c6a8394-4bb6-4359-bca1-46639f2e817c" />

Probé cambiar los valores de `bufferWidth` y `bufferHeight` en `glViewport`. Al dividirlos entre 2 y entre 4, el triángulo se veía más pequeño y quedaba en una zona más reducida de la ventana.

Cuando multipliqué los valores por 2 y por 4, el triángulo casi no se veía o desaparecía, porque el área donde OpenGL intenta dibujar queda más grande que la ventana visible.

Al principio pensé que esto cambiaba el tamaño de la ventana, pero realmente no. Lo que cambia es el área interna donde OpenGL dibuja.

También noté que al agrandar la ventana el triángulo podía volver a aparecer, pero su tamaño no cambiaba tanto como esperaba, porque el triángulo no está hecho directamente en píxeles, sino en coordenadas que OpenGL adapta al viewport.

### Segundo  "reporta en tu bitácora"

Hasta ahora entendí que `GLFW` sirve para crear la ventana del programa y manejar eventos como teclado o mouse. Sin eso, OpenGL no tendría dónde mostrar lo que dibuja.

También entendí que OpenGL necesita un contexto, que es como el espacio donde guarda su estado y puede ejecutar sus funciones. Después está el framebuffer, que es donde OpenGL dibuja la imagen antes de mostrarla en pantalla.

El viewport es la parte del framebuffer donde se va a dibujar. Por eso, cuando cambio los valores de `glViewport`, no estoy cambiando la ventana, sino el área interna donde aparece el triángulo.

**Experimento: ¿qué pasaría si?**

- ¿Qué pasaría si cambio el tamaño del viewport y lo hago más pequeño que la ventana?

Creo que el triángulo se seguiría dibujando, pero solo dentro de una parte de la ventana. La ventana seguiría del mismo tamaño, pero el espacio visible donde OpenGL dibuja sería más pequeño. Esto sirve para comprobar que el viewport controla la zona de dibujo, no el tamaño real de la ventana.

### Tercer "reporta en tu bitácora"

**Cambiar el primer parámetro de glDrawArrays a GL_LINES**

---

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/c2bd533f-dc75-41b4-8784-77c6a02d6886" />

Cambié `GL_TRIANGLES` por `GL_LINES` y el triángulo dejó de verse como triángulo relleno. Ahora solo aparece una línea naranja.

Creo que pasa porque OpenGL ya no está leyendo los vértices como un triángulo, sino como líneas. Como hay 3 vértices, usa dos para formar una línea y el otro queda sobrando.

Entonces el primer parámetro de `glDrawArrays` cambia la forma en la que OpenGL interpreta los mismos vértices.

**Cambiar el primer parámetro de glDrawArrays a GL_POINTS**

---

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/3c1df9c3-df2c-4466-b5f1-01b470ade70f" />

Cambié `GL_TRIANGLES` por `GL_POINTS` y ya no se ve el triángulo ni una línea, sino tres punticos naranjas.

Creo que pasa porque OpenGL ahora interpreta cada vértice como un punto separado. Como el triángulo tenía 3 vértices, entonces dibuja 3 puntos.

**Cambiar el tercer parámetro de glDrawArrays a 2**

---

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/e9cff57b-5029-4e4d-9b33-8d1ef44f26f3" />

Cambié el tercer parámetro de `glDrawArrays` a 2 y el triángulo ya no se veía.

Creo que pasa porque ese tercer valor indica cuántos vértices va a usar OpenGL. Como estaba usando `GL_TRIANGLES`, necesita mínimo 3 vértices para formar un triángulo. Al darle solo 2, no alcanza a construir la figura, entonces no dibuja nada.

**Cambiar el tercer parámetro de glDrawArrays a 4**

---

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/a6c06134-13c1-477d-9331-a6838c0470c8" />

Cambié el tercer parámetro a 4 y el triángulo sí se vio, pero realmente mi figura solo tiene 3 vértices.

Pasa porque ese tercer parámetro le dice a OpenGL cuántos vértices debe leer. Como puse 4, OpenGL intenta leer un vértice extra que yo no definí. 

### Cuarto "reporta en tu bitácora"

  **1. ¿Qué es el contexto OpenGL?**

El contexto OpenGL es como el espacio de trabajo donde OpenGL guarda todo lo que necesita para funcionar. Ahí quedan guardadas configuraciones, estados, buffers, shaders y demás cosas que se usan para dibujar.

Sin contexto, OpenGL no tendría “dónde trabajar”.

  **2. ¿Cuál es el rol de GLFW y qué ventaja tiene usarla?**

GLFW sirve para crear la ventana, manejar eventos como teclado y mouse, y crear el contexto de OpenGL.

La ventaja es que nos evita tener que programar todo eso directamente para Windows. Además, como es multiplataforma, el mismo código puede funcionar también en otros sistemas con menos cambios.

  **3. ¿Por qué OpenGL necesita un contexto?**

OpenGL necesita un contexto porque necesita guardar el estado de lo que está haciendo. Usando la analogía del taller de arte, sería como tener una mesa de trabajo con las pinturas, pinceles, lienzos y herramientas listas.

Sin ese taller, el artista no tiene dónde pintar. En OpenGL pasa parecido: sin contexto, no hay un espacio preparado para dibujar.

  **4. ¿Qué es el framebuffer y a qué me recuerda?**

El framebuffer es una zona de memoria donde OpenGL dibuja la imagen antes de mostrarla en pantalla.

Me recuerda a las primeras unidades del curso porque vuelve a aparecer la idea de memoria como espacio donde se guarda información. Solo que aquí esa memoria guarda datos visuales, como los colores de los píxeles que luego se muestran en la ventana.

  **5. ¿Qué relación hay entre el viewport y el framebuffer?**

El framebuffer es donde está la imagen completa que OpenGL puede dibujar. El viewport es la zona del framebuffer que se usa para mostrar el dibujo.

Por eso, cuando cambio glViewport, no cambio la ventana como tal, sino el área interna donde OpenGL dibuja.

  **6. ¿Qué rol juegan los drivers de la GPU y la GPU?**

La GPU es la que realmente hace gran parte del trabajo gráfico. Es la encargada de procesar los datos y dibujar en pantalla.

Los drivers son como el puente entre el programa y la GPU. Gracias a ellos, OpenGL puede acceder a funciones modernas y comunicarse con la tarjeta gráfica.

  **7. ¿Por qué es necesario activar el VSync?**

El VSync sirve para sincronizar los cuadros que genera el programa con la frecuencia de actualización del monitor.

Si no se activa y la imagen es estática, probablemente no se note mucho. Pero si la imagen está en movimiento, puede aparecer un efecto raro como cortes en la imagen, porque el monitor puede mostrar partes de frames distintos al mismo tiempo.

  **8. ¿Qué es OpenGL Legacy y qué diferencia tiene con OpenGL moderno?**

OpenGL Legacy es la forma antigua de usar OpenGL. Era más directa y OpenGL hacía muchas cosas automáticamente.

En OpenGL moderno uno tiene que configurar más cosas manualmente, como shaders, VAO y VBO. Aunque parece más complicado, también da más control sobre cómo se dibuja todo.

  **9. ¿Qué es el shader program?**

El shader program es el programa que usa la GPU para saber cómo procesar y dibujar los vértices y los colores.

  **10. ¿Qué creo que hace setupTriangle()? ¿Qué son VAO y VBO?**

Intuitivamente, creo que setupTriangle() prepara todo lo necesario para dibujar el triángulo.

El VBO guarda los datos de los vértices en la GPU, como las posiciones del triángulo. El VAO guarda la configuración de cómo OpenGL debe leer esos datos.

En resumen: el VBO guarda los datos y el VAO guarda cómo interpretarlos.

  **11. ¿Es necesario usar el shader program y el VAO en cada frame?**

Si el programa solo dibuja un triángulo y no cambia nada, creo que no sería estrictamente necesario indicarlo en cada frame si ya quedó activo antes del loop.

Pero hacerlo dentro del game loop puede ser útil cuando hay varios objetos, varios shaders o varios VAO. Así uno se asegura de que OpenGL esté usando exactamente lo que necesita en ese momento.

  **12. ¿Qué hace glfwSwapBuffers(mainWindow) y por qué es importante?**

`glfwSwapBuffers(mainWindow)` muestra en pantalla lo que OpenGL acaba de dibujar.

Creo que es importante porque OpenGL normalmente dibuja en un buffer oculto y luego intercambia ese buffer con el que se ve en pantalla. Si no se llama, el programa puede estar dibujando, pero la imagen no se actualiza en la ventana.

En otras palabras, sería como pintar algo detrás de escena pero nunca mostrarlo al público.
