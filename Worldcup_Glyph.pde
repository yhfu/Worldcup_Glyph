
ArrayList<PImage> flags;

ArrayList<PImage> flagswin;
ArrayList<PImage> flagsrun;
ArrayList<PImage> flagsthird;

ArrayList<PShape> countrySVG;
int k = 0;
// Overall data for world cup
float[] x= new float[21];
float[] y= new float[21];
String[] countryNames = new String[21];
float[] pop = new float[21];
String[] year = new String[21];
float[] team = new float[21];
float[] venue = new float[21];
float[] matches = new float[21];
float[] goals = new float[21];
float[] goalpermatch = new float[21];
float[] att = new float[21];
float[] attLow = new float[21];
float[] attHigh = new float[21];
String[] winners = new String[21];
String[] runners = new String[21];
String[] third = new String[21];
String[] alphawinner = new String[21];
String[] alpharunner = new String[21];
String[] alphathird = new String[21];
String[] alpha3 = new String[21];

float[] temp = new float[21];

//PGraphics pg;
PImage winarc;

//Test for 1930 World Cup

void setup() {

  size(1000, 1000, P3D);

  //looping switch. Uncomment it to stop loop.
  //noLoop();

  temp[0] = 0.05;
  for (int i=1; i<temp.length; i++) {
    temp[i] = temp[i-1] + 0.05;
  }


  Table table = loadTable("WO_Overallv3.csv", "header");
  int i =0;

  //needed for map function
  int w_start = 180; //Longitude start - largest longitude value
  int w_end = -180; //Longitude end - smallest longitude value
  float h_start = 90; //Latitude start - largest latitude value
  float h_end = -90; //Latitude end - smallest latitude value


  for (TableRow row : table.rows ())
  {
    String countryName = row.getString("Host");
    float latitude = row.getFloat("Latitude");
    float longitude = row.getFloat("Longitude");
    float population = row.getFloat("Population");
    String year_ = row.getString("Year");
    int venue_ = row.getInt("# of venues");
    int matches_ = row.getInt("Matches");
    int goals_ = row.getInt("Goals");
    float attendance_ = row.getFloat("Attendance");
    float attLow_ = row.getFloat("Lowest Attendance");
    float attHigh_ = row.getFloat("Highest Attendance");
    String winners_ = row.getString("Winners");
    String runners_ = row.getString("Runners Up");
    String third_ = row.getString("Third");
    String alpha_ = row.getString("Alpha-2 code");
    String alphawinner_ = row.getString("Alpha-2 code winners");
    String alpharunner_ = row.getString("Alpha-2 code runners");
    String alphathird_ = row.getString("Alpha-2 code third");
    int team_ = row.getInt("Teams");

    countryNames[i] = countryName;
    x[i] = map(longitude, w_end, w_start, 0, width);
    y[i] = map(latitude, h_start, h_end, 0, height);
    pop[i] = population;
    year[i]= year_;
    venue[i] = float(venue_)  ;
    team[i] = team_;
    matches[i] = matches_;
    goals[i] = float(goals_);
    goalpermatch[i] = float(goals_)/float(matches_);
    att[i] = attendance_;
    attLow[i] = attLow_;
    attHigh[i] = attHigh_;
    winners[i] = winners_;
    runners[i] = runners_;
    third[i] = third_;
    alpha3[i] = alpha_;
    alphawinner[i] = alphawinner_;
    alpharunner[i] = alpharunner_;
    alphathird[i] = alphathird_;


    i++;
  }

  //load flags
  flags = new ArrayList<PImage>();
  flagswin = new ArrayList<PImage>();
  flagsrun = new ArrayList<PImage>();
  flagsthird = new ArrayList<PImage>();
  String[] alpha2 = new String[alpha3.length];
  String[] alpha2win = new String[alpha3.length];
  String[] alpha2run = new String[alpha3.length];
  String[] alpha2third = new String[alpha3.length];

  //lower case alphas
  for (int j=0; j<alpha2.length; j++)
  {

    alpha2[j] = alpha3[j].toLowerCase();
    alpha2win[j] = alphawinner[j].toLowerCase();
    alpha2run[j] = alpharunner[j].toLowerCase();
    alpha2third[j] = alphathird[j].toLowerCase();
    String flagFile = "flag_svg/circled/"+alpha2[j]+".png";
    PImage currentFlag = loadImage(flagFile);
    String flagwinFile = "flag_svg/rank/"+alpha2win[j]+".png";
    PImage currentFlag1 = loadImage(flagwinFile);
    String flagrunFile = "flag_svg/rank/"+alpha2run[j]+".png";
    PImage currentFlag2 = loadImage(flagrunFile);
    String flagthirdFile = "flag_svg/rank/"+alpha2third[j]+".png";
    PImage currentFlag3 = loadImage(flagthirdFile);
    flags.add(currentFlag);
    flagswin.add(currentFlag1);
    flagsrun.add(currentFlag2);
    flagsthird.add(currentFlag3);
  }
}

