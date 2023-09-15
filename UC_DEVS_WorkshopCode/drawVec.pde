void drawVec(PVector V,color c, float len) {
  stroke(c);
  V.normalize();
  V.mult(len);
  line(0,0,0,V.x,V.y,V.z);
}


void drawVec(color c, float len) {
  PVector V = new PVector();
  V.set(red(c),green(c),blue(c));
  drawVec(V, c, len);
}


void drawVec(PVector V, float len) {
  PVector F = new PVector(1,1,1);
  V.normalize();
  F.add(V);
  F.mult(128);
  drawVec(V, color(F.x,F.y,F.z), len);
}


void drawVecsXYZ(float len) {
  drawVec(#FF0000,len);
  drawVec(#00FF00,len);
  drawVec(#0000FF,len);
}
