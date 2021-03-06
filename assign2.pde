PImage titleImg;
PImage startHoveredImg;
PImage startNormalImg;
PImage bgImg;
PImage soilImg;
PImage firstLifeImg;
PImage secondLifeImg;
PImage thirdLifeImg;
PImage groundhogIdleImg;
PImage groundhogDownImg;
PImage groundhogLeftImg;
PImage groundhogRightImg;
PImage soldierImg;
PImage cabbageImg;
PImage gameoverImg;
PImage restartHoveredImg;
PImage restartNormalImg;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_LOSE = 2;
final int GET_SCCORE = 3;
final int LOST_SCCORE = 4;
int gameState = GAME_START;

final int BUTTON_TOP = 360;
final int BUTTON_BOTTOM = 420;
final int BUTTON_LEFT = 248;
final int BUTTON_RIGHT = 392;

boolean upPressed, downPressed, rightPressed, leftPressed;

int lifeAmount = 2;
int cabbageX;
int cabbageY;
float soldierX = 40;
float soldierY;
float groundhogX;
float groundhogY;
float groundhogSpeed = 5;
float groundhogWidth = 80;
float groundhogHeight = 80;


void setup() {
  
  size(640, 480);
  
  titleImg = loadImage("img/title.jpg");
  startHoveredImg = loadImage("img/startHovered.png");
  startNormalImg = loadImage("img/startNormal.png");
  bgImg = loadImage("img/bg.jpg");
  soilImg = loadImage("img/soil.png");
  firstLifeImg = loadImage("img/life.png");
  secondLifeImg = loadImage("img/life.png");
  thirdLifeImg = loadImage("img/life.png");
  groundhogIdleImg = loadImage("img/groundhogIdle.png");
  groundhogDownImg = loadImage("img/groundhogDown.png");
  groundhogLeftImg = loadImage("img/groundhogLeft.png");
  groundhogRightImg = loadImage("img/groundhogRight.png");
  soldierImg = loadImage("img/soldier.png");
  cabbageImg = loadImage("img/cabbage.png");
  gameoverImg = loadImage("img/gameover.jpg");
  restartHoveredImg = loadImage("img/restartHovered.png");
  restartNormalImg = loadImage("img/restartNormal.png");
  
  soldierY = floor(random(2,6))*80;
  cabbageX = floor(random(0,8))*80;
  cabbageY = floor(random(2,6))*80;
  groundhogX = 320;
  groundhogY = 80;
  
}

void draw() {
  image(titleImg,0,0);
  image(startNormalImg,248,360);
  
  switch(gameState){
    case GAME_START:
      if(mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM){
        image(startHoveredImg,248,360);
        if(mousePressed)gameState = GAME_RUN;
      }else{
        image(startNormalImg,248,360);
      }
    break;
    
    case GAME_RUN:
    
      image(bgImg,0,0);
      image(firstLifeImg,10,10);
      image(secondLifeImg,80,10);
      image(thirdLifeImg,150,10);
      image(soilImg,0,160);
      image(cabbageImg,cabbageX,cabbageY);
      
      
      //grass
      noStroke();
      colorMode(RGB);
      fill(124,204,25);//green
      rect(0,145,640,15);
      
      //sun
      stroke(255,255,0);//yellow
      strokeWeight(5);
      fill(253,184,19);//orange
      ellipse(590,50,120,120);
      
      
      
      //soldier
      image(soldierImg,soldierX,soldierY);
      soldierX += 3;
      if(soldierX >= 640){
        soldierX = -80;
      }
      
      //cabbage
      if(cabbageX == groundhogX && cabbageY == groundhogY){
        cabbageX = -cabbageX;
        lifeAmount = lifeAmount +1;
        
      }
      
      //groundhog
      image(groundhogIdleImg,groundhogX,groundhogY);
      
      if(downPressed){
        image(groundhogDownImg,groundhogX,groundhogY);
        groundhogY += groundhogSpeed;
        if(groundhogY + groundhogWidth > height) {
          groundhogY = height - groundhogWidth;
        }
      }
      if(leftPressed){
        image(groundhogLeftImg,groundhogX,groundhogY);
        groundhogX -= groundhogSpeed;
        if(groundhogX < 0) {
          groundhogX = 0;
        }
      }
      if(rightPressed){
        image(groundhogRightImg,groundhogX,groundhogY);
        groundhogX += groundhogSpeed;
        if(groundhogX + groundhogWidth > width) {
          groundhogX = width - groundhogWidth;
        }
      }
      
      //groundhog and soldier
      if(groundhogX < soldierX +80 && groundhogX +80 > soldierX 
      && groundhogY < soldierY +80 && groundhogY +80 > soldierY){
        groundhogX = 320;
        groundhogY = 80;
        gameState = GAME_RUN;
        lifeAmount = lifeAmount-1;
      }
        
      
     
    break;
    
    
    case GAME_LOSE:
      
      image(gameoverImg,0,0);
      if(mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM){
        image(restartHoveredImg,248,360);
        if(mousePressed)gameState = GAME_RUN;
      }else{
        image(restartNormalImg,248,360);
      }
      
  } 
    
}


void keyPressed(){
  switch(keyCode){
    case DOWN:
    downPressed = true;
    break;
    case RIGHT:
    rightPressed = true;
    break;
    case LEFT:
    leftPressed = true;
    break;
  }
}

void keyReleased(){
  switch(keyCode){
    case DOWN:
    downPressed = false;
    if(groundhogY % 80 != 0){
      groundhogY = (floor(groundhogY / 80)+1)*80;
    }
    break;
    case RIGHT:
    rightPressed = false;
    if(groundhogX % 80 != 0){
      groundhogX = (floor(groundhogX / 80)+1)*80;
    }
    break;
    case LEFT:
    leftPressed = false;
    if(groundhogX % 80 != 0){
      groundhogX = floor(groundhogX / 80)*80;
    }
    break;
  }
}
