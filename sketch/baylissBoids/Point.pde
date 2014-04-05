class Point {
  
  Vec3D pos = new Vec3D();
  
  Point(Vec3D _p) {
    pos = _p;
  }
  
  void run() {
    display();
  }
  
  void display() {
    noSmooth();
    //stroke(200);
    noStroke();
    point(pos.x, pos.y);
  }
  
}
