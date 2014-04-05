import toxi.geom.*;

ArrayList boids;
ArrayList points;

float radius = 200;
float n = 300;
int alpha = 255;

color c = color(0,169,227,alpha);
color y = color(255,215,27,alpha);
color m = color(237,51,140,alpha);

float a;

Vec3D skOrigin = new Vec3D();

Boolean loop = false;

void setup() {
  size(1280,720);
  //frameRate(30);
  smooth();
  
  skOrigin.x = width/2;
  skOrigin.y = height/2;
  
  boids = new ArrayList();
  points = new ArrayList();
  
  for(int i=0; i < n; i++) {
    Vec3D _p = new Vec3D(radius, 0, 0);
    _p.rotateZ(i * 360/n);
    _p.addSelf(skOrigin);
    Point p = new Point(_p);
    points.add(p);
  }
  
  a = sqrt((sq(radius)/2));
  
  //noLoop();
}

void keyPressed() {
  if(key == 'p') {
    loop = !loop;
  }
  
  if(loop == true) {
    loop();
  } else {
    noLoop();
  }
}

void draw() {
  background(255);
  
  if(boids.size() < n) {
    float _rand = random(3);
    color _c = color(0,0,0,0);
    
    if(_rand >= 0 && _rand < 1) {
      _c = c;
    } else if(_rand >= 1 && _rand < 2) {
      _c = y;
    } else if(_rand >= 2 && _rand <= 3) {
      _c = m;
    }
    
    Vec3D origin = new Vec3D(random(width/2 - a, width/2 + a), random(height/2 - a, height/2 + a), 0);
    Boid b = new Boid(origin, _c);
    boids.add(b);
  }
  
  for(int i=0; i < boids.size(); i++) {
    Boid mb = (Boid) boids.get(i);
    mb.run();
  }
  
  for(int i=0; i < points.size(); i++) {
    Point p = (Point) points.get(i);
    p.run();
  }
  
  // save frames for animation
  
  /*
  if(frameCount <= 1800) {
    println(frameCount);
    saveFrame("baylissBoidsTestCMYK/bb-####.png");
  } else {
    noLoop();
  }
  */
  
}
