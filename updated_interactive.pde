import org.gicentre.handy.*;

// Global Variables
HandyRenderer h1, h2;
String[] colors = new String[16];
String[] loadcolors;
String listOfColors;
String [] lines;
Boolean [] whichEmotion = new Boolean[21];
String emotion;
int colorNum = -1;
int[] r = new int [16];
int[] g = new int [16];
int[] b = new int [16];

void setup() {
  size(1200, 1000);
  // Set up watercolor and colored pencil effects
  h1 = HandyPresets.createWaterAndInk(this);
  h2 = HandyPresets.createColouredPencil(this);
  h1.setOverrideFillColour(true);
  h1.setOverrideStrokeColour(true);
  h2.setOverrideFillColour(true);
  h2.setOverrideStrokeColour(true);
  background(0);
  // Load emotions file and check is there's a match
  lines = loadStrings("emotions.txt");
  ellipse(850, 380, 600, 600);
  rect(1050, 700, 100, 50);
  textSize(35);
  fill(#000000);
  text("clear", 1062, 735);
  for(int i = 0; i < 20; i++){
    whichEmotion[i] = false;
  }
  emotionText();
}
void emotionText(){
  for(int i = 0; i < 10; i++){
    fill(#ffffff);
    textSize(35);
    String word = lines[i];
    if (whichEmotion[i]){
      fill(#ffb6c1);
    }
    text(word, 40, i*50 + 200);
  }
  for(int i = 10; i < 20; i++){
    fill(#ffffff);
    textSize(35);
    String word = lines[i];
    if (whichEmotion[i]){
      fill(#ffb6c1);
    }
    text(word, 250, (i- 10)*50 + 200); 
  }
}
void draw() {
  variableCircle(mouseX, mouseY);
}

void mouseReleased(){
    print(mouseX);
    print(mouseY);
    print("\n");
    int x = mouseX;
    int y = mouseY;
    if(x >= 40 && x <= 135  && y >= 175 && y <= 200){
      emotion = "happy";
    }
    else if(x >= 40 && x <= 100 && y >= 225 && y <= 250){
      emotion = "sad";
    }
    else if(x >= 40 && x <= 135 && y >= 275 && y <= 310){
      emotion = "angry";
    }
    else if(x >= 40 && x <= 160 && y >= 330 && y <= 350){
      emotion = "nervous";
    }
    else if(x >= 40 && x <= 185 && y >= 375 && y <= 400){
      emotion = "disgusted";
    }
    else if(x >= 40 && x <= 130 && y >= 425 && y <= 450){
      emotion = "bored";
    }
    else if(x >= 40 && x <= 130 && y >= 470 && y <= 505){
      emotion = "afraid";
    }
    else if(x >= 40 && x <= 140 && y >= 530 && y <= 550){
      emotion = "shame";
    }
    else if(x >= 40 && x <= 185 && y >= 580 && y <= 600){
      emotion = "contempt";
    }
    else if(x >= 40 && x <= 195 && y >= 625 && y <= 655){
      emotion = "interested";
    }
    else if(x >= 250 && x <= 395 && y >= 175 && y <= 200){
      emotion = "surprised";
    }
    else if(x >= 250 && x <= 315 && y >= 225 && y <= 250){
      emotion = "love";
    }
    else if(x >= 250 && x <= 325 && y >= 275 && y <= 305){
      emotion = "grief";
    }
    else if(x >= 250 && x <= 375 && y >= 325 && y <= 350){
      emotion = "inspired";
    }
    else if(x >= 250 && x <= 345 && y >= 380 && y <= 405){
      emotion = "guilty";
    }
    else if(x >= 250 && x <= 390 && y >= 430 && y <= 455){
      emotion = "confused";
    }
    else if(x >= 250 && x <= 445 && y >= 475 && y <= 500){
      emotion = "disappointed";
    }
    else if(x >= 250 && x <= 345 && y >= 525 && y <= 550){
      emotion = "lonely";
    }
    else if(x >= 250 && x <= 365 && y >= 580 && y <= 600){
      emotion = "anxious";
    }
    else if(x >= 250 && x <= 405 && y >= 630 && y <= 650){
      emotion = "distracted";
    }
    else{
      emotion = "default";
    }
    for (int i = 0 ; i < lines.length; i++) {
      if (emotion.equals(lines[i])){
        colorNum = i;
      }
    }
    whichEmotion[colorNum] = true;
    emotionText();
    for(int i = 0; i < 20; i++){
    whichEmotion[i] = false;
    }
    if(colorNum >= 0){
      // Get colors for that emotion
      loadcolors = loadStrings("emotionsHex.txt");
      listOfColors = loadcolors[colorNum];
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
    if(x >= 1050 && x <= 1150 && y >= 700 && y <= 750){
      fill(#000000);
      rect(500, 0, 1000, 1000);
      fill(#ffffff);
      ellipse(850, 380, 600, 600);
      rect(1050, 700, 100, 50);
      textSize(35);
      fill(#000000);
      text("clear", 1062, 735);
      
    }
  }


void variableCircle(int x, int y) {
  // Check to see if the mouse position is in the circle
  float disX = 850 - x;
  float disY = 380 - y;
  // If it is, add circle of random size 
  if(sqrt(sq(disX) + sq(disY)) < 270){
    float randRadius = random(1, 90);
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
