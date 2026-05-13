# Actividad 05

## Triángulo interactivo

### Primer "reporta en tu bitácora"

1. Modifica el código del triángulo para que sea interactivo.

`código modificado`

``` c++
#include <iostream>
#include <glad/glad.h>
#include <GLFW/glfw3.h>


// Callback: ajusta el viewport cuando cambie el tamaño de la ventana
void framebuffer_size_callback(GLFWwindow* window, int width, int height) {
	glViewport(0, 0, width, height);
}

// Procesa entrada simple: cierra con ESC
void processInput(GLFWwindow* window) {
	if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS)
		glfwSetWindowShouldClose(window, true);
}

// Tamaño de las ventanas
const unsigned int SCR_WIDTH = 400;
const unsigned int SCR_HEIGHT = 400;

// Fuentes de los shaders
/*const char* vertexShaderSrc = R"glsl(
    #version 460 core
    layout(location = 0) in vec3 aPos;
    void main() {
        gl_Position = vec4(aPos, 1.0);
    }
)glsl";

const char* fragmentShaderSrc = R"glsl(
    #version 460 core
    out vec4 FragColor;
    void main() {
        FragColor = vec4(1.0, 0.5, 0.2, 1.0);
    }
)glsl";
*/

/*
const char* vertexShaderA = R"glsl(
    #version 460 core
    layout(location = 0) in vec3 aPos;
    void main() {
        gl_Position = vec4(aPos, 1.0);
    }
)glsl";

const char* vertexShaderB = R"glsl(
    #version 460 core
    layout(location = 1) in vec3 aColor;
    void main() {
        gl_Position = vec4(aColor * 0.5, 1.0);
    }
)glsl";

const char* vertexShaderC = R"glsl(
    #version 460 core
    layout(location = 2) in vec2 aOffset;
    void main() {
        gl_Position = vec4(aOffset, 0.0, 1.0);
    }
)glsl";

const char* fragmentShaderSrc = R"glsl(
    #version 460 core
    out vec4 FragColor;
    void main() {
        FragColor = vec4(1.0, 0.5, 0.2, 1.0);
    }
)glsl";
*/

// Fuentes de los shaders
const char* vertexShaderSrc = R"glsl(
	#version 460 core
layout(location = 0) in vec3 aPos;uniform vec2 offset;
void main() {    
		vec3 newPos = aPos;    
		newPos.x += offset.x;    
		newPos.y += offset.y;    
		gl_Position = vec4(newPos, 1.0);
		}
)glsl";

const char* fragmentShaderSrc = R"glsl(
	#version 460 core
out vec4 FragColor;
uniform vec4 ourColor;
void main() {    
		FragColor = ourColor;
		}	
)glsl";


// IDs globales
unsigned int VAO, VBO;
unsigned int shaderProg;
//unsigned int shaderA, shaderB, shaderC;

// Compila y linkea un programa de shaders, retorna su ID
unsigned int buildShaderProgram() {
	int success;
	char log[512];

	unsigned int vs = glCreateShader(GL_VERTEX_SHADER);
	glShaderSource(vs, 1, &vertexShaderSrc, nullptr);
	glCompileShader(vs);
	glGetShaderiv(vs, GL_COMPILE_STATUS, &success);
	if (!success) {
		glGetShaderInfoLog(vs, 512, nullptr, log);
		std::cerr << "ERROR VERTEX SHADER:\n" << log << "\n";
	}

	unsigned int fs = glCreateShader(GL_FRAGMENT_SHADER);
	glShaderSource(fs, 1, &fragmentShaderSrc, nullptr);
	glCompileShader(fs);
	glGetShaderiv(fs, GL_COMPILE_STATUS, &success);
	if (!success) {
		glGetShaderInfoLog(fs, 512, nullptr, log);
		std::cerr << "ERROR FRAGMENT SHADER:\n" << log << "\n";
	}

	unsigned int prog = glCreateProgram();
	glAttachShader(prog, vs);
	glAttachShader(prog, fs);
	glLinkProgram(prog);
	glGetProgramiv(prog, GL_LINK_STATUS, &success);
	if (!success) {
		glGetProgramInfoLog(prog, 512, nullptr, log);
		std::cerr << "ERROR LINKING PROGRAM:\n" << log << "\n";
	}

	glDeleteShader(vs);
	glDeleteShader(fs);
	return prog;
}

/*
unsigned int buildShaderProgram(const char* vertexSrc, const char* fragmentSrc) {
	int success;
	char log[512];

	unsigned int vs = glCreateShader(GL_VERTEX_SHADER);
	glShaderSource(vs, 1, &vertexSrc, nullptr);
	glCompileShader(vs);
	glGetShaderiv(vs, GL_COMPILE_STATUS, &success);
	if (!success) {
		glGetShaderInfoLog(vs, 512, nullptr, log);
		std::cerr << "ERROR VERTEX SHADER:\n" << log << "\n";
	}

	unsigned int fs = glCreateShader(GL_FRAGMENT_SHADER);
	glShaderSource(fs, 1, &fragmentSrc, nullptr);
	glCompileShader(fs);
	glGetShaderiv(fs, GL_COMPILE_STATUS, &success);
	if (!success) {
		glGetShaderInfoLog(fs, 512, nullptr, log);
		std::cerr << "ERROR FRAGMENT SHADER:\n" << log << "\n";
	}

	unsigned int prog = glCreateProgram();
	glAttachShader(prog, vs);
	glAttachShader(prog, fs);
	glLinkProgram(prog);
	glGetProgramiv(prog, GL_LINK_STATUS, &success);
	if (!success) {
		glGetProgramInfoLog(prog, 512, nullptr, log);
		std::cerr << "ERROR LINKING PROGRAM:\n" << log << "\n";
	}

	glDeleteShader(vs);
	glDeleteShader(fs);
	return prog;
}
*/

// Crea un VAO/VBO con los datos de un triángulo
void setupTriangle() {
	float vertices[] = {
		-0.5f, -0.5f, 0.0f,
		 0.5f, -0.5f, 0.0f,
		 0.0f,  0.5f, 0.0f
	};
	glGenVertexArrays(1, &VAO);
	glGenBuffers(1, &VBO);

	glBindVertexArray(VAO);
	glBindBuffer(GL_ARRAY_BUFFER, VBO);
	glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
	glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(float), (void*)0);
	glEnableVertexAttribArray(0);
	glBindVertexArray(0);
}


/*
void setupTriangle() {
	float vertices[] = {
		// pos                  color              offset
		-1.0f, -1.0f, 0.0f,     0.0f, 0.0f, 0.0f,   0.1f, 0.5f,
		 0.0f, -1.0f, 0.0f,     1.0f, 0.0f, 0.0f,   0.2f, 0.5f,
		-0.5f, -0.5f, 0.0f,     0.5f, 0.5f, 0.0f,   0.15f, 0.75f
	};

	glGenVertexArrays(1, &VAO);
	glGenBuffers(1, &VBO);

	glBindVertexArray(VAO);
	glBindBuffer(GL_ARRAY_BUFFER, VBO);
	glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

	// Atributo 0: posición
	glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 8 * sizeof(float), (void*)0);
	glEnableVertexAttribArray(0);

	// Atributo 1: color
	glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, 8 * sizeof(float), (void*)(3 * sizeof(float)));
	glEnableVertexAttribArray(1);

	// Atributo 2: offset
	glVertexAttribPointer(2, 2, GL_FLOAT, GL_FALSE, 8 * sizeof(float), (void*)(6 * sizeof(float)));
	glEnableVertexAttribArray(2);

	glBindVertexArray(0);
}
*/

int main()
{
	// 1) Inicializar GLFW
	if (!glfwInit()) {
		std::cerr << "Fallo al inicializar GLFW\n";
		return -1;
	}
	glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 4);
	glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 6);
	glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

	// 2) Crear ventana
	GLFWwindow* mainWindow = glfwCreateWindow(SCR_WIDTH, SCR_HEIGHT, "Ventana", nullptr, nullptr);
	if (!mainWindow) {
		std::cerr << "Error creando ventana1\n";
		glfwTerminate();
		return -1;
	}

	// 3) Lee el tamaño del framebuffer
	int bufferWidth, bufferHeight;
	glfwGetFramebufferSize(mainWindow, &bufferWidth, &bufferHeight);
	
	// 4) Callbacks 
	glfwSetFramebufferSizeCallback(mainWindow, framebuffer_size_callback);


	// 5) Cargar GLAD y recursos en contexto de window1
	glfwMakeContextCurrent(mainWindow);

	if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress)) {
		std::cerr << "Fallo al cargar GLAD (contexto1)\n";
		return -1;
	}

	// 6) Habilita el V-Sync
	glfwSwapInterval(1);

	// 7) Compila y linkea shaders
	shaderProg = buildShaderProgram();

	//shaderA = buildShaderProgram(vertexShaderA, fragmentShaderSrc);
	//shaderB = buildShaderProgram(vertexShaderB, fragmentShaderSrc);
	//shaderC = buildShaderProgram(vertexShaderC, fragmentShaderSrc);

	// 8) Genera el contenido a mostrar
	setupTriangle();

	// 9) Configura el viewport
	glViewport(0, 0, bufferWidth, bufferHeight);
	//glViewport(0, bufferHeight / 2, bufferWidth / 2, bufferHeight / 2);
	//glViewport(0, bufferHeight / 4, bufferWidth / 4, bufferHeight / 4);
	//glViewport(0, bufferHeight * 2, bufferWidth * 2, bufferHeight * 2);
	//glViewport(0, bufferHeight * 4, bufferWidth * 4, bufferHeight * 4);

	// 10) Loop principal
	while (!glfwWindowShouldClose(mainWindow))
	{
		// 11) Manejo de eventos
		glfwPollEvents();


		// 12) Procesa la entrada
		processInput(mainWindow);

		// 13) Configura el color de fondo y limpia el framebuffer
		glClearColor(0.2f, 0.3f, 0.3f, 1.0f);
		glClear(GL_COLOR_BUFFER_BIT);


		// 14) Indica a OpenGL que use el shader program
		//glUseProgram(shaderProg);
		glUseProgram(shaderProg);
		int offsetLocation = glGetUniformLocation(shaderProg, "offset");
		int colorLocation = glGetUniformLocation(shaderProg, "ourColor");

		// Dibuja el triángulo
		double xpos, ypos;
		glfwGetCursorPos(mainWindow, &xpos, &ypos);

		// Normalizo las coordenadas del mouse
		float x = (float)xpos / (float)SCR_WIDTH;
		x < 0 ? x = 0 : x;
		x > 1 ? x = 1 : x;

		float y = (float)ypos / (float)SCR_HEIGHT;
		y < 0 ? y = 0 : y;
		y > 1 ? y = 1 : y;

		// Envio el color y la posición del triángulo
		float color[] = { x, y, 0.0f, 1.0f };
		glUniform4f(colorLocation, x, y, 0.0f, 1.0f);

		// Envio el offset del triángulo normalizado a NDC
		glUniform2f(offsetLocation, x * 2 - 1, 1 - y * 2);

		// 15) Activa el VAO y dibuja el triángulo
		glBindVertexArray(VAO);
		//glDrawArrays(GL_TRIANGLES, 0, 3);
		//glDrawArrays(GL_LINES, 0, 3);
		//glDrawArrays(GL_POINTS, 0, 3);
		//glDrawArrays(GL_TRIANGLES, 0, 2);
		//glDrawArrays(GL_TRIANGLES, 0, 4);
		glDrawArrays(GL_TRIANGLES, 0, 3);


		glBindVertexArray(VAO);

		// 1. Usar solo el atributo 0: posición
		/*glUseProgram(shaderA);
		glEnableVertexAttribArray(0);
		glDisableVertexAttribArray(1);
		glDisableVertexAttribArray(2);
		glDrawArrays(GL_TRIANGLES, 0, 3);

		// 2. Usar solo el atributo 1: color
		glUseProgram(shaderB);
		glDisableVertexAttribArray(0);
		glEnableVertexAttribArray(1);
		glDisableVertexAttribArray(2);
		glDrawArrays(GL_TRIANGLES, 0, 3);

		// 3. Usar solo el atributo 2: offset
		glUseProgram(shaderC);
		glDisableVertexAttribArray(0);
		glDisableVertexAttribArray(1);
		glEnableVertexAttribArray(2);
		glDrawArrays(GL_TRIANGLES, 0, 3);
		*/
		// 16) Intercambia buffers y muestra el contenido
		glfwSwapBuffers(mainWindow);
	}

	// 17) Limpieza
	glfwMakeContextCurrent(mainWindow);
	glDeleteVertexArrays(1, &VAO);
	glDeleteBuffers(1, &VBO);
	glDeleteProgram(shaderProg);
	//glDeleteProgram(shaderA);
	//glDeleteProgram(shaderB);
	//glDeleteProgram(shaderC);

	glfwDestroyWindow(mainWindow);
	glfwTerminate();
	return 0;
}
```

