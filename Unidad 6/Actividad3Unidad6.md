# Actividad 3: Investiga el Patrón Factory Method

## Análisis del caso de estudio

1. **Identifica la Factory:**

    - ¿Qué clase actúa como la factory en este ejemplo?
      
    - ¿Cuál es el “método factory” específico? ¿Es un método de instancia o estático?
      
    - ¿Qué tipo de objeto devuelve este método fábrica?
      
2. **Proceso de creación:**
   
    - Observa el método `ParticleFactory::createParticle`. ¿Cómo decide qué tipo de partícula específica crear y configurar?
      
    - ¿Qué información necesita el método fábrica para realizar su trabajo?
      
    - ¿Qué devuelve si se le pasa un tipo desconocido? ¿Cómo podrías mejorar esto?
      
3. **Uso de Factory:**
   
    - Localiza `ofApp::setup`. ¿Cómo se utiliza la `ParticleFactory` para poblar el vector `particles`?
      
    - Compara esto con la alternativa: ¿Cómo se vería `ofApp::setup` si *no* usara la fábrica y tuviera que crear y configurar cada tipo de partícula (`star`, `shooting_star`, `planet`) directamente usando `new Particle()` y luego ajustando sus propiedades (`size`, `color`, `velocity`)?
