/* @pjs preload="emotions.txt","emotionsHex.txt","input.pde; */
import org.gicentre.handy.*;

// Global Variables
HandyRenderer h1, h2;
String[] colors = new String[16];
int[] r = new int [16];
int[] g = new int [16];
int[] b = new int [16];

void setup() {
  size(640, 640);
  // Set up watercolor and colored pencil effects
  h1 = HandyPresets.createWaterAndInk(this);
  h2 = HandyPresets.createColouredPencil(this);
  h1.setOverrideFillColour(true);
  h1.setOverrideStrokeColour(true);
  h2.setOverrideFillColour(true);
  h2.setOverrideStrokeColour(true);
  background(0);
  ellipse(320, 320, 600,600);
  int colorNum = -1;
  // Ask user for emotion
  String emotion = getString("Enter emotion: ");
  // Load emotions file and check is there's a match
  String[] lines = loadStrings("emotions.txt");
  for (int i = 0 ; i < lines.length; i++) {
    if (emotion.equals(lines[i])){
      colorNum = i;
    }
  }
  if(colorNum >= 0){
    // Get colors for that emotion
    String[] loadcolors = loadStrings("emotionsHex.txt");
    String listOfColors = loadcolors[colorNum];
    int count = 0;
    for(int i = 0; i < 112; i= i+7){
      colors[count] = listOfColors.substring(i, i+7);
      count = count + 1;
    }
    // Convert all r values
    for(int i = 0; i < colors.length; i++){
      r[i] = (unhex(colors[i].substring(1, 3)));
    }
    // Convert all g values
    for(int i = 0; i < colors.length; i++){
      g[i] = (unhex(colors[i].substring(3, 5)));
    }
    // Convert all b values
    for(int i = 0; i < colors.length; i++){
      b[i] = (unhex(colors[i].substring(5, 7)));
    }
  }
  else{
    print("Sorry, invalid input. Please run again and pick an emotion from the list.");
    exit();
  }
}

void draw() {
  variableCircle(mouseX, mouseY, pmouseX, pmouseY);
  //save("myEmotionSketch" + user + ".jpg");
}


void variableCircle(int x, int y, int px, int py) {
  // Check to see if the mouse position is in the circle
  float disX = 320 - x;
  float disY = 320 - y;
  // If it is, add circle of random size 
  if(sqrt(sq(disX) + sq(disY)) < 270){
    float randRadius = random(1, 100);
    // Opacity 
    int t = int(random(0, 255));
    // Random color
    int fillColorNum = int(random(colors.length));
    int red = r[fillColorNum];
    int blue = b[fillColorNum];
    int green = g[fillColorNum];
    // If opacity greater than 100, use watercolor effect
    if(t > 100){
      h1.setFillColour(color(red, green, blue, t));
      h1.setStrokeColour(color(red, green, blue, t));
      h1.ellipse(x, y, randRadius, randRadius);
    }
    // Else, use colored pencil effect
    else{
      h2.setFillColour(color(red, green, blue, t));
      h2.setStrokeColour(color(red, green, blue, t));
      h2.ellipse(x, y, randRadius, randRadius);
    }
  }
}
