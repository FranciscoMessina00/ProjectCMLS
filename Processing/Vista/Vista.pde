import controlP5.*;

color[] colors = {color(185, 200, 255), color(255, 179, 186), color(186, 255, 201), color(255, 255, 186)};
int[] colorsSwitch = {0xff0066cc, 0xffcc0000, 0xff00994c, 0xffffdf0b};
float dimXblock1 = width/2;
String[] buttonLabels = {"Trig Loop", "Vel Loop", "Notes Loop", "Mod Loop"};
ArrayList<Knob> knobs = new ArrayList<Knob>();

String[][] names = {{"Euclid steps", "Euclid triggers", "Euclid rotation", ""},
                    {"Trig probability", "Logic operator", "Trig loop length", "Rhythm permutations"},
                    {"Glide", "Notes loop length", "Notes permutation", "Scale"},
                    {"Velocity loop length", "Modulation loop length", "Modulation interpolation", "Granulator Dry/Wet"}
                  };
                  
float[][] initVals = {{1,1,0,0},{0,1,1,0},{0,0,5,0},{1,1,0,0}};
float[][] minVals = {{1,1,0,0},{0,1,1,0},{-1,1,0,1},{1,1,-1,0}};
float[][] maxVals = {{32,32,32,0},{1,4,32,20},{1,32,20,10},{32,32,1,1}};

ControlP5 cp5;
boolean toggleValue = false;

void setup() {
  smooth();
  cp5 = new ControlP5(this);
  noStroke();
  size(1400, 650);
  for (int i = 0; i < colors.length; i++) {
    rectMode(CENTER);
    cp5.addToggle(buttonLabels[i])
      .setPosition(width/16 + i*width/8 - 25, 20)
      .setSize(50, 20)
      .setValue(true)
      .setMode(ControlP5.SWITCH)
      .setColorLabel(0)
      .setColorBackground(0xffA0A0A0)
      .setColorActive(colorsSwitch[i]);
    switch(i) {
    case 0:
      for (int j = 0; j<3; j++) {
        Knob knob = cp5.addKnob(names[i][j])
          .setRange(minVals[i][j], maxVals[i][j])
          .setValue(initVals[i][j])
          .setPosition(width/16 + i*width/8 - 30, 100 + j*100)
          .setRadius(30)
          .setColorLabel(0)
          .setViewStyle(Knob.ELLIPSE)
          .setDragDirection(Knob.VERTICAL)
          .setColorBackground(colorsSwitch[i])
          .setColorForeground(0xffffffff)
          .setColorActive(0xffffffff);
        knobs.add(
          knob
          );
      }
      break;
    case 1:
      for (int j = 0; j<4; j++) {
        Knob knob = cp5.addKnob(names[i][j])
          .setRange(minVals[i][j], maxVals[i][j])
          .setValue(initVals[i][j])
          .setPosition(width/16 + i*width/8 - 25, 80 + j*80)
          .setRadius(25)
          .setColorLabel(0)
          .setViewStyle(Knob.ELLIPSE)
          .setDragDirection(Knob.VERTICAL)
          .setColorBackground(colorsSwitch[i])
          .setColorForeground(0xffffffff)
          .setColorActive(0xffffffff);
        knobs.add(
          knob
          );
      }
      break;
      case 2:
      for (int j = 0; j<4; j++) {
        Knob knob = cp5.addKnob(names[i][j])
          .setRange(minVals[i][j], maxVals[i][j])
          .setValue(initVals[i][j])
          .setPosition(width/16 + i*width/8 - 25, 80 + j*80)
          .setRadius(25)
          .setColorLabel(0)
          .setViewStyle(Knob.ELLIPSE)
          .setDragDirection(Knob.VERTICAL)
          .setColorBackground(colorsSwitch[i])
          .setColorForeground(0xffffffff)
          .setColorActive(0xffffffff);
        knobs.add(
          knob
          );
      }
      break;
      case 3:
      for (int j = 0; j<4; j++) {
        Knob knob = cp5.addKnob(names[i][j])
          .setRange(minVals[i][j], maxVals[i][j])
          .setValue(initVals[i][j])
          .setPosition(width/16 + i*width/8 - 25, 80 + j*80)
          .setRadius(25)
          .setColorLabel(0)
          .setViewStyle(Knob.ELLIPSE)
          .setDragDirection(Knob.VERTICAL)
          .setColorBackground(colorsSwitch[i])
          .setColorForeground(0xff000000)
          .setColorActive(0xff000000)
          .setColorValue(0xff000000);
        knobs.add(
          knob
          );
      }
      break;
    }
    rectMode(CORNER);
    fill(colors[i]);
    rect(i * width/8, 0, width/8, height);
  };
  fill(4);
  rect(0, height*5/8, width/2, height*3/8);
  fill(255, 40, 52);
  rect(width/2, 0, width/8, height);
}

void draw() {
}
