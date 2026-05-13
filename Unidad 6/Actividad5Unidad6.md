# Actividad 5

1. `ofApp.cpp`

``` c++
#include "ofApp.h"
#include <algorithm>

void Subject::addObserver(Observer* observer) 
{
	if (!observer) return;

	if (std::find(observers.begin(), observers.end(), observer) == observers.end()) 
	{
		observers.push_back(observer);
	}
}

void Subject::removeObserver(Observer* observer) 
{
	if (!observer) return;
	observers.erase(std::remove(observers.begin(), observers.end(), observer), observers.end());
}

void Subject::notify(const std::string& event) 
{
	for (Observer* observer : observers) 
	{
		observer->onNotify(event);
	}
}

Particle::Particle() : state(nullptr) 
{
	position = ofVec2f(ofRandomWidth(), ofRandomHeight());
	velocity = ofVec2f(ofRandom(-0.5f, 0.5f), ofRandom(-0.5f, 0.5f));
	size = ofRandom(2.0f, 5.0f);  
	color = ofColor(255);
	state = new NormalState();  
	state->onEnter(this);
}

Particle::~Particle() 
{
	if (state) 
	{
		state->onExit(this);
		delete state;
		state = nullptr;
	}
}

void Particle::setState(State* newState) 
{
	if (state) 
	{
		state->onExit(this);
		delete state;
	}
	state = newState;
	if (state) 
	{
		state->onEnter(this);
	}
}

void Particle::update()
{
	if (state) 
	{
		state->update(this);
	}
	keepInsideWindow();
}

void Particle::draw() 
{
	ofPushStyle();
	ofSetColor(color);
	ofDrawCircle(position, size);
	ofPopStyle();
}

void Particle::onNotify(const std::string& event) 
{
	if (event == "attract") 
	{
		setState(new AttractState());
	}
	else if (event == "repel") 
	{
		setState(new RepelState());
	}
	else if (event == "stop") 
	{
		setState(new StopState());
	}
	else if (event == "normal") 
	{
		setState(new NormalState());
	}
}

void Particle::keepInsideWindow() 
{
	const float W = static_cast<float>(ofGetWidth());
	const float H = static_cast<float>(ofGetHeight());

	if (position.x < 0.0f)
	{
		position.x = 0.0f;
		velocity.x *= -1.0f;
	}
	else if (position.x > W) 
	{
		position.x = W;
		velocity.x *= -1.0f;
	}
	if (position.y < 0.0f) 
	{
		position.y = 0.0f;
		velocity.y *= -1.0f;
	}
	else if (position.y > H) 
	{
		position.y = H;
		velocity.y *= -1.0f;
	}
}

void NormalState::onEnter(Particle* particle) 
{
	particle->velocity.set(ofRandom(-0.5f, 0.5f), ofRandom(-0.5f, 0.5f));
}

void NormalState::update(Particle* particle) 
{
	particle->position += particle->velocity;
}

static void steer(Particle* particle, const ofVec2f& toward, float accel, float vmax, float posScale) 
{
	ofVec2f dir = toward - particle->position;
	float len = dir.length();
	if (len > 1e-6f) 
	{
		dir /= len;
		particle->velocity += dir * accel;
	}
	particle->velocity.limit(vmax);
	particle->position += particle->velocity * posScale;
} 

void AttractState::update(Particle* particle) 
{
	ofVec2f mouse(ofGetMouseX(), ofGetMouseY());
	steer(particle, mouse, /*accel*/ 0.05f, /*vmax*/ 3.0f, /*posScale*/ 0.2f);
}

void RepelState::update(Particle* particle) 
{
	ofVec2f mouse(ofGetMouseX(), ofGetMouseY());
	ofVec2f away = particle->position - mouse;
	float len = away.length();
	if (len > 1e-6f)
	{
		away /= len;
		particle->velocity += away * 0.05f;
	}
	particle->velocity.limit(3.0f);
	particle->position += particle->velocity * 0.2f;
}

void StopState::update(Particle* particle) 
{
	particle->velocity *= 0.80f;
	if (particle->velocity.lengthSquared() < 1e-4f) 
	{
		particle->velocity.set(0.0f, 0.0f);
	}
	particle->position += particle->velocity;
}

Particle* ParticleFactory::createParticle(const std::string& type) 
{
	Particle* particle = new Particle();
	if (type == "star") 
	{
		particle->size = ofRandom(2.0f, 4.0f);
		particle->color = ofColor(255, 0, 0);
	}
	else if (type == "shooting_star") 
	{
		particle->size = ofRandom(3.0f, 6.0f);
		particle->color = ofColor(0, 255, 0);
		particle->velocity *= 3.0f;
	}
	else if (type == "planet") 
	{
		particle->size = ofRandom(5.0f, 8.0f);
		particle->color = ofColor(0, 0, 255);
	}
	else if (type == "comet") 
	{
		particle->size = ofRandom(6.0f, 10.0f);
		particle->color = ofColor(255, 255, 0);
		particle->velocity *= 2.0f;
	}

	return particle;
}

ofApp::~ofApp() 
{
	for (Particle* p : particles) 
	{
		removeObserver(p);
		delete p;
	}
	particles.clear();
}

void ofApp::setup() 
{
	ofBackground(0);

	particles.reserve(100 + 5 + 10);

	for (int i = 0; i < 100; ++i) 
	{
		Particle* p = ParticleFactory::createParticle("star");
		particles.push_back(p);
		addObserver(p);
	}
	for (int i = 0; i < 5; ++i) 
	{
		Particle* p = ParticleFactory::createParticle("shooting_star");
		particles.push_back(p);
		addObserver(p);
	}
	for (int i = 0; i < 10; ++i)
	{
		Particle* p = ParticleFactory::createParticle("planet");
		particles.push_back(p);
		addObserver(p);
	}
	for (int i = 0; i < 8; ++i) 
	{
		Particle* p = ParticleFactory::createParticle("comet");
		particles.push_back(p);
		addObserver(p);
	}
}

void ofApp::update() 
{
	for (Particle* p : particles) 
	{
		p->update();
	}
}

void ofApp::draw() 
{
	for (Particle* p : particles) 
	{
		p->draw();
	}
}

void ofApp::keyPressed(int key) 
{
	switch (key) 
	{
	case 's':
		notify("stop");
		break;
	case 'a':
		notify("attract");
		break;
	case 'r':
		notify("repel");
		break;
	case 'n':
		notify("normal");
		break;
	default:
		break;
	}
}
```

2. Para implementar la nueva partícula usé el patrón `Factory` en el método `ParticleFactory::createParticle`. Allí agregué un nuevo caso llamado `"comet"`.
   
3. Implementé el patrón `Observer` registrando cada nueva partícula `"comet"` como observadora mediante `addObserver(p)` en `ofApp::setup`.

4. Apliqué el patrón `State` porque la nueva partícula `"comet"` usa la misma lógica de estados que ya tiene la clase `Particle`. Cuando recibe eventos como `"attract"`, `"repel"`, `"stop"` o `"normal"`, cambia su estado usando `setState()`.
