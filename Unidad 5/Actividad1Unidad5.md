# **Actividad 1:** Esta será nuestra actividad de diagnóstico inicial

### Parte 1: recordando los conceptos (en C#)

- **1. ¿Qué es el encapsulamiento para ti? Describe una situación en la que te haya sido útil o donde hayas visto su importancia.**

El encapsulamiento es uno de los cuatro pilares de la programación orientada a objetos, oculta los atributos de un objeto, sólo es posible acceder a ellos mediante métodos controlados.

Por ejemplo, en una clase de cuenta bancaria, el saldo no debería ser público porque alguien podría ponerle un valor negativo o incoherente. Entonces se pone como privado y se crean métodos como depositar o retirar, donde se valida que las operaciones tengan sentido.

- **2. ¿Qué es la herencia? ¿Por qué un programador decidiría usarla? Da un ejemplo simple.**

La herencia es uno de los cuatro pialres de la programación orientada a objetos, consiste en permitir que una clase (clase hija) adquiera los atributos y métodos de otra clase (clase padre). Es práctico usarla ya que permite reciclar código.

- **3. ¿Qué es el polimorfismo? Describe con tus palabras qué significa que un código sea “polimórfico”.**

El polimorfirmo es uno de los cuatro pilares de la programación orientada a objetos, consiste en la capacidad de un método de adoptar diferentes comportamientos dependiendo del objeto que lo use.

Se dice que un código el "polimórfico", es que se puede usar un mismo método para trabajar con distintos objetos, y cada uno de ellos va a responder de manera diferente dependiendo de su implementación.

### Parte 2: análisis de código (en C#)

``` c#
namespace Actividad1Unidad5;
using System;
using System.Collections.Generic;

public abstract class Figura
{
    private string nombre;

    public string Nombre
    {
        get 
        { 
            return nombre; 
        }

        protected set 
        { 
            nombre = value; 
        }
    }

    public Figura(string nombre)
    {
        this.Nombre = nombre;
    }

    public abstract void Dibujar();
}

public class Circulo : Figura
{
    public double Radio 
    { 
        get; 
        private set; 
    }

    public Circulo(double radio) : base("Círculo")
    {
        this.Radio = radio;
    }

    public override void Dibujar()
    {
        Console.WriteLine($"Dibujando un {Nombre} de radio {Radio}.");
    }
}

public class Rectangulo : Figura
{
    public double Base 
    { 
        get; 
        private set; 
    }

    public double Altura 
    { 
        get; 
        private set; 
    }

    public Rectangulo(double b, double h) : base("Rectángulo")
    {
        this.Base = b;
        this.Altura = h;
    }

    public override void Dibujar()
    {
        Console.WriteLine($"Dibujando un {Nombre} de {Base}x{Altura}.");
    }
}

public class Programa
{
    public static void Main()
    {
        List<Figura> misFiguras = new List<Figura>();
        misFiguras.Add(new Circulo(5.0));
        misFiguras.Add(new Rectangulo(4.0, 6.0));
        misFiguras.Add(new Circulo(10.0));

        foreach (Figura fig in misFiguras)
        {
            fig.Dibujar();
        }
    }
}
```

**Encapsulamiento:**

- Señala una línea de código que sea un ejemplo claro de encapsulamiento y explica por qué lo es.

``` C#
private string nombre;
```

Esto es encapsulamiento porque esa variable no se puede usar directamente desde otras clases. Está protegida y solo se puede acceder a través de la propiedad `Nombre`. Es como esconder el dato para que no lo dañen.

- ¿Por qué crees que el campo nombre es private pero la propiedad Nombre es public? ¿Qué problema se evita con esto?

Porque así no cualquiera puede cambiar el valor directamente. Si fuera público, alguien podría poner cualquier cosa y dañar el objeto. Con la propiedad, se controla mejor cómo se usa ese dato, y se evita que tenga valores raros o incorrectos.

**Herencia:**

- ¿Cómo se evidencia la herencia en la clase Circulo?

Se ve aquí:

``` C#
public class Circulo : Figura
```

Eso significa que `Circulo` viene de `Figura`, o sea que hereda lo que tiene esa clase.

- Un objeto de tipo Circulo, además de Radio, ¿Qué otros datos almacena en su interior gracias a la herencia?

También tiene el `nombre`, que viene de la clase `Figura`. Aunque no lo veamos directamente en `Circulo`, sí lo tiene guardado.

**Polimorfismo:**

- Observa el bucle `foreach`. La variable `fig` es de tipo Figura, pero a veces contiene un Circulo y otras un Rectangulo. Cuando se llama a `fig.Dibujar()`, el programa ejecuta la versión correcta. En tu opinión, ¿Cómo crees que funciona esto “por debajo”? No necesitas saber la respuesta correcta, solo quiero que intentes razonar cómo podría ser.

Yo creo que el objeto “sabe” qué tipo es realmente (si es círculo o rectángulo), aunque la variable diga `Figura`. Entonces cuando se llama `Dibujar()`, el programa revisa qué tipo es en verdad y usa ese método específico. Como si el objeto tuviera una etiqueta interna que dice: “soy círculo” o “soy rectángulo”.

### Parte 3: hipótesis sobre la implementación

**1. Memoria y herencia: cuando creas un objeto Rectangulo, este tiene Base, Altura y también Nombre. ¿Cómo te imaginas que se organizan esos tres datos en la memoria del computador para formar un solo objeto?**

Yo me imagino que todo se guarda junto en memoria, como en un solo bloque.

Algo tipo:

`[nombre | base | altura]`

O sea, una parte viene de la clase padre y la otra de la hija, pero todo queda en el mismo objeto.

**2. El mecanismo del polimorfismo: pensemos de nuevo en la llamada fig.Dibujar(). El compilador solo sabe que fig es una Figura. ¿Cómo decide el programa, mientras se está ejecutando, si debe llamar al Dibujar del Circulo o al del Rectangulo? Lanza algunas ideas o hipótesis.**

Siento que cada objeto guarda información de qué clase es realmente. Entonces cuando se llama un método, el programa mira eso y decide cuál usar. Como si hubiera una lista interna de “si eres esto, usa este método”.

**3. La barrera del encapsulamiento: ¿Cómo crees que el compilador logra que no puedas acceder a un miembro private desde fuera de la clase? ¿Es algo que se revisa cuando escribes el código, o es una protección que existe mientras el programa se ejecuta? ¿Por qué piensas eso?**

Yo creo que eso lo revisa el compilador antes de que el programa corra. Porque si intentas usar algo `private` desde fuera, el código ni siquiera compila. Entonces es más como una regla del lenguaje que te bloquea antes de ejecutar.

