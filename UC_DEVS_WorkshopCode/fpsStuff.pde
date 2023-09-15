class fpsStuff {
  boolean live;
  float fpsMax, fpsMin, fpsWaitedAverge, fpsTarget, fpsOffset;
  int refresh=5; // seconds to refresh dispay
  fpsStuff(int t) {
    live = false;
    fpsTarget = t;
    fpsWaitedAverge = 0;
    fpsMin = 999999;
    fpsMax = 0;
    fpsOffset = 0;
   }
  
  void monitor() {
    if (!live) return;
    if (frameCount%(fpsTarget*refresh) == 0) {
      if (debug) print();
      update();
      reset();
    }
    fpsWaitedAverge =lerp(fpsWaitedAverge, frameRate, 0.1);
    fpsMin = min(fpsMin, frameRate);
    fpsMax = max(fpsMax, frameRate);
    //if (fpsMin < fpsTarget) {
    //  update();
    //}
    //if (fpsMin > fpsTarget + 10) {
    //  update();
    //}
   
  }
  
  void update() {
    fpsOffset += fpsTarget - fpsMin+1;// +1 for head room
    if (fpsOffset < 0) fpsOffset = -1;
    frameRate(fpsTarget+fpsOffset);
    if (debug) println("Fps Target Updated: "+ (fpsTarget + fpsOffset));
    reset();
  }
  
  void print() {
    println("FPS    : " + frameRate);
    println("Target : " + fpsTarget);
    println("Averge : " + fpsWaitedAverge);
    println("Max    : " + fpsMax);
    println("Min    : " + fpsMin);
    println("Offset : " + fpsOffset);
  }
  
  void reset() {
    fpsWaitedAverge = frameRate;
    fpsMin = frameRate;
    fpsMax = frameRate;
    //fpsOffset = 0;
  }
  void toggle() {
    live ^= true;
    if (debug) println("FPS monitoring: " + live);
  }
}
