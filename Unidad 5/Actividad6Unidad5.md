# Actividad 6

### ¿Qué puedo observar? ¿Qué información me da el depurador?

Al usar el depurador, se puede ver que aunque todas las partículas están guardadas como tipo `Particle`, en realidad cada una es de un tipo diferente (`RisingParticle`, `CircularExplosion`, etc.).

Cuando el programa llama a `update(dt)`, no todas hacen lo mismo. Cada una ejecuta su propia versión del método.

El depurador muestra que el programa entra a distintos `update()` dependiendo del tipo real del objeto, no del tipo de la variable.

### ¿Qué puedo concluir?

Puedo concluir que el polimorfismo en tiempo de ejecución permite que un mismo código funcione para distintos tipos de objetos, pero que cada uno responda diferente.

Aunque todos se manejen como `Particle`, cada uno ejecuta su propia lógica.

### ¿Qué relación existe entre métodos virtuales y polimorfismo?

Los métodos virtuales son los que hacen posible el polimorfismo.

Gracias a que un método es `virtual`, el programa puede decidir en tiempo de ejecución cuál versión usar dependiendo del objeto real.

Si no fueran virtuales, todos usarían el mismo método y no habría ese comportamiento diferente.