2. Incluye una captura de pantalla del triángulo interactivo funcionando en tu máquina.

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/b9b9ba7e-892b-4a16-8a70-59d4a31e7727" />

<img width="1918" height="1077" alt="image" src="https://github.com/user-attachments/assets/69c7c319-e980-4725-8b76-8d57b34f1d69" />

<img width="1919" height="1077" alt="image" src="https://github.com/user-attachments/assets/2a04e3dc-82e3-4d23-b58b-e9c2ac95ee04" />

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/98cc5322-7bb4-4c89-963e-c023ad958b9d" />

*(puse varias porque está chevere D:)*

3. Explica el proceso de normalización de las coordenadas del mouse y cómo se relaciona con el sistema de coordenadas de OpenGL.

La posición del mouse se obtiene en píxeles, dependiendo del tamaño de la ventana. Como la ventana mide 400 x 400, las coordenadas pueden ir aproximadamente de 0 a 400.

Para normalizarlas, se divide la posición del mouse entre el ancho y el alto de la ventana. Así, los valores pasan a estar entre 0 y 1. Esto permite trabajar con valores más controlados y usarlos para cambiar el color del triángulo o calcular su posición.

4. Explica el proceso de normalización a coordenadas de dispositivo (NDC) y cómo se relaciona con el sistema de coordenadas de OpenGL.

OpenGL usa coordenadas de dispositivo normalizadas, conocidas como NDC, que van de -1 a 1 en X y en Y. Por eso, después de tener la posición del mouse entre 0 y 1, se convierte ese rango al sistema de OpenGL.

En X, el valor se transforma para que 0 corresponda a -1, 0.5 corresponda a 0 y 1 corresponda a 1.

En Y pasa algo parecido, pero además se invierte el eje, porque las coordenadas del mouse aumentan hacia abajo, mientras que en OpenGL el eje Y positivo va hacia arriba.

En resumen, este proceso permite pasar de coordenadas en píxeles a coordenadas compatibles con OpenGL, para que el triángulo pueda moverse correctamente en pantalla.
