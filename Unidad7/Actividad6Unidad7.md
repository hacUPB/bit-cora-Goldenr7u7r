# Actividad 06

## Aplica lo aprendido en esta unidad

### Primer "reporta en tu bitácora" 

1. Describe brevemente los cambios que realizaste en el código C++ (dónde obtienes el tiempo, cómo y dónde actualizas el uniform).

En el código C++ agregué un nuevo `uniform` llamado `time` para poder enviarle el tiempo al shader. Primero obtuve su ubicación con `glGetUniformLocation(shaderProg, "time")`.

Luego, dentro del ciclo principal, usé `glfwGetTime()` para obtener el tiempo transcurrido desde que inició GLFW. Ese valor se guarda en una variable y se actualiza en cada frame.

Finalmente, envié ese tiempo al shader usando `glUniform1f(timeLocation, timeValue)`. Con esto, el fragment shader puede usar el tiempo para cambiar el color del triángulo automáticamente.

2. Pega el código modificado de tu fragment shader.

``` c++
const char* fragmentShaderSrc = R"glsl(
	#version 460 core
out vec4 FragColor;
uniform float time;
void main() {    
		float r = (sin(time) + 1.0) / 2.0;
		float g = (cos(time) + 1.0) / 2.0;
		float b = (sin(time * 2.0) + 1.0) / 2.0;

		FragColor = vec4(r, g, b, 1.0);
		}
)glsl";

```

3. Explica cómo usaste la función de tiempo (sin, cos, u otra) para lograr el efecto de cambio de color cíclico. ¿Qué rango de valores produce tu cálculo y cómo afecta eso al color final?

Usé `sin()` y `cos()` con el valor de time para que el color cambiara de forma suave y repetitiva. Estas funciones sirven porque no crecen infinitamente, sino que van subiendo y bajando en ciclo.

`sin(time)` y `cos(time)` producen valores entre -1 y 1, pero los colores en OpenGL se manejan entre 0 y 1. Por eso se usa la operación de sumar 1.0 y dividir entre 2.0.

Así el valor queda entre 0 y 1, y se puede usar en los componentes del color, como rojo, verde y azul. Entonces, mientras pasa el tiempo, esos valores cambian y el triángulo va cambiando de color automáticamente.

4. Incluye una captura de pantalla o UN ENLACE a un video mostrando el resultado del triángulo con color cambiante.

https://youtu.be/7yZkikkGQQ0 

5. Reflexión: ¿Qué otros efectos visuales simples podrías lograr usando el tiempo como uniform? Piensa en la posición, el tamaño o la rotación (aunque no hemos visto rotaciones formalmente, ¡intuitivamente podrías intentarlo!). Anota al menos una idea.

Usando el tiempo como uniform se podrían hacer otros efectos simples. Por ejemplo, el triángulo podría moverse solo de izquierda a derecha usando una función como sin(time) para cambiar su posición en X.

También se podría hacer que el triángulo cambie de tamaño con el tiempo, como si estuviera pulsando o respirando. La idea sería usar el tiempo para que el valor suba y baje automáticamente, en vez de depender del mouse.
