# **Actividad 02**

# **¿Cómo se crea un proyecto OpenGL en Windows?**

GLFW es la biblioteca que me permite crear la ventana del programa y manejar cosas como el teclado y el mouse. También ayuda a crear el contexto de OpenGL, que básicamente es lo que permite que OpenGL pueda dibujar dentro de esa ventana.

opengl32.lib es una biblioteca que ya viene con Windows. Sirve para que el proyecto pueda iniciar OpenGL, pero solo trae funciones muy básicas y antiguas. Por eso, para usar funciones modernas de OpenGL, entra GLAD, que se encarga de buscarlas y cargarlas desde los drivers de la GPU cuando el programa se está ejecutando.

Los drivers de la GPU son importantes porque ahí están implementadas las funciones modernas de OpenGL. O sea, GLAD no inventa esas funciones, sino que las encuentra en el driver de la tarjeta gráfica para que el programa pueda usarlas.

Por último, GLM no es obligatorio para abrir una ventana ni para que OpenGL corra, pero sí ayuda mucho con las matemáticas de gráficos, como vectores, matrices y transformaciones.

En resumen, GLFW prepara la ventana, opengl32.lib permite iniciar OpenGL en Windows, GLAD carga las funciones modernas desde los drivers de la GPU, y GLM sirve como apoyo matemático para trabajar escenas 2D o 3D.
