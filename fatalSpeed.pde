import ddf.minim.*;  
Minim minim;
AudioPlayer player1;
AudioPlayer player2;
AudioPlayer player3;//background music
int stage=0;
int life=3;// player's life
int time=0;// count time
int time1, time2;
int score=0;//count score;
int lasernum=2;
int b, d;// time delay
int e;
int[] w=new int [5];//buttom width
int[] h=new int [5];//button height
PImage welcome;// welcome page
PImage gameOver;//game over page
PImage youWin;//you win page
PImage instructionBac;// instruction background
PImage instructiontext;//instruction text
PImage start;// buttons
PImage instruction;
PImage exit;
PImage restart;
PImage back;
PImage bac;// game play background
PImage car, car1;// player's car
PImage car3, car4, car5;// car block and crossing car
PImage roadblock;//roadblock
PImage firstaid;
boolean notice=false;// whether display notice
float x1=350;//player's position
float y=900;
float y7=0;//background position
float[] y1=new float[4];// central lines position
float spe=5;//player's car speed
float spe1;
float v=2;
float x2[]= {
};
float y2[]= {
};// car block position
float x3[]= {
};// car block original position
float dx[]= {
};//car block horizontal speed
float x4[]= {
};
float y3[]= {
};//roadblock position
float y4[]= {
};//cross road position
float x5[]= {
};
float x6[]= {
};
float y5[]= {
};
float y6[]= {
};// crossing cars' position
float x7, y8;
boolean[] life1=new boolean[70];// whether these blocks are shown
boolean[] life2=new boolean[40];
boolean[] life3=new boolean[20];
boolean[] life4=new boolean[20];
boolean life5=true;
boolean pause= false;
boolean laser=false;
boolean flash=false;
void setup() {
  size(800, 1000);
  welcome=loadImage("welcomepage.jpg");
  gameOver=loadImage("gameoverPage.jpg");
  youWin=loadImage("youWin.jpg");
  instructionBac=loadImage("instructionBac.jpg");
  instructiontext=loadImage("instructionPage.png");
  start=loadImage("start.png");
  instruction=loadImage("instruction.png");
  exit=loadImage("exit.png");
  restart=loadImage("restart.png");
  back=loadImage("back.png");
  bac=loadImage("background.jpg");
  car=loadImage("car.png");
  car1=loadImage("car.png");
  car3=loadImage("car3.png");
  car4=loadImage("car4.png");
  car5=loadImage("car5.png");
  roadblock=loadImage("roadblock.png");
  firstaid=loadImage("firstaid.jpg");
  minim = new Minim(this); 
  player1 = minim.loadFile("background.mp3");
  player2 = minim.loadFile("bump.mp3");
  player3 = minim.loadFile("gameOver.mp3"); 
  for (int i=0; i<4; i++) {
    y1[i]=250*i;
  } // set original position of central lines  
  for (int i=0; i<5; i++) {
    w[i]=150;
    h[i]=60;
  }// set original size of buttons
  e=int(random(0,9000));
  x7=random(100, 620);
  y8=-1000;
}
void draw() {
  if (stage==0) {  //welcome page
    image(welcome, 0, 0, 800, 1000);
    image(start, 325, 670, w[0], h[0]);
    image(instruction, 325, 750, w[1], h[1]);
    image(exit, 325, 830, w[2], h[2]);
    if (mouseX>325&&mouseX<475&&mouseY>670&&mouseY<730) 
    {
      enlarge(0);
    } else if (mouseX>325&&mouseX<475&&mouseY>750&&mouseY<810) 
    {
      enlarge(1);
    } else if (mouseX>325&&mouseX<475&&mouseY>830&&mouseY<890) 
    {
      enlarge(2);  // enlarge the buttons if mouse is in their areas
    } else {
      shrink(); // otherwise, display original size
    }
    if (mousePressed==true&&mouseX>325&&mouseX<505&&mouseY>670&&mouseY<742) {
      stage=2;// move to game play
    } else if (mousePressed==true&&mouseX>325&&mouseX<505&&mouseY>750&&mouseY<822) {
      stage=1;// move to instruction
    } else if (mousePressed==true&&mouseX>325&&mouseX<505&&mouseY>830&&mouseY<902) {
      exit();//exit
    }
  } else if (stage==1) { //instruction
    image(instructionBac, 0, 0, 800, 1000);
    image(instructiontext, 10, 10, 780, 1000);
    image(back, 50, 830, w[3], h[3]);
    if (mouseX>50&&mouseX<200&&mouseY>830&&mouseY<890) 
    {
      enlarge(3);  // enlarge the buttons if mouse is in their areas
    } else {
      shrink(); //otherwise, display original size
    } 
    if (mousePressed==true&&mouseX>50&&mouseX<230&&mouseY>830&&mouseY<902) {
      stage=0;// back to welcome page
    }
  } else if (stage==2) {//game play
    player3.pause();
    image(bac, 0, y7, 800, 1000);
    image(bac, 0, y7-1000, 800, 1000);
    y7=y7+spe;
    if (y7>1000) {
      y7=0;
    }//movable background
    fill(4, 13, 31);
    rect(100, 0, 600, 1000);// draw the road
    strokeWeight(5);
    fill(223, 228, 240);
    rect(75, 0, 25, 1000);
    rect(700, 0, 25, 1000);//draw the edge of road
    noStroke();
    fill(255);
    for (int i=0; i<4; i++) {
      rect(385, y1[i], 30, 125);
      y1[i]=y1[i]+spe;
      if (y1[i]>1000) {
        y1[i]=0;
      }
    }// display central lines
    for (int i=0; i<x5.length; i++) {
      fill(4, 13, 31);
      rect(0, y4[i], 800, 230);
      y4[i]=y4[i]+spe;
    }// display crossing roads
    if (time>e&&life5==true) {
      image(firstaid, x7, y8, 80, 80);
      y8=y8+spe;
    }
    for (int i=0; i<x4.length; i++) {
      if (life2[i]==true) {
        image(roadblock, x4[i], y3[i], 100, 50);
        y3[i]=y3[i]+spe;
      }  //display roadblocks
      if (x1+100>x4[i]&&x1<x4[i]+100&&y+130>y3[i]&&y<y3[i]+50&&life2[i]==true) {
        life=life-1;
        life2[i]=false;
        score=score-500;
        player2.rewind();
        player2.play();
        time2=time;
        flash=true;
      }//if bump into roadblocks, life minus one, score minus 500, play bump sound
    }
    for (int i=0; i<dx.length; i++) {//display car blocks
      if (life1[i]==true) {
        image(car3, x2[i], y2[i], 100, 130);      
        if (pause==false) {
          x2[i]=x2[i]+dx[i];
          y2[i]=y2[i]+spe-3;
        } else {
          x2[i]=x2[i];
          y2[i]=y2[i];
        }
        if (x2[i]<x3[i]-50) {// horizontal boundness of car blocks
          x2[i]=x3[i]-50;
          dx[i]=-dx[i];
        } else if (x2[i]>x3[i]+50) {
          x2[i]=x3[i]+50;
          dx[i]=-dx[i];
        }
        if (x2[i]<100) {
          x2[i]=100;
          dx[i]=-dx[i];
        } else if (x2[i]>600) {
          x2[i]=600;
          dx[i]=-dx[i];
        }
      }
      if (x1+100>x2[i]&&x1<x2[i]+100&&y+130>y2[i]&&y<y2[i]+130&&life1[i]==true) {
        life=life-1;
        life1[i]=false;
        score=score-500;
        player2.rewind();
        player2.play();
        time2=time;
        flash=true;
      }//if bump into car blocks, life minus one, score minus 500, play bump sound
    }
    for (int i=0; i<x5.length; i++) {
      if (life3[i]==true) {
        image(car4, x5[i], y5[i], 130, 100);
        x5[i]=x5[i]+spe/2+spe%2;
        y5[i]=y5[i]+spe;
      }
      if (life4[i]==true) {
        image(car5, x6[i], y6[i], 130, 100);
        x6[i]=x6[i]-spe/2-spe%2;
        y6[i]=y6[i]+spe;
      }//display two crossing cars on crossroad
      if (x1+100>x5[i]&&x1<x5[i]+130&&y+130>y5[i]&&y<y5[i]+100&&life3[i]==true) {
        life=life-1;
        life3[i]=false;
        score=score-500;
        player2.rewind();
        player2.play();
        time2=time;
        flash=true;
      }
      if (x1+100>x6[i]&&x1<x6[i]+130&&y+130>y6[i]&&y<y6[i]+100&&life4[i]==true) {
        life=life-1;
        life4[i]=false;
        score=score-500;
        player2.rewind();
        player2.play();
        time2=time;
        flash=true;
      }//if bump into crossing car, life minus one, score minus 500, play bump sound
    }
    if (flash==true) {
      flash();
      image(car, x1, y, 100, 130);// display player's car
    } else {
      image(car1, x1, y, 100, 130);// display player's car
    }
    if (time%300==0&&time>=300) {// generate new car blocks every 5 seconds
      for (int i=0; i<int (random (0, 3)); i++) { 
        float x= random(100, 600);
        x2=append(x2, x);
        x3=append(x3, x);
        y2=append(y2, -200*i);
        if (int(random(0, 2))==0) {
          dx= append(dx, 0.5);
        } else {
          dx= append(dx, -0.5);
        }// random horizontal speed
        life1[dx.length-1]= true;
      }
    }
    if (time%1200==0&&time>0) {
      b=int(random(0, 360));
    }// generate time delay of roadblocks
    if (time%1200==b&&time>=1200) {//generate new roadblocks every 20s after time delay
      for (int i=0; i<int (random (1, 3)); i++) { 
        x4=append(x4, random(100, 600));
        y3=append(y3, -1000*i);
      }
      life2[x4.length-1]=true;
    }
    if (time%1800==0&&time>0) {
      d=int(random(0, 360));
    }// generate time delay of crossroads
    if (time%1800==d&&time>=1800) {//generate new crossroads and crossing cars every 30s after time delay
      x5=append(x5, -630);
      x6=append(x6, 1300);
      y4=append(y4, -1000);
      y5=append(y5, -990);
      y6=append(y6, -880);
      life3[x5.length-1]=true;
      life4[x5.length-1]=true;
    }

    if (x1+100>x7&&x1<x7+80&&y+130>y8&&y<y8+80&&life5==true) {
      life=life+1;
      life5=false;
      score=score+2000;
      player2.rewind();
      player2.play();
      time2=time;
      flash=true;
    }

    if (time%1200>b&&time%1200<b+300&time>1200) {
      notice=true;
    } else if (time%1800>d&&time%1800<d+300&&time>1800) {
      notice=true;
    } else if (time>e&&time<e+300) {
      notice=true;
    } else {
      notice=false;
    }
    if (notice==true) {
      notice();
    }// display notice sign when new roadblocks or crossroad are generated 

    if (pause==false) {
      spe=spe+0.00185;  //speed increases to 15(300km/h) in 90s
      if (spe>15) {
        spe=15;
      }
      score=score+1;//count score
      time=time+1;//count time
      player1.play();
    } else {
      spe=0;
      v=0;
      player1.pause();
      textSize(50);
      fill(255, 0, 0);
      text("Pause", 320, 525);
    } 
    if (laser==true) {
      laser();
    }

    parameter();//display fuel, speed, score and life at top lift corner 
    control();// key control
    if (life==0) {//game over
      player1.pause();
      stage=3;
      player3.rewind();
    } else if (time>9000) {// survive after 150s, you win;'d' for demon
      player1.pause();
      stage=4;
    } else if (keyPressed==true&&key=='d') {
      player1.pause();
      stage=4;
    }
  } else if (stage==3) {// game over page
    image(gameOver, 0, 0, 800, 1000);
    textSize(50);
    fill(255, 0, 0);
    text("Your score is:", 230, 500);
    text(score, 230, 600);
    player3.play();// play car accident sound
    restart();
  } else if (stage==4) {// car gradually stops
    image(bac, 0, y7, 800, 1000);
    image(bac, 0, y7-1000, 800, 1000);
    y7=y7+spe;
    if (y7>1000) {
      y7=0;
    }
    fill(4, 13, 31);
    rect(100, 0, 600, 1000);
    strokeWeight(5);
    fill(223, 228, 240);
    rect(75, 0, 25, 1000);
    rect(700, 0, 25, 1000);
    noStroke();
    fill(255);
    for (int i=0; i<4; i++) {
      rect(385, y1[i], 30, 125);
      y1[i]=y1[i]+spe;
      if (y1[i]>1000) {
        y1[i]=0;
      }
    }
    image(car, x1, y, 100, 130);
    spe=spe-0.025;
    if (spe<=0) {
      stage=5;
    }
  } else if (stage==5) {// you win page
    image(youWin, 0, 0, 800, 1000);
    textSize(50);
    fill(255, 0, 0);
    text("Your score is:", 230, 500);
    text(score, 230, 600);
    restart();
  }
  //println(time/60, dx.length, x4.length, x5.length, notice, life, score, spe, stage, flash);
}

