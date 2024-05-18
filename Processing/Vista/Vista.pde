import controlP5.*;
import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress myRemoteLocation;

color[] colors = {color(185, 200, 255), color(255, 179, 186), color(186, 255, 201), color(255, 255, 186)};
int white = 0xffffffff;
int black = 0xff000000;
int[] colorsSwitch = {0xff0066cc, 0xffcc0000, 0xff00994c, 0xffffdf0b};
int[] in_rainbows = {0xffa2dce6, 0xffec2327, 0xffedb31e, 0xff45b74a, 0xfff36525, 0xff4686c7, 0xfff7ed4a};
float dimXblock1 = width/2;
String[] buttonLabels = {"Trig Loop", "Vel Loop", "Notes Loop", "Mod Loop"};

ArrayList<Knob> knobs_supercollider = new ArrayList<Knob>();
ArrayList<Knob> knobs_juice = new ArrayList<Knob>();

float Name0, Name1, Name2, x, y, z, oldZ;

String[][] names_1= {{"Euclid steps", "Euclid triggers", "Euclid rotation", "Logic operator"},
  {"Trig probability", "Velocity loop length", "Trig loop length", "Rhythm permutations"},
  {"Glide", "Notes loop length", "Notes permutation", "Scale"},
  {"Modulation loop length", "Modulation interpolation", "Pitch granulator", "Granulator Dry/Wet"}
};

String[][] names_2 = {{"Fold Amount", "Dist Amount", "F&D Dry/Wet"},
  {"Wavelength", "Rate", "Depth"},
  {"Feedback", "Width", "Flanger Dry/Wet"},
  {"Color", "Stereo", ""}
};

ArrayList<Slider2D> sliders = new ArrayList<Slider2D>();


float[][] initVals_1 = {{1, 1, 1, 1},
  {0, 1, 1, 0},
  {0, 1, 5, 1},
  {1, 0, 1, 0}};
float[][] minVals_1  = {{1, 1, 1, 1},
  {0, 1, 1, 0},
  {-1, 1, 0, 1},
  {1, 0, 0.5, 0}};
float[][] maxVals_1= {{32, 32, 32, 4},
  {1, 32, 32, 20},
  {1, 32, 20, 10},
  {32, 1, 2, 1}};


int slider_select = 0;

float[][] initVals_2 = {{1, 1, 0},
  {0, 440, 0.6},
  {0.9, 0.010, 0},
  {0, 1, 0}};
float[][] minVals_2  = {{1, 1, 0},
  {0, 0.1, 0.1},
  {0, 0, 0},
  {0, 0, 0}};
 float[][] maxVals_2= {{60, 1000, 1},
  {3, 20000, 1},
  {1, 0.015, 1},
  {1,1,0}};

int ticks =1;
boolean snap = false;

ControlP5 cp5;
boolean toggleValue = false;

