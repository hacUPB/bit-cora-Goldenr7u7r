# Actividad 04

## Análisis del ejemplo del triángulo simple parte 2

### Primer "reporta en tu bitácora"

**Diferencia entre CPU y GPU**

La CPU se encarga de ejecutar la lógica general del programa y coordinar lo que pasa en el computador.

La GPU, en cambio, está más enfocada en procesar gráficos y hacer muchos cálculos visuales al mismo tiempo, como posiciones, colores y píxeles.

### Segundo "reporta en tu bitácora"

1. ¿Cuáles son los tres pasos claves del pipeline de OpenGL? Explica en tus propias palabras cuál es el objetivo de cada paso.

Los tres pasos principales son vertex shading, rasterization y fragment shading.

- En el vertex shading, la GPU toma los vértices del objeto y calcula dónde van a quedar en la escena y en la pantalla. Ahí se tienen en cuenta cosas como posición, escala, rotación, cámara y profundidad.

- En la rasterización, OpenGL convierte las figuras, como triángulos, en fragmentos que pueden ocupar píxeles en pantalla.

- En el fragment shading, se calcula cómo se va a ver cada fragmento: color, textura, iluminación y otros detalles visuales.

2. La gran novedad que introduce OpenGL moderno es el pipeline programable. ¿Qué significa esto? ¿Qué diferencia hay entre el pipeline fijo y el programable? ¿Qué ventajas le ves a esto? y si el pipeline es programable, ¿Qué tengo que programar?

Que el pipeline sea programable significa que en OpenGL moderno uno puede escribir código para controlar partes del proceso, especialmente con shaders.

En el pipeline fijo, muchas cosas ya venían hechas por OpenGL. En el programable, uno decide cómo transformar los vértices y cómo colorear los fragmentos.

La ventaja es que se tiene más control sobre el resultado visual. Lo que se programa principalmente es el vertex shader y el fragment shader.

3. Si fueras a describir el proceso de rasterización ¿Qué dirías?

La rasterización es el proceso donde una figura 3D, normalmente formada por triángulos, se convierte en fragmentos que pueden terminar siendo píxeles en pantalla.

O sea, OpenGL pasa de tener una figura definida por vértices a saber qué partes de la pantalla debe pintar.

4. ¿Qué son los fragmentos? ¿Es lo mismo un fragmento que un pixel? ¿Por qué?

Un fragmento no es exactamente lo mismo que un píxel. Un fragmento es como un posible píxel antes de pasar todas las pruebas.

Puede tener información de color, profundidad y textura, pero todavía puede descartarse si queda detrás de otro objeto. El píxel es lo que finalmente se ve en pantalla.

5. Explica qué problema resuelve el Z-buffer y ¿Qué es el depth test?

El Z-buffer guarda la profundidad de los fragmentos, o sea, qué tan cerca o lejos están de la cámara.

El depth test compara esas profundidades para decidir qué fragmento se muestra. Así, si un objeto está delante de otro, OpenGL muestra el que está más cerca y no deja que el de atrás se dibuje encima.

6. ¿Por qué se presenta el problema de la aliasing? ¿Qué es el anti-aliasing?

El aliasing pasa porque la pantalla está hecha de píxeles, entonces los bordes diagonales o curvos pueden verse escalonados, como con “dientes de sierra”.

El anti-aliasing intenta suavizar esos bordes. Según el video, una forma de hacerlo es tomar varias muestras dentro de un mismo píxel para calcular un resultado más suave.

7. ¿Qué relación hay entre la iluminación y el fragment shader? Siempre es necesario tener en cuenta la iluminación en un fragment shader? o puedo hacer un fragment shader sin iluminación? Explica que implicaciones tiene esto.

La iluminación se relaciona con el fragment shader porque ahí se calcula el color final de los fragmentos. Para que una superficie se vea iluminada, se pueden usar datos como la dirección de la luz y la normal de la superficie.

Pero no siempre es obligatorio usar iluminación. También puedo hacer un fragment shader que solo pinte un color plano. Eso es más simple, pero se ve menos realista porque no hay sensación de volumen ni sombras.

8. ¿Qué implica para la GPU que una aplicación tenga múltiples fuentes de iluminación?

Si hay varias luces, la GPU tiene que hacer más cálculos para cada fragmento, porque debe revisar cómo afecta cada luz al color final.

Eso puede hacer que la escena se vea más realista, pero también puede hacer que el renderizado sea más pesado. En pocas palabras: más luces significan más trabajo para la GPU.

### Tercer "reporta en tu bitácora"

1. Escribe un resumen en tus propias palabras de lo que se necesita para dibujar un triángulo en OpenGL.

Para dibujar un triángulo primero necesito definir sus tres vértices, es decir, las posiciones de cada punto del triángulo en X, Y y Z.

Después esos datos se guardan en un VBO, que es como el espacio donde quedan los vértices en la GPU. También se usa un VAO, que le dice a OpenGL cómo debe leer esos datos, por ejemplo que cada vértice tiene 3 valores.

Luego, en el ciclo principal, se activa el VAO y se usa `glDrawArrays(GL_TRIANGLES, 0, 3)` para decirle a OpenGL que dibuje un triángulo usando esos tres vértices.

2. Escribe un resumen en tus propias palabras de lo que necesitas para poder usar un shader en OpenGL.

Para usar un shader primero necesito tener el código del vertex shader y del fragment shader.

El vertex shader procesa la posición de los vértices y el fragment shader define el color de lo que se va a dibujar. En este ejemplo, el fragment shader pinta el triángulo de color naranja.

Después, esos shaders se tienen que compilar, unir en un shader program y activar con `glUseProgram(shaderProg)`. Así, cuando OpenGL dibuja el triángulo, la GPU sabe cómo procesar los vértices y cómo mostrar el color.

### Cuarto "reporta en tu bitácora"

- Antes de ejecutar, creo que no voy a ver un solo triángulo normal, porque cada shader usa un atributo diferente del mismo VBO. El primer shader usa la posición real, el segundo usa el color como si fuera posición, y el tercero usa el offset como posición. Entonces espero ver figuras en posiciones distintas o superpuestas, dependiendo del atributo que esté activo en cada llamada de dibujo.
  
<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/e3acd5f0-567c-43d8-9f1d-daa6ca79cd10" />