void notice() {// draw notice sign at top right corner
  fill(255, 0, 0);
  textSize(30);
  text("!!!!", 680, 40);
}
void stop() {//necessary function for music
  player1.close();
  player2.close();
  player3.close();
  minim.stop();
}
void parameter() {//display fuel, speed, score and life at top lift corner
  fill(250, 0, 0);
  textSize(30);
  if (pause==false) {
    text("Speed:"+int(spe*20)+"km/h", 10, 40);
  } else {
    text("Speed:"+int(spe1*20)+"km/h", 10, 40);
  }
  text("Fuel:"+int((9000-time)/900)+"L", 10, 80);
  text("Score:"+score, 10, 120);
  text("Life:"+life, 10, 900);
  text("Laser:"+lasernum, 10, 940);
}
void control() {// key control
  if (keyPressed==true) { 
    if (key=='p'&& pause==false) {
      spe1=spe;
      pause=true;
    } else if (key=='p'&& pause==true) {
      spe=spe1;
      pause=false;
    } 
    if (pause==false) {
      if (keyCode==LEFT) {
        x1=x1-2;
      } else if (keyCode==RIGHT) {
        x1=x1+2;
      } else if (keyCode==UP) {
        y=y-2;
      } else if (keyCode==DOWN) {
        y=y+2;
      }
      if (x1<100) {
        x1=100;
      } else if (x1>600) {
        x1=600;
      } 
      if (y<770) {
        y=770;
      } else if (y>900) {
        y=900;
      }
      if (key=='l'&&lasernum>0&&laser==false) {
        laser(); 
        laser=true;
        lasernum=lasernum-1;
        time1=time;
      }
    }
  }
}
void enlarge(int a) {// enlarge the buttons 
  w[a]=180;
  h[a]=72;
}
void shrink() {// shrink to original size
  for (int i=0; i<5; i++) {
    w[i]=150;
    h[i]=60;
  }
}
void laser() {
  if (time-time1<=300) {
    fill(255, 0, 0);
    rect(x1+45, 0, 10, y);
    for (int i=0; i<x2.length; i++) {
      if (x1+55>x2[i]&&x1+45<x2[i]+100&&y2[i]+130>0&&y2[i]+130<y&&life1[i]==true) {
        life1[i]=false;
        player2.rewind();
        player2.play();
      }
    }
    for (int i=0; i<x4.length; i++) {
      if (x1+55>x4[i]&&x1+45<x4[i]+100&&y3[i]+50>0&&y3[i]+50<y&&life2[i]==true) {
        life2[i]=false;
        player2.rewind();
        player2.play();
      }
    }
    for (int i=0; i<x5.length; i++) {
      if (x1+55>x5[i]&&x1+45<x5[i]+130&&y5[i]+100>0&&y5[i]+100<y&&life3[i]==true) {
        life3[i]=false;
        player2.rewind();
        player2.play();
      }
    }
    for (int i=0; i<x6.length; i++) {
      if (x1+55>x6[i]&&x1+45<x6[i]+130&&y6[i]+100>0&&y6[i]+100<y&&life4[i]==true) {
        life4[i]=false;
        player2.rewind();
        player2.play();
      }
    }
  } else {
    laser=false;
  }
}
void restart() {
  image(restart, 325, 670, w[4], h[4]);
  image(exit, 325, 750, w[2], h[2]);
  for (int i=0; i<dx.length; i++) { 
    x2= shorten(x2);
    x3= shorten(x3);
    y2= shorten(y2);
    dx= shorten(dx);
  }
  for (int i=0; i<x4.length; i++) {
    x4= shorten(x4);
    y3= shorten(y3);
  }
  for (int i=0; i<x5.length; i++) {
    x5= shorten(x5);
    x6= shorten(x6);
    y4= shorten(y4);
    y5= shorten(y5);
    y6= shorten(y6);
  }// clear all data of blocks
  for (int i=0; i<4; i++) {
    y1[i]=250*i;
  }// reset central line position
  laser=false;
  flash=false;
  life=3;
  life5=true;
  lasernum=2;
  time=0;
  spe=5;
  x1=350;
  y=900;
  y7=0;// reset values
    e=int(random(0,9000));
  x7=random(100, 620);
  y8=-1000;
  player1.rewind();
  if (mouseX>325&&mouseX<475&&mouseY>670&&mouseY<730) 
  {
    enlarge(4);
  } else if (mouseX>325&&mouseX<475&&mouseY>750&&mouseY<810) 
  {
    enlarge(2);
  } else {
    shrink();
  }
  if (mousePressed==true&&mouseX>325&&mouseX<505&&mouseY>670&&mouseY<742) {// restart game
    score=0;
    stage=2;
  } else if (mousePressed==true&&mouseX>325&&mouseX<505&&mouseY>750&&mouseY<822) {
    exit();//exit the game
  }
}
void flash() {
  if (time-time2<180) {
    for (int i=0; i<255; i++) {
      for (int j=0; j<550; j++) {
        float r=red(car.get(i, j));
        float g=green(car.get(i, j));
        float b=blue(car.get(i, j));
        float c=(r+g+b)/3;
        if (c>=255) {
          v=-2;
        } else if (c<=0) {
          v=2;
        } 
        c=c+v;
        car.set(i, j, color(c));
      }
    }
  } else {
    flash=false;
  }
}

