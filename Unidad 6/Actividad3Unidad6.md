# Actividad 3: Investiga el Patrón Factory Method

## Análisis del caso de estudio

1. **Identifica la Factory:**

    - ¿Qué clase actúa como la factory en este ejemplo?

      La clase que actúa como factory en este caso es `ParticleFactory`
      
    - ¿Cuál es el “método factory” específico? ¿Es un método de instancia o estático?
  
      El "método factory" es `Particle* createParticle(const std::string& type);`. Es un método estático       
    
    - ¿Qué tipo de objeto devuelve este método fábrica?
  
      
      
2. **Proceso de creación:**
   
    - Observa el método `ParticleFactory::createParticle`. ¿Cómo decide qué tipo de partícula específica crear y configurar?
  
      <img width="815" height="578" alt="image" src="https://github.com/user-attachments/assets/b0c2856c-08ee-494a-bdd6-9d3f19d86f2f" />
      
      El método `ParticleFactory::createParticle` decide que tipo de partícula crear a partir del parámetro `type`
      
    - ¿Qué información necesita el método fábrica para realizar su trabajo?
      
    - ¿Qué devuelve si se le pasa un tipo desconocido? ¿Cómo podrías mejorar esto?
      
3. **Uso de Factory:**
   
    - Localiza `ofApp::setup`. ¿Cómo se utiliza la `ParticleFactory` para poblar el vector `particles`?
  
      <img width="721" height="559" alt="image" src="https://github.com/user-attachments/assets/51f257a0-9c41-45c9-887e-7c7d578d65e9" />
      
    - Compara esto con la alternativa: ¿Cómo se vería `ofApp::setup` si *no* usara la fábrica y tuviera que crear y configurar cada tipo de partícula (`star`, `shooting_star`, `planet`) directamente usando `new Particle()` y luego ajustando sus propiedades (`size`, `color`, `velocity`)?