void setup() {
  oscP5 = new OscP5(this, 24);
  myRemoteLocation = new NetAddress("127.0.0.1", 57120);

  smooth();
  cp5 = new ControlP5(this);
  noStroke();
  size(1200, 650);
  for (int i = 0; i < colors.length; i++) {
    rectMode(CENTER);
    //creatoin of top buttons
    cp5.addToggle(buttonLabels[i])
      .setPosition(width/16 + i*width/8 - 25, 20)
      .setSize(50, 20)
      .setValue(true)
      .setMode(ControlP5.SWITCH)
      .setColorLabel(0)
      .setColorBackground(0xffA0A0A0)
      .setColorActive(colorsSwitch[i]);

    //creation of knobs in block_one and block_two
    switch(i) {
    case 0:
      for (int j = 0; j<4; j++) {
        ticks = 31;
        if(j == 3){
          ticks = 3;
        }
        Knob knob = makeKnobs(names_1[i][j], minVals_1[i][j], maxVals_1[i][j], initVals_1[i][j], width/16 + i*width/8 - 25, 80 + j*80, black, colorsSwitch[i], white,ticks,true);
        knobs_supercollider.add(
          knob
          );

      }
      for (int j = 0; j<3; j++) {
        if(j == 1){
          ticks = 999;
          snap = true;
        }
        Knob knob = makeKnobs(names_2[i][j], minVals_2[i][j], maxVals_2[i][j], initVals_2[i][j], width*11/16 + j*width/8 - 25, height/8, white, in_rainbows[i+1], white,ticks, snap);
        knobs_juice.add(
          knob
          );
         ticks = 1;
         snap=false;
      }
      break;
    case 1:
      for (int j = 0; j<4; j++) {
        if(j==1 || j== 2){
        ticks = 31;
        snap = true;
        }
        if(j == 3){
        ticks = 20;
        snap = true;
        }
        Knob knob = makeKnobs(names_1[i][j], minVals_1[i][j], maxVals_1[i][j], initVals_1[i][j], width/16 + i*width/8 - 25, 80 + j*80, black, colorsSwitch[i], white, ticks,snap);
        knobs_supercollider.add(
          knob
          );     
      }
      for (int j = 0; j<3; j++) {
          Knob knob = makeKnobs(names_2[i][j], minVals_2[i][j], maxVals_2[i][j], initVals_2[i][j], width*11/16 + j*width/8 - 25,height*3/8,white, in_rainbows[i+1], white,1,false);
        knobs_juice.add(
          knob
          );
      }
      break;
    case 2:
      for (int j = 0; j<4; j++) {
        switch(j){
        case 0:
          ticks = 1;
          snap = false;
        break;
        case 1:
            ticks = 31;
           snap = true;
        break;
        case 2:
           ticks = 20;
           snap = true;
        break;
        case 3:
            ticks = 9;
            snap = true;
        break;
        }

        Knob knob = makeKnobs(names_1[i][j], minVals_1[i][j], maxVals_1[i][j], initVals_1[i][j], width/16 + i*width/8 - 25, 80 + j*80, black, colorsSwitch[i], white,ticks,snap);
        knobs_supercollider.add(
          knob
          );
      }
      for (int j = 0; j<3; j++) {
        Knob knob = makeKnobs(names_2[i][j], minVals_2[i][j], maxVals_2[i][j], initVals_2[i][j], width*11/16 + j*width/8 - 25, height*9/16, white, in_rainbows[i+1], white,1,false);
        knobs_juice.add(
          knob
          );
      }
      break;
    case 3:
      for (int j = 0; j<4; j++) {
        ticks=1;
        snap=false;
        if(j==0){
          ticks=31;
          snap=true;
      }
        Knob knob = makeKnobs(names_1[i][j], minVals_1[i][j], maxVals_1[i][j], initVals_1[i][j], width/16 + i*width/8 - 25, 80 + j*80, black, colorsSwitch[i], black,ticks,snap);
        knobs_supercollider.add(
          knob
          );
      }
      for (int j = 0; j<2; j++) {
        Knob knob = makeKnobs(names_2[i][j], minVals_2[i][j], maxVals_2[i][j], initVals_2[i][j], width*12/16 + j*width/8 - 25, height*6/8, white, in_rainbows[4], white,1, false);
        knobs_juice.add(
          knob
          );
      }
      break;
    }
    rectMode(CORNER);
    fill(colors[i]);
    rect(i * width/8, 0, width/8, height*5/8);
  };
  for (int i = 0; i <3; i++) {
    sliders.add(cp5.addSlider2D("Name"+i)
      .setPosition(width/20+i*width/6, height*11/16)
      .setMinMax(0, 0, 100, 100)
      .setSize(100, 150)
      .setColorBackground(0xff7d3c98)
      );
  };


  fill(241, 203, 255);
  rect(0, height*5/8, width/2, height);
  fill(255, 40, 52);
  rect(width/2, 0, width/8, height);
  fill(40);
  rect(width*5/8, 0, width, height);
  fill(70, 134, 199);
  textSize(20);
  textAlign(CENTER);
  text("Folder&Distortion", width*13/16, height/16);
  text("Flanger", width*13/16, height*5/16);
  smooth();
  
  oldZ = 0;
}

void draw() {
  // message for supercollider
  OscMessage myMessage = new OscMessage("/vars");
  for (int i = 0; i < knobs_supercollider.size(); i++) {
    Knob singleKnob = knobs_supercollider.get(i);
    float value = singleKnob.getValue();
    myMessage.add(value);
  }
  oscP5.send(myMessage, myRemoteLocation);
}

public Knob makeKnobs(String name, float minimum_val, float maximum_val, float initial_val, float x_pos, float y_pos,
  int color_label, int color_background, int color_value, int tick_marks, boolean snap) {

  Knob knob = cp5.addKnob(name)
    .setRange(minimum_val, maximum_val)
    .setValue(initial_val)
    .setPosition(x_pos, y_pos)
    .setRadius(25)
    .setColorLabel(color_label)
    .setViewStyle(Knob.ELLIPSE)
    .setDragDirection(Knob.VERTICAL)
    .setColorBackground(color_background)
    .setColorForeground(white)
    .setColorActive(white)
    .setColorValue(color_value)
    .setNumberOfTickMarks(tick_marks)
    .snapToTickMarks(snap)
    .hideTickMarks();

  return knob;
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: " + theOscMessage.addrPattern());
  println(" X: " + theOscMessage.get(0).floatValue() + " Y: " + theOscMessage.get(1).floatValue() + " Z: " + theOscMessage.get(2).floatValue());
  x = theOscMessage.get(0).floatValue();
  y = theOscMessage.get(1).floatValue();
  z = theOscMessage.get(2).floatValue();
  // we check if there is a transition from 0 to 1 (release part of the pressing stage)
  // of the z value of the joystick so we can detect when the button is pressed
  if (oldZ < 0.5f && z > 0.5f){
    slider_select = (slider_select + 1) % 4;
    oldZ = 1;
  }else if(oldZ > 0.5f && z < 0.5f){
    oldZ = 0;
  }
  
  if(slider_select != 3){
    Slider2D curr_slider = sliders.get(slider_select);
    float minX = curr_slider.getMinX();
    float maxX = curr_slider.getMaxX();
    
    float minY = curr_slider.getMinY();
    float maxY = curr_slider.getMaxY();
    curr_slider.setValue(map_interval(x, minX, maxX), maxY-map_interval(y, minY, maxY));
  }
}

public float map_interval(float n, float min, float max){
  float mapped_n = ((max - min) * n) + min;
  mapped_n *= 100;
  mapped_n = round(mapped_n);
  mapped_n /= 100;
  
  return mapped_n;
}
