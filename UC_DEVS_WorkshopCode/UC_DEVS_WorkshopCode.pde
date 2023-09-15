final color cubeColor = color(37,152,227);
final int Vlength = 100;    //length of vectors drawn in debug mode
final int boxSize = 400; //Size of box
final int sense = 1000; //mouse sensativity or speed
final boolean invertMouse = false; //flips up and down
boolean spin = false;
boolean debug = false;
fpsStuff fpsThing = new fpsStuff(60); // target frame rate
PVector an = new PVector();
PVector mv = new PVector();
PVector Mom = new PVector(0,0);
Float dad = 1.0;
boolean kids = false;
PMatrix3D rotatMtx; //Rotation matrix
PVector VecH, VecV; //axis for Horazontal & Vertical spin
final int invLook = int(invertMouse)*2-1;


boolean mouse_moved = false;

void setup() {
  VecH = new PVector();
  VecV = new PVector();
  rotatMtx = new PMatrix3D();
  
  //size(800, 600, P3D);
  orientation(PORTRAIT);
  fullScreen(P3D);
  //cameraUp();
  //surface.setTitle("Hello World!");
  //surface.setResizable(true);
  //surface.setLocation(100, 100)
  //frameRate(70); // best gusse
  resetRotation();
  strokeWeight(2);
  stroke(255);
  //noFill();
  //hint(DISABLE_DEPTH_MASK);
  
  //hint(ENABLE_STROKE_PERSPECTIVE);
}

void draw() {
  //scale(1,-1,1);// Y+ is up, Standard Co-Ordinates (Right Handed system)
  background(200);
  
  fill(0);
  text("Hello, world!", width *.1f, height /2);
  
  fill(cubeColor);
  if (!mousePressed) {
    kids=true;
    Mom.mult(0.9);
    spinBox(Mom.x,Mom.y);
    //noFill();
  }
  pushMatrix();
    translate(width/2, height/2, 0); //moves origen to center
    if (spin) {
      PVector temp = PVector.random3D();
    mv.normalize();
    mv.lerp(temp,0.01);
    mv.mult(100);
    translate(mv.x,mv.y,mv.z);
    }
    
    applyMatrix(rotatMtx);
    //scale(2);
    if (debug) {
      drawVec(VecH,#FFFF00,Vlength/2);
      drawVec(VecV,#00FFFF, Vlength/2);
      drawVecsXYZ(Vlength);
      //drawVec(VecH.cross(VecV),#FF00FF,Vlength/2);
    }
    
    stroke(#FFFFFF);
    box(boxSize);
  popMatrix();
  fpsThing.monitor();
  if (spin) autoMove();
}

void autoMove() {
  float angle = frameCount/60.0;
  float speed = 10.0;
  an.lerp(PVector.random2D(),0.1);
  //an.normalize();
  spinBox(an.x/speed,an.y/speed);
  //spinBox(sin(angle)/10.0,cos(angle)/10.0);
}


void mouseDragged() {
  if (!mouse_moved) { 
    mouse_moved = true; return;//ignore first call
  }
  float Mx = map(mouseX - pmouseX,-sense,sense,-PI,PI);
  float My = map(mouseY - pmouseY,-sense,sense,-PI,PI)*invLook;
  Mom.lerp(new PVector(Mx,My),0.5);
  //Mom.set(Mx,My);
  spinBox(Mx,My);
}

void mouseMoved() {
  if (!mouse_moved) { 
    mouse_moved = true; return;//ignore first call
  }
  spinBox(
    map(mouseX - pmouseX,-sense,sense,-PI,PI),
    map(mouseY - pmouseY,-sense,sense,-PI,PI)*invLook
    );
}

void spinBox(float H,float V) {// calls spin for using 2 angles
  spin(H,VecH,VecV); //Horosontal spin
  spin(V,VecV,VecH); //Vertical spin
}

void spin(float theta, PVector a, PVector b) {
  //Modifys the rotation matrix, rotating it by θ radiens
  //around the axis b⃗. To negate the effect of the rotation
  //matrix on a⃗. The inverse rotation will be applied to it.
  rotatMtx.rotate(theta,b.x,b.y,b.z);
  PMatrix3D invrotatMtx = new PMatrix3D();
  invrotatMtx.rotate(-theta,b.x,b.y,b.z);
  invrotatMtx.mult(a,a);
}   

void resetRotation() {
  rotatMtx.reset();
  VecH.set(1,0,0);
  VecV.set(0,1,0);
}


void keyPressed() {
  resetRotation();
  if (key == 'p') {
    fpsThing.print();
  } else if (key == 'u') {
    fpsThing.update();
  }else if (key == 'r') {
    fpsThing.reset();
  }else if (key == 'm') {
    fpsThing.toggle();
  }else if (key == 'd') {
    debug ^= true;
    println("debugging: " + debug);
  }
  else if (key == 's') {
    spin ^=true;
    println("spining: " + debug);
  }
}
