# Actividad 6

### ¿Qué puedo observar? ¿Qué información me da el depurador?

Al usar el depurador, se puede ver que aunque todas las partículas están guardadas como tipo `Particle`, en realidad cada una es de un tipo diferente (`RisingParticle`, `CircularExplosion`, etc.).

Cuando el programa llama a `update(dt)`, no todas hacen lo mismo. Cada una ejecuta su propia versión del método.

El depurador muestra que el programa entra a distintos `update()` dependiendo del tipo real del objeto, no del tipo de la variable.