void draw() {

  //Create glyph
  // int k = 15; //first test case - declared globaly to step through years
  float angle = 2*PI/3;
  float angle1, angle2, angle3;

  //First deal with attendance, bottom half

  float lowestTA = min(att); //358000
  float highestTA = max(att);

  float totalPartialAtt = attLow[k] + attHigh[k];


  //Size of circle represents total attendance - changes between years so
  //color arc by attendance?
  background(#ffffff, 0);
  noStroke();
  fill(#ffffff, 255);
  ellipse(width/2, height/2, width, height);
  //lowest attendance
  fill(#c3ff88);
  float plus = (attLow[k]/totalPartialAtt)*2*PI/3;
  arc(width/2, height/2, width, height, PI/6, PI/6.0+plus);
  //highest attendance
  fill(83, 165, 23);
  arc(width/2, height/2, width, height, PI/6+plus, 5*PI/6);
  //arc(width/2, height/2, width, height, (attLow[k]/totalPartialAtt)*5*PI/6, (attHigh[k]/totalPartialAtt)5*PI/6);


  //Now let's deal with goals
  float  maxGoal = max(goals);
  float  maxGoalpermatch = max(goalpermatch);
  float  maxVenue = max(venue);


  noStroke();
  fill(0, 117, 183);

  //total number of goals
  arc(width/2, height/2, width, height, 5*PI/6, 5*PI/6 + (goals[k]/maxGoal)*angle);
  fill(229, 241, 248);
  arc(width/2, height/2, width, height, 5*PI/6 +(goals[k]/maxGoal)*angle, 3*PI/2);
  /*//total goals text
  pushMatrix();
  angle1 = (goals[k]/maxGoal)*angle - PI/6;
  fill(#ffffff);
  textSize(18);
  translate(width*(0.5-11*(cos(angle1- PI/38))/24), height*(0.5-11*(sin(angle1- PI/38))/24));// leave less upper space.
  rotate(angle1);
  int g1 = round(goals[k]);
  text(g1, 0, 0);
  popMatrix();*/
  //goal per match
  fill(199, 37, 32);
  arc(width/2, height/2, 2.5*width/3, 2.5*height/3, 5*PI/6, 5*PI/6 + (goalpermatch[k]/maxGoalpermatch)*angle);
  fill(249, 233, 232);
  arc(width/2, height/2, 2.5*width/3, 2.5*height/3, 5*PI/6 +(goalpermatch[k]/maxGoalpermatch)*angle, 3*PI/2);
  //goal per match text
  /*pushMatrix();
  angle2 = (goalpermatch[k]/maxGoalpermatch)*angle - PI/6;
  fill(#ffffff);
  textSize(18);
  translate(width*(0.5-9*(cos(angle2- PI/32))/24), height*(0.5-9*(sin(angle2- PI/32))/24));
  rotate(angle2);
  String g2 = nf(goalpermatch[k], 1, 1);
  text(g2, 0,0);
  popMatrix();*/
  //number of venues
  fill(244, 222, 1);
  arc(width/2, height/2, 2*width/3, 2*height/3, 5*PI/6, 5*PI/6 + (venue[k]/maxVenue)*angle);
  fill(254, 252, 229);
  arc(width/2, height/2, 2*width/3, 2*height/3, 5*PI/6 + (venue[k]/maxVenue)*angle, 3*PI/2);
  //venue text
  /*pushMatrix();
  angle3 = (venue[k]/maxVenue)*angle - PI/6;
  fill(#ffffff);
  textSize(18);
  translate(width*(0.5-7*(cos(angle3- PI/25))/24), height*(0.5-7*(sin(angle3- PI/25))/24));// leave more upper space.
  rotate(angle3);
  int g3 = round(venue[k]);
  text(g3, 0,0);
  popMatrix();*/


  fill(#FFEEBA);
  //  noStroke();
  //
  // arc(width/2, height/2, width, height, -PI/2, PI/6);
  //   fill(100,255,175);
  // arc(width/2, height/2, width, height, PI/6, 5*PI/6);
  //   fill(217,255,235);
  //    arc(width/2, height/2, width, height, 5*PI/6, 3*PI/2);

  PImage flag1930 = flags.get(k);
  imageMode(CENTER);
  flag1930.resize(width/2, height/2);

  /* //let's create an arc
   pg.beginDraw();
   pg.background(0,0,0,0);
   pg.smooth();
   pg.noStroke();
   pg.fill(255,255,255);
   pg.arc(512.0,512.0,1024,1024,-PI/2, -50*PI/180);
   pg.fill(125, 159, 178, 255);
   pg.arc(512, 512, 2.4*1024/3, 2.4*1024/3, -PI/2, -50*PI/180);
   pg.fill(0,0,0);
   pg.textSize(100);
   pg.text("UR", 512, 100);
   pg.endDraw();*/



/*
  fill(#F7BC06,100);
  arc(width/2, height/2, width, height, 3*PI/2, 31*PI/18);
  fill(#FFCA28,100);
  arc(width/2, height/2, width, height, 31*PI/18, 35*PI/18);
  fill(#FFD554,100);  
  arc(width/2, height/2, width, height, 35*PI/18, 39*PI/18);
*/
  PImage flagsw = flagswin.get(k);
  flagsw.resize(width, height);
  image(flagsw, width/2, height/2);
  PImage flagsr = flagsrun.get(k);
  flagsr.resize(int(2.4*width/3), int(2.4*height/3));
  pushMatrix();
  translate(width/2, height/2);
  rotateZ(40*PI/180);
  image(flagsr, 0, 0);
  popMatrix();
  PImage flagst = flagsthird.get(k);
  flagst.resize(int(1.9*width/3), int(1.9*height/3));
  pushMatrix();
  translate(width/2, height/2);
  rotateZ(80*PI/180);
  image(flagst, 0, 0);
  popMatrix();

  image(flag1930, width/2, height/2);


  //Jason: I added this to step through the years. Nowk you can save each year as a png - make sure to uncomment it 
  //if you are testing so it doesn't step through years

  //Animation controls for now
  if (k < 21) {
    k = k + 1;
    if ( k == 21) {
      noLoop();
    }
  }
  //Also uncomment here if you don't want to save the files
  saveFrame("WC_glyphs####.png");
}

