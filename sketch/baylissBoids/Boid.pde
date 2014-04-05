class Boid {

  int w = 3, h = 4;
  float sMax = 2;

  Vec3D up = new Vec3D(0,-1,0);
  Vec3D loc = new Vec3D (0, 0, 0);
  Vec3D speed = new Vec3D(random(-2, 2), random(-2, 2), 0);
  Vec3D acc = new Vec3D();
  
  color col;

  Boid(Vec3D _loc, color _col) {
    loc = _loc;
    col = _col;
  }

  void run() {
    flock();
    //gravitate(1.5);
    //bounce();
    move();
    display();
  }

  void flock() {
    repel(8.0);
    seperate(1.8);
    cohesion(0.00001);
    align(0.001);
  }
  
  void repel(float mag) {
    
    Vec3D steer = new Vec3D();
    int count = 0;
    
    for(int i=0; i < points.size(); i++) {
      Point p = (Point) points.get(i);
      
      float distance = loc.distanceTo(p.pos);
      
      if(distance < 20) {
        Vec3D diff = loc.sub(p.pos);
        diff.normalizeTo(sMax/distance);
        steer.addSelf(diff);
        count++;
      }
    }
    
    if(count > 0) {
      steer.scaleSelf(1.0/count);
    }
    
    steer.scaleSelf(mag);
    acc.addSelf(steer);
        
  }
  
  void seperate(float mag) {
    
    Vec3D steer = new Vec3D();
    int count = 0;
    
    for(int i=0; i < boids.size(); i++) {
      Boid other = (Boid) boids.get(i);
      
      float distance = loc.distanceTo(other.loc);
      
      if(distance < 15) {
        Vec3D diff = loc.sub(other.loc);
        diff.normalizeTo(1.0/distance);
        steer.addSelf(diff);
        count++;
      }
    }
    
    if(count > 0) {
      steer.scaleSelf(1.0/count);
    }
    
    steer.scaleSelf(mag);
    acc.addSelf(steer);
    
  }
  
  void cohesion(float mag) {
    
    Vec3D sum = new Vec3D();
    int count = 0;
    
    for(int i=0; i < boids.size(); i++) {
      Boid other = (Boid) boids.get(i);
      
      float distance = loc.distanceTo(other.loc);
      
      if(distance > 0 && distance < 60) {
        sum.addSelf(other.loc);
        count++;
      }
    }
    
    if(count > 0) {
      sum.scaleSelf(1.0/count);
    }
    
    Vec3D steer = sum.sub(loc);
    steer.scaleSelf(mag);
    
    acc.addSelf(steer);
    
  }
  
  void align(float mag) {
    
    Vec3D steer = new Vec3D();
    int count = 0;
    
    for(int i=0; i < boids.size(); i++) {
      Boid other = (Boid) boids.get(i);
      
      float distance = loc.distanceTo(other.loc);
      
      if(distance > 0 && distance < 50) {
        steer.addSelf(other.speed);
        count++;
      }
    }
    
    if(count > 0) {
      steer.scaleSelf(1.0/count);
    }
    
    steer.scaleSelf(mag);
    acc.addSelf(steer);
    
  }

  void gravitate(float mag) {
    
    Vec3D grav = new Vec3D();
    float distance = loc.distanceTo(skOrigin);
    
    if(distance > 0 && distance > radius) {
      Vec3D diff = loc.sub(skOrigin);
      //diff.normalizeTo(1.0/distance);
      diff.normalizeTo(1.0);
      grav.subSelf(diff);
    }
    
    grav.scaleSelf(mag);
    acc.addSelf(grav);
    
  }

  void bounce() {
    if (sq(loc.x - (width/2)) + sq(loc.y - (height/2)) > sq(radius)) {
      speed.x --;
      speed.y --;
    }
  }

  void move() {
    speed.addSelf(acc);
    speed.limit(sMax);
    loc.addSelf(speed);
    acc.clear();
  }

  void display() {
    noStroke();
    fill(col);
    pushMatrix();
    smooth();
    float heading = speed.headingXY() + radians(90);
    translate(loc.x,loc.y);
    rotate(heading);
    beginShape();
    vertex(0,-h);
    vertex(w,h);
    vertex(0,h-2);
    vertex(-w,h);
    endShape(CLOSE);
    popMatrix();
  }
}

