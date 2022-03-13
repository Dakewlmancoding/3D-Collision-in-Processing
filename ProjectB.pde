import processing.sound.*;

//#### Var declaration ####//
  PShape mario;
  boolean marioMoving = false;
  float marioXChange = 0.0;
  float marioYChange = 0.0;
  float marioZChange = 0.0;


  float marioX = 0.0;
  float marioY = 0.0;
  float marioZ = 0.0;

  float marioTCornX;   // top corner pos. used for collision
  float marioTCornY;
  float marioTCornZ;

  float marioBCornX;   // bottom corner pos. used for collision
  float marioBCornY;
  float marioBCornZ;

  float oldMarioX;
  float oldMarioY;
  float oldMarioZ;

  Objects marioShadowBox = new Objects("hitBox", marioX, marioY, marioZ, 7.7009, 3.29, 28.1232);

  float speedX = 0.0;
  float speedY = 0.0;
  float speedZ = 0.0;

  Objects[] movingObjects = new Objects[0];


  float camX;
  float camY;
  float camZ;
  float camZoom = 750;


  //Note: all rotational values are stored in DEGREES

  float marioRot;
  float oldMarioRot;

  boolean cameraBypass = false;
  char cameraMode;
  float cameraRot;
  float oldCameraRot;
  float cameraYRot;

  SoundFile jump1;
  SoundFile jump2;
  SoundFile jump3;
  SoundFile jump4;
  int jumpIndex;
  SoundFile[] jumpSounds = new SoundFile[4];

  SoundFile spin;
  SoundFile launchSound;

  boolean w = false;
  boolean a = false;
  boolean s = false;
  boolean d = false;
  boolean q = false;
  boolean e = false;
  boolean r = false;
  boolean f = false;
  boolean space = false;
  boolean v = false;




  float G = 10;
  int jumpTimer;
  int jumpCooldown;
  int spinTimer;
  int spinCooldown;
  boolean landed;
  boolean spinning;

  boolean nearStar;
  boolean launching;
  boolean startLaunch = true;
  float initY = 0.0; //the y value of mario when he starts a launch. I would make this local to launch(), but processing didn't like that

//#Animations#
int animFrame = 0;
  //Idle
    PShape idle1;
    PShape idle2;
    PShape idle3;
    PShape idle4;
    PShape idle5;
    PShape idle6;
    PShape idle7;
    PShape idle8;
    PShape idle9;
    PShape idle10;
    PShape idle11;
    PShape idle12;
    PShape idle13;
    PShape idle14;
    PShape idle15;
    PShape idle16;
    PShape idle17;
    PShape idle18;
    PShape idle19;
    PShape idle20;
    PShape idle21;
    PShape idle22;
    PShape idle23;
    PShape idle24;
    PShape idle25;
    PShape idle26;
    PShape idle27;
    PShape idle28;
    PShape idle29;
    PShape idle30;
    PShape idle31;
    PShape idle32;
    PShape idle33;
    PShape idle34;
    PShape idle35;
    PShape idle36;
    PShape idle37;
    PShape idle38;
    PShape idle39;
    PShape[] idle = {idle1, idle2,idle3,idle4,idle5,idle6,idle7,idle8,idle9,idle10,
                    idle11,idle12,idle13,idle14,idle15,idle16,idle17,idle18,idle19, idle20,
                    idle21,idle22,idle23,idle24,idle25,idle26,idle27,idle28,idle29, idle30,
                    idle31,idle32,idle33,idle34,idle35,idle36,idle37,idle38,idle39};

  //Run
      PShape run1;
      PShape run2;
      PShape run3;
      PShape run4;
      PShape run5;
      PShape run6;
      PShape run7;
      PShape run8;
      PShape run9;
      PShape run10;
      PShape run11;
      PShape run12;
      PShape run13;
      PShape run14;
      PShape run15;
      PShape run16;
      PShape run17;
      PShape run18;
      PShape run19;
      PShape run20;
      PShape run21;
      PShape run22;
      PShape run23;
      PShape run24;
      PShape run25;
      PShape run26;
      PShape run27;
      PShape run28;
      PShape run29;
      PShape run30;
      PShape run31;
      PShape run32;
      PShape run33;
      PShape run34;
      PShape run35;
      PShape run36;
      PShape run37;
      PShape run38;
      PShape run39;
      PShape[] run = {run1, run2,run3,run4,run5,run6,run7,run8,run9,run10,
                      run11,run12,run13,run14,run15,run16,run17,run18,run19, run20,
                      run21,run22,run23,run24,run25,run26,run27,run28,run29, run30,
                      run31,run32,run33,run34,run35,run36,run37,run38,run39};
//for easy copy/paste
//Objects <name> = new Objects("box", 100, 100, 100, 100, 100, 100);

//#Test Group#

  Objects test1 = new Objects("box", 0.003673, 11.6748, -8.37254, 110.039, 186.413, 15.5487);
  Objects test2 = new Objects("box", 0.182399, 24.7541, 3.53377, 14.5823, 9.99141, 9.18803);
  Objects test3 = new Objects("box", 0.182399, 40.421, 3.53377, 14.5823, 9.99141, 9.18803);
  Objects test4 = new Objects("box", -1.36427, 52.5785, 12.5708, 14.5823, 9.99141, 9.18803);
  float[] testCurve1 = {42.0196,16.5597,2.44069,45.4579,11.5769,2.44071,35.1067,-14.6958,14.6927,41.7526,-14.6958,14.6927};
  Objects testCurveOne = new Objects("movingBox", 150, testCurve1, 5,5,5);
  float[] testCurve2 = {-22.5829,-17.8184,2.98554,-14.8469, -17.8184, 2.98554, 16.097, -17.8184, 2.98554, 31.569,-17.8184, 2.98554};
  Objects testCurveTwo = new Objects("movingBox", 100, testCurve2, 4.32778, 8.52696,4.59402);
  Objects testStar = new Objects("launch", -1.132, 53.1824, 16.9873);     //BUILD testStar
  SoundFile testMusic;
  PImage testBack;
  Objects[] testGroup = {test1, test2, test3, test4,testCurveTwo,testCurveOne, testStar}; 
  Levels testLevel;

//#Yoshi Tower#
  //X = width, Y = height, Z = depth
  Objects tow1 = new Objects("box", 0, 11.675, -8.3725, 15.5, 29.5, 15.5);
  Objects tow2 = new Objects("box", 1.6982, 9.0965, -5.581, 11.8, 3.81, 11.8);
  Objects tow3 = new Objects("box", 4.92077, 18.0965, -3.04419, 11.7645, 17.571, 11.7645);
  Objects tow4 = new Objects("box", 0.984781, 19.7397, -1.95949, 11.7645, 17.571, 11.7645);    
  Objects tow5 = new Objects("box", 1.35497, 19.1366, 12.6342, 5.24807, 12.0259, 20.6993);    
  Objects tow6 = new Objects("box", -4.79657, 21.1158, -3.04419, 11.7645, 17.571, 11.7645);
  Objects tow7 = new Objects("box", -2.65956, 17.9413, 7.33798, 9.86924, 12.01, 8.04122);
  Objects tow8 = new Objects("box", -9.4971, 14.4925, 5.87824, 3.9721, 3.9721, 7.24432);
  Objects tow9 = new Objects("box", -9.4971, 17.3884, 4.24213, 3.59, 3.59, 3.59);
  Objects tow10 = new Objects("box", -3.04438, 23.7918, 10.6162, 9.86924, 8.834, 2.07366);
  Objects tow11 = new Objects("box", 1.13994, 24.9634, 10.7757, 9.86924, 8.834, 2.07366);
  Objects tow12 = new Objects("box", -0.645548, 26.9386, 12.3976, 3.9721, 3.9721, 3.60936);
  Objects tow13 = new Objects("box", 2.65928, 27.81, 12.7441, 3.9721, 3.9721, 3.60936);
  Objects tow14 = new Objects("box", 6.73864, 26.0777, 12.7441, 3.9721, 7.43675, 3.60936);
  Objects tow15 = new Objects("box", 5.87913, 15.8577, 12.1789, 9.86924, 8.834, 2.07366);
  Objects tow16 = new Objects("box", 4.51564, 13.0821, 13.2832, 3.9721, 7.43675, 3.60936);
  Objects tow17 = new Objects("box", 0.337337, 13.2516, 15.6335, 3.9721, 7.43675, 3.60936);
  Objects tow18 = new Objects("box", -3.99736, 14.3092, 18.1363, 3.9721, 7.43675, 3.60936);
  Objects tow19 = new Objects("box", -9.62054, 11.2886, 20.2176, 3.9721, 7.43675, 3.60936);
  Objects tow20 = new Objects("box", 0.065676, 18.814, 23.6953, 9.86924, 15.3642, 2.16442);
  Objects tow21 = new Objects("box", 1.74007, 26.0037, -3.12165, 17.8132, 17.571, 11.7645);
  Objects yoshiStar = new Objects("launch", 0, 18.5143, 24.797);                     //build yoshiStar
  SoundFile yoshiMusic;
  Objects[] yoshiGroup = {tow1, tow2, tow3, tow4, tow5, tow6, tow7, tow8, tow9, 
  tow10, tow11, tow12, tow13, tow14, tow15, tow16, tow17, tow18, tow19, 
  tow20, tow21, yoshiStar}; 
  PImage yoshiBack;
  Levels yoshiLevel;

//#Lava Planet#
  Objects lava1 = new Objects("box", -4.71977, -0.129812, -1.85, 40.4008, 39.2628, 0.961816); 
  Objects lava2 = new Objects("box", 10.8446, 11.4511, -1.85, 33.4494, 39.2628, 0.961816);
  Objects lava3 = new Objects("box", -45.1386, -37.8252, -1.85, 40.4008, 35.7419, 0.961816);
  Objects lava4 = new Objects("box", -14.9219, -29.8474, -1.85, 20, 20, 1.0516);
  Objects lava5 = new Objects("box", -20.5514, -44.838, -1.85, 10, 10, 1.0516);
  Objects lava6 = new Objects("box", 0.204794, -24.6565, -1.85, 10, 10, 1.0516);
  Objects lava7 = new Objects("box", -29.2583, -4.44803, -1.85, 10, 32.0332, 1.0516);
  Objects lava8 = new Objects("box", -70.4664, -37.8252, -1.85, 10, 35.7419, 0.961816);
  Objects lava9 = new Objects("box", -101.822, -34.9526, -1.85, 10, 35.7419, 0.961816);
  Objects lava10 = new Objects("box", -78.7624, -50.2339, -1.85, 40, 10, 0.961816);
  Objects lava11 = new Objects("box", -54.7092, -56.6258, -1.85, 40, 10, 0.961816);
  Objects lava12 = new Objects("box", -78.7624, -22.342, -1.85, 40, 10, 0.961816);
  Objects lava13 = new Objects("box", -86.0451, 4.73348, -1.85, 26.7, 45.8759, 0.961816);
  Objects lava14 = new Objects("box", -111.93, -34.3887, -1.85, 19.1878, 22.3, 0.961816);
  Objects lava15 = new Objects("box", -126.623, -16.6286, -1.85, 10, 35.7419, 0.961816);
  Objects lava16 = new Objects("box", -134.126, -7.65121, -1.85, 4.97773, 35.7419, 0.961816);
  Objects lava17 = new Objects("box", -123.045, 9.58242, -1.85, 17.3394, 17.8309, 1.0516);
  Objects lava18 = new Objects("box", -39.2982, -14.7415, -1.85, 10, 10, 1.0516);
  Objects lava19 = new Objects("box", -77.3965, 38.5977, -1.85, 10, 22.5863, 1.0516);
  Objects lava20 = new Objects("box", -84.3353, 32.2577, -1.85, 10, 10, 1.0516);
  Objects lava21 = new Objects("box", -108.092, 9.58242, -1.85, 17.3394, 17.8309, 1.0516);
  Objects lava22 = new Objects("box", -77.4061, 59.6161, -0.285429, 16.6271, 11.2481, 3.89333);
  Objects lava23 = new Objects("box", -116.98, 70.978, -0.552925, 17.3394, 10.4901, 3.64575);
  Objects lava24 = new Objects("box", -71.0995, 42.1676, -0.285429, 7.38549, 25.1799, 3.89333);
  Objects lava25 = new Objects("box", -73.9705, 17.3411, -0.285429, 7.38549, 25.1799, 3.89333);
  Objects lava26 = new Objects("box", -73.9705, -7.72383, -0.285429, 7.38549, 25.1799, 3.89333);
  Objects lava27 = new Objects("box", -76.3439, 3.98437, -0.285429, 7.38549, 25.1799, 3.89333);
  Objects lava28 = new Objects("box", -30.1782, 7.10628, -0.285429, 7.38549, 11.184, 3.89333);
  Objects lava29 = new Objects("box", -35.4855, -3.99416, -0.285429, 7.38549, 11.184, 3.89333);
  Objects lava30 = new Objects("box", -26.5137, 18.1421, -0.285429, 7.38549, 11.184, 3.89333);
  Objects lava31 = new Objects("box", -41.0094, -14.4551, -0.285429, 7.38549, 11.184, 3.89333);
  Objects lava32 = new Objects("box", -61.5949, -23.2146, -0.285429, 19.4927, 11.184, 3.89333);
  Objects lava33 = new Objects("box", -48.3141, -20.9928, -0.285429, 7.38549, 11.184, 3.89333);
  Objects lava34 = new Objects("box", -91.6058, 83.7355, 0.528816, 16.4809, 18.0508, 5.52182);
  Objects lava35 = new Objects("box", -127.247, 60.716, -0.552925, 21.2194, 10.4901, 3.64575);
  Objects lava36 = new Objects("box", -128.588, 50.2069, -0.552925, 17.3394, 10.4901, 3.64575);
  Objects lava37 = new Objects("box", -144.426, 57.49, -1.85, 17.3394, 25.2949, 1.0516);
  Objects lava38 = new Objects("box", -107.846, 85.1554, 0.528816, 16.4809, 18.0508, 5.52182);
  Objects lava39 = new Objects("box", -124.117, 82.5438, 0.528816, 16.4809, 12.8355, 5.52182);
  Objects lava40 = new Objects("box", -133.372, 72.0352, 0.528816, 16.4809, 12.8355, 5.52182);
  Objects lava41 = new Objects("box", -138.739, 106.326, 2.16623, 16.4809, 12.8355, 5.52182);
  Objects lava42 = new Objects("box", -145.981, 100.46, 2.16623, 16.4809, 12.8355, 5.52182);
  Objects lava43 = new Objects("box", -160.74, 90.428, 2.16623, 16.4809, 12.8355, 5.52182);
  Objects lava44 = new Objects("box", -153.498, 96.2934, 2.16623, 16.4809, 12.8355, 5.52182);
  Objects lava45 = new Objects("box", -171.957, 129.57, 2.45868, 16.4809, 12.8355, 5.52182);
  Objects lava46 = new Objects("box", -179.199, 123.705, 2.45868, 16.4809, 12.8355, 5.52182);
  Objects lava47 = new Objects("box", -164.439, 133.737, 2.45868, 16.4809, 12.8355, 5.52182);
  Objects lava48 = new Objects("box", -157.197, 139.602, 2.45868, 16.4809, 12.8355, 5.52182);
  Objects lava49 = new Objects("box", -161.836, 112.568, -3.12095, 29.3597, 12.8355, 5.52182);
  Objects lava50 = new Objects("box", -137.522, 154.319, 1.54363, 13.3871, 12.8355, 16.3494);
  Objects lava51 = new Objects("box", -130.968, 177.081, -1.1948, 13.3871, 12.8355, 9.99288);
  Objects lava52 = new Objects("box", -130.968, 189.965, 1.43671, 13.3871, 12.8355, 9.99288);
  Objects lava53 = new Objects("box", -126.823, 215.346, 8.78895, 13.3871, 12.8355, 9.99288);
  Objects lava54 = new Objects("box", -126.823, 202.462, 6.15745, 13.3871, 12.8355, 9.99288);
  Objects lava55 = new Objects("box", -113.379, 219.757, 13.2902, 13.3871, 12.8355, 9.99288);
  Objects lava56 = new Objects("box", -113.379, 232.64, 15.9217, 13.3871, 12.8355, 9.99288);
  Objects lava57 = new Objects("box", -86.0451, 246.473, -1.85, 26.7, 24.1198, 0.961816);
  Objects lava58 = new Objects("box", -112.688, 253.178, -1.85, 26.7, 24.1198, 0.961816);
  Objects lava59 = new Objects("box", -111.5, 259.697, 1.60838, 13.3871, 12.8355, 9.99288);
  Objects lava60 = new Objects("box", -99.4413, 271.741, 1.60838, 13.3871, 12.8355, 9.99288);
  Objects lava61 = new Objects("box", -87.1499, 260.918, -2.58118, 13.3871, 12.8355, 9.99288);
  Objects lava62 = new Objects("box", -99.2087, 248.873, -2.58118, 13.3871, 12.8355, 9.99288);
  Objects lava63 = new Objects("box", -99.2087, 259.284, -0.791054, 13.3871, 12.8355, 9.99288);
  Objects lava64 = new Objects("box", -113.184, 284.021, 6.38449, 13.3871, 12.8355, 9.99288);
  Objects lava65 = new Objects("box", -113.184, 273.609, 4.59437, 13.3871, 12.8355, 9.99288);
  Objects lava66 = new Objects("box", -101.125, 285.654, 4.59437, 13.3871, 12.8355, 9.99288);
  Objects lava67 = new Objects("box", -113.416, 296.478, 8.78393, 13.3871, 12.8355, 9.99288);
  Objects lava68 = new Objects("box", -125.475, 284.433, 8.78393, 13.3871, 12.8355, 9.99288);
  Objects lava69 = new Objects("box", -126.294, 271.499, 6.38449, 13.3871, 12.8355, 9.99288);
  Objects lava70 = new Objects("box", -147.817, 260.071, 8.78393, 13.3871, 12.8355, 9.99288);
  Objects lava71 = new Objects("box", -135.758, 272.116, 8.78393, 13.3871, 12.8355, 9.99288);
  Objects lava72 = new Objects("box", -136.316, 281.796, 8.78393, 8.87984, 6.8161, 9.99288);
  Objects lava73 = new Objects("box", -146.646, 269.634, 8.78393, 8.87984, 6.8161, 9.99288);
  Objects lava74 = new Objects("box", -124.469, 294.284, 8.78393, 8.87984, 6.8161, 9.99288);
  Objects lava75 = new Objects("box", -124.722, 265.553, 1.60838, 13.3871, 12.8355, 9.99288);
  Objects lava76 = new Objects("box", -139.344, 259.094, -1.85, 26.7, 24.1198, 0.961816);
  Objects lava77 = new Objects("box", -100.53, 309.068, 8.78393, 13.3871, 12.8355, 9.99288);
  Objects lava78 = new Objects("box", -100.53, 296.542, 8.78393, 13.3871, 12.8355, 9.99288);
  Objects lava79 = new Objects("box", -97.2631, 315.836, 26.9726, 13.3871, 12.8355, 67.852);
  Objects lava80 = new Objects("box", -83.9802, 315.836, 26.9726, 13.3871, 12.8355, 67.852);
  Objects lava81 = new Objects("box", -70.9696, 309.241, 26.9726, 13.3871, 12.8355, 67.852);
  Objects lava82 = new Objects("box", -91.3075, 310.878, 26.9726, 13.3871, 12.8355, 67.852);
  Objects lava83 = new Objects("box", -91.394, 326.553, 26.9726, 13.3871, 12.8355, 67.852);
  Objects lava84 = new Objects("box", -79.584, 296.158, -9.13103, 13.3871, 12.8355, 20.5869);
  Objects lava85 = new Objects("box", -69.2875, 286.401, 2.46789, 13.3871, 12.8355, 20.5869);
  Objects lava86 = new Objects("box", -74.0358, 287.979, -3.56384, 13.3871, 12.8355, 20.5869);
  Objects lava87 = new Objects("box", -62.2125, 280.257, 7.42775, 13.3871, 12.8355, 20.5869);
  Objects lava88 = new Objects("box", -62.2125, 280.257, 7.42775, 13.3871, 12.8355, 20.5869);
  Objects lava89 = new Objects("box", -59.8053, 275.821, 10.2201, 13.3871, 12.8355, 20.5869);
  Objects lava90 = new Objects("box", -78.6301, 336.594, 28.3494, 13.3871, 12.8355, 85.8356);
  Objects lava91 = new Objects("box", -78.5435, 320.919, 32.1308, 13.3871, 12.8355, 85.8356);
  Objects lava92 = new Objects("box", -58.2056, 319.282, 35.218, 13.3871, 12.8355, 85.8356);
  Objects lava93 = new Objects("box", -71.2163, 319.497, 35.218, 13.3871, 12.8355, 85.8356);
  Objects lava94 = new Objects("box", -84.4992, 325.877, 28.3494, 13.3871, 12.8355, 85.8356);
  Objects lava95 = new Objects("box", -76.0059, 331.828, 32.1308, 13.3871, 12.8355, 85.8356);
  Objects lava96 = new Objects("box", -67.2768, 331.928, 35.218, 13.3871, 12.8355, 85.8356);
  Objects lava97 = new Objects("box", -54.2661, 331.713, 35.218, 13.3871, 12.8355, 85.8356);
  Objects lava98 = new Objects("box", -90.9442, 335.245, 28.3494, 13.3871, 12.8355, 85.8356);
  Objects lava99 = new Objects("box", -93.4494, 324.079, 31.7183, 13.3871, 12.8355, 67.852);
  Objects lava100 = new Objects("box", -84.1992, 303.142, 53.3232, 13.3871, 12.8355, 14.6781);
  Objects lava101 = new Objects("box", -75.7322, 303.664, 53.6097, 13.3871, 12.8355, 14.6781);
  Objects lava102 = new Objects("box", -50.1432, 326.215, 31.0865, 13.3871, 12.8355, 85.8356);
  Objects lava103 = new Objects("box", -52.6808, 315.306, 31.0865, 13.3871, 12.8355, 85.8356);
  Objects lava104 = new Objects("box", -52.6808, 315.306, 31.0865, 13.3871, 12.8355, 85.8356);
  Objects lava105 = new Objects("box", -50.1432, 326.215, 31.0865, 13.3871, 12.8355, 85.8356);
  Objects lava106 = new Objects("box", -37.0936, 321.913, 28.5593, 13.3871, 12.8355, 85.8356);
  Objects lava107 = new Objects("box", -39.6312, 311.004, 28.5593, 13.3871, 12.8355, 85.8356);
  Objects lava108 = new Objects("box", -26.8429, 298.751, 11.2064, 13.3871, 12.8355, 85.8356);
  Objects lava109 = new Objects("box", -44.5837, 293.084, 8.53644, 22.2222, 23.9651, 85.8356);
  Objects lava110 = new Objects("box", -26.797, 286.109, 8.74439, 13.3871, 12.8355, 85.8356);
  Objects lava111 = new Objects("box", -58.0191, 301.567, 8.57717, 22.2222, 23.9651, 85.8356);
  Objects lava112 = new Objects("box", -42.6204, 270.945, 8.4948, 22.2222, 23.9651, 85.8356);
  Objects lava113 = new Objects("box", -74.7684, 285.047, 48.1386, 13.3871, 12.8355, 6.47867);
  Objects lava114 = new Objects("box", -74.7684, 296.441, 50.66, 13.3871, 12.8355, 12.8668);
  Objects lava115 = new Objects("box", -3.30942, 277.555, 15.0182, 27.8426, 32.1748, 85.8356);
  Objects lava116 = new Objects("box", -26.7159, 266.372, 14.671, 22.2222, 23.9651, 85.8356);
  Objects lava117 = new Objects("box", -22.8596, 283.964, 14.6107, 13.3871, 12.8355, 85.8356);
  Objects lava118 = new Objects("box", -52.4843, 270.176, 19.7908, 13.3871, 12.8355, 20.5869);
  Objects lava119 = new Objects("box", -67.0704, 286.977, 36.4913, 13.3871, 12.8355, 6.47867);
  Objects lava120 = new Objects("box", -31.4428, 193.259, 4.81637, 21.1559, 23.532, 9.99288);

  float[] lava121Curve = {-42.7609,178.682,29.0631,-23.9248,170.64,20.8816,11.704,138.466,75.5133,46.5767,114.528,75.5133};
  Objects lava121 = new Objects("movingBox", 100, lava121Curve,21.1559,23.532,9.99288);

  Objects lava125 = new Objects("box", -23.9248, 177.131, 17.7697, 21.1559, 23.532, 3.79128);

  Objects lava128 = new Objects("box", 2.16436, 141.833, 69.9756, 21.1559, 23.532, 3.79128);
  Objects lava129 = new Objects("box", 2.16436, 131.319, 94.5394, 21.1559, 8.78932, 3.79128);
  Objects lava130 = new Objects("box", 11.3968, 133.031, 87.4845, 21.1559, 8.78932, 3.79128);
  Objects lavaPlanet = new Objects("geom", "lavaPlanet.obj", 0, 0, 0, 288.125, 132.385, 380.638);                 //BUILD lavaPlanet   
  Objects lavaStar = new Objects("launch", 0.550421, 114.456, 101.412);                         //BUILD lavaStar
  Objects[] lavaGroup = {lava1, lava2, lava3, lava4, lava5, lava6, lava7, lava8, lava9,
  lava10, lava11, lava12, lava13, lava14, lava15, lava16, lava17, lava18, lava19, 
  lava20, lava21, lava22, lava23, lava24, lava25, lava26, lava27, lava28, lava29,
  lava30, lava31, lava32, lava33, lava34, lava35, lava36, lava37, lava38, lava39,
  lava40, lava41, lava42, lava43, lava44, lava45, lava46, lava47, lava48, lava49,
  lava50, lava51, lava52, lava53, lava54, lava55, lava56, lava57, lava58, lava59,
  lava60, lava61, lava62, lava63, lava64, lava65, lava66, lava67, lava68, lava69,
  lava70, lava71, lava72, lava73, lava74, lava75, lava76, lava77, lava78, lava79,
  lava80, lava81, lava82, lava83, lava84, lava85, lava86, lava87, lava88, lava89,
  lava90, lava91, lava92, lava93, lava94, lava95, lava96, lava97, lava98, lava99,
  lava100, lava101, lava102, lava103, lava104, lava105, lava106, lava107, lava108, lava109,
  lava110, lava111, lava112, lava113, lava114, lava115, lava116, lava117, lava118, lava119,
  lava120, lava121, lava125, lava128, lava129,
  lava130, lavaStar};
  PImage lavaBack;
  SoundFile lavaMusic;
  Levels lavaLevel;

//#Clockwork Level#
  Objects clock1 = new Objects("box", 0, 31.4303, -13.0005, 59.9529, 64.8606, 24.2434);
  Objects clock2 = new Objects("box", 0, -6.27644, -11.265, 46.8942, 11.8193, 18.9628);
  Objects clock3 = new Objects("box", -1.69414, -18.7284, -11.8133, 23.8241, 6.00465, 9.63385);
  Objects clock4 = new Objects("box", -1.69414, -25.3886, -18.44, 23.8241, 6.00465, 9.63385);
  Objects clock5 = new Objects("box", -20.4489, -23.04, -18.44, 15.365, 6.00465, 9.63385);
  Objects clock6 = new Objects("box", -20.4489, -16.3799, -11.8133, 15.365, 6.00465, 9.63385);
  Objects clock7 = new Objects("box", 38.9925, 49.3675, -4.22878, 18.2238, 41.3342, 9.63385);
  Objects clock8 = new Objects("box", 237.788, 89.896, 5.38781, 529.213, 40.8217, 172.581);
  Objects clock9 = new Objects("box", 38.9925, 49.3675, -4.22878, 18.2238, 41.3342, 9.63385);

  Objects clock10 = new Objects("box", 48.3161, 56.9151, 4.44024, 9.29138, 41.3342, 9.63385);
  Objects clock11 = new Objects("box", 56.2728, 56.9151, 13.7381, 9.29138, 41.3342, 9.63385);
  Objects clock12 = new Objects("box", 65.4937, 56.9151, 20.8444, 9.29138, 41.3342, 9.63385);
  Objects clock13 = new Objects("box", 74.9065, 56.9151, 27.3431, 9.29138, 41.3342, 9.63385);
  Objects clock14 = new Objects("box", 109.166, 56.9151, -6.14527, 9.29138, 41.3342, 9.63385);
  Objects clock15 = new Objects("box", 99.7533, 56.9151, -12.644, 9.29138, 41.3342, 9.63385);
  Objects clock16 = new Objects("box", 90.5324, 56.9151, -19.7502, 9.29138, 41.3342, 9.63385);
  Objects clock17 = new Objects("box", 82.5757, 56.9151, -29.0481, 9.29138, 41.3342, 9.63385);

  Objects clock18 = new Objects("box", 78.1957, 62.8046, -1.03862, 17.1184, 18.453, 17.7493);

  Objects clock19 = new Objects("box", 69.6868, 62.8369, 11.9601, 17.1184, 18.453, 24.7749);
  Objects clock20 = new Objects("box", 91.6009, 62.8547, -17.3987, 27.0557, 18.453, 33.9945);

  Objects clock21 = new Objects("box", 125.221, 51.4134, -2.20197, 23.4182, 34.2176, 4.68685);
  Objects clock22 = new Objects("box", 133.775, 52.8781, -12.4554, 8.21596, 34.2176, 23.5506);
  Objects clock23 = new Objects("box", 125.443, 58.8686, 4.18036, 8.21596, 18.6266, 23.5506);
  Objects clock24 = new Objects("box", 167.026, 51.4134, 5.72699, 23.4182, 34.2176, 4.68685);
  Objects clock25 = new Objects("box", 159.068, 52.8781, 13.0178, 8.21596, 34.2176, 23.5506);
  Objects clock26 = new Objects("box", 167.211, 58.812, -3.59525, 8.21596, 18.6266, 23.5506);
  Objects clock27 = new Objects("box", 143.493, 59.7136, 16.9855, 8.21596, 18.6266, 6.14505);
  Objects clock28 = new Objects("box", 182.546, 65.5724, -5.21998, 13.3454, 50.3157, 12.2088);
  Objects clock29 = new Objects("box", 190.255, 65.5724, -0.837252, 13.3454, 50.3157, 12.2088);
  Objects clock30 = new Objects("box", 196.827, 65.5724, 5.19824, 13.3454, 50.3157, 12.2088);
  Objects clock31 = new Objects("box", 202.673, 65.5724, 9.77654, 13.3454, 50.3157, 12.2088);
  Objects clock32 = new Objects("box", 213.441, 65.5724, -0.178329, 20.1138, 50.3157, 37.7824);
  Objects clock33 = new Objects("box", 224.792, 52.3114, -27.7801, 15.5928, 50.3157, 37.7824);
  Objects clock34 = new Objects("box", 238.772, 57.1103, -19.0406, 15.5928, 50.3157, 14.3971);
  Objects clock35 = new Objects("box", 234.634, 60.5262, -2.74986, 26.4231, 50.3157, 14.3971);
  Objects clock36 = new Objects("box", 230.052, 61.9855, 1.58411, 13.3454, 50.3157, 12.2088);
  Objects clock37 = new Objects("box", 230.052, 61.9855, 6.60506, 13.3454, 19.5847, 12.2088);
  Objects clock38 = new Objects("box", 242.806, 61.9855, 3.38069, 13.3454, 50.3157, 12.2088);
  Objects clock39 = new Objects("box", 259.447, 61.9855, 0.393223, 20.9938, 50.3157, 6.50724);
  Objects clock40 = new Objects("box", 300.721, 60.1943, -1.92511, 38.8131, 28.3557, 6.50724);
  Objects clock41 = new Objects("box", 345.854, 60.1943, -1.92511, 38.8131, 28.3557, 6.50724);
  Objects clock42 = new Objects("box", 277.208, 47.6056, -3.39058, 7.67025, 32.6577, 24.5229);
  Objects clock43 = new Objects("box", 323.252, 47.6056, -3.39058, 7.67025, 32.6577, 24.5229);
  Objects clock44 = new Objects("box", 369.392, 47.6056, -3.39058, 7.67025, 32.6577, 24.5229);
  Objects clock45 = new Objects("box", 323.343, 56.7455, -71.6027, 46.5241, 34.0859, 6.50724);
  Objects clock46 = new Objects("box", 330.211, 41.4412, -72.0517, 28.1273, 34.0859, 6.50724);
  Objects clock47 = new Objects("box", 338.134, 63.7816, -64.7024, 15.3174, 18.65, 7.49611);
  Objects clock48 = new Objects("box", 307.664, 63.7816, -64.7024, 15.3174, 18.65, 7.49611);
  Objects clock49 = new Objects("box", 323.415, 49.2842, -48.3687, 23.1743, 34.0859, 8.33978);
  Objects clock50 = new Objects("box", 323.415, 49.2842, 43.6782, 23.1743, 34.0859, 8.33978);
  Objects clock51 = new Objects("box", 323.252, 55.3901, 31.9962, 7.67025, 18.6516, 14.7878);
  Objects clock52 = new Objects("box", 323.252, 55.3901, -36.939, 7.67025, 18.6516, 14.7878);
  Objects clock53 = new Objects("box", 582.559, 44.3989, -3.76389, 12.5549, 53.4552, 40.1399);
  Objects clock54 = new Objects("box", 507.036, 44.3989, -3.76389, 12.5549, 53.4552, 40.1399);
  Objects clock55 = new Objects("box", 431.67, 44.3989, -3.76389, 12.5549, 53.4552, 40.1399);
  Objects clock56 = new Objects("box", 544.031, 57.9027, -1.36516, 63.5304, 17.0267, 10.6512);
  Objects clock57 = new Objects("box", 470.156, 52.6927, -0.52913, 63.5304, 46.4135, 10.6512);
  Objects clock58 = new Objects("box", 470.156, 54.4917, -93.6698, 63.5304, 30.0329, 7.67949);
  Objects clock59 = new Objects("box", 443.364, 49.3609, -85.5932, 28.1273, 49.2435, 6.50724);
  Objects clock60 = new Objects("box", 490.817, 49.3609, -93.6604, 28.1273, 49.2435, 6.50724);
  Objects clock61 = new Objects("box", 434.489, 61.6223, -78.7235, 15.3174, 18.65, 7.49611);
  Objects clock62 = new Objects("box", 467.439, 64.3308, -86.3294, 15.3174, 18.65, 7.49611);
  Objects clock63 = new Objects("box", 467.439, 64.3308, -86.3294, 15.3174, 18.65, 7.49611);
  Objects clock64 = new Objects("box", 497.158, 64.3308, -86.3294, 15.3174, 18.65, 7.49611);
  Objects clock65 = new Objects("box", 420.838, 54.3549, -85.868, 15.3174, 27.8607, 7.49611);
  Objects clock66 = new Objects("box", 399.101, 47.9271, 4.31923, 37.8376, 49.2435, 6.50724);
  Objects clockStar = new Objects("launch", 582.875, 21.9741, 16.4091);                         //BUILD clockStar
  Objects[] clockGroup = {clock1, clock2, clock3, clock4, clock5, clock6, clock7, clock8, clock9,
  clock10, clock11, clock12, clock13, clock14, clock15, clock16, clock17, clock18, clock19,
  clock20, clock21, clock22, clock23, clock24, clock25, clock26, clock27, clock28, clock29,
  clock30, clock31, clock32, clock33, clock34, clock35, clock36, clock37, clock38, clock39,
  clock40, clock41, clock42, clock43, clock44, clock45, clock46, clock47, clock48, clock49,
  clock50, clock51, clock52, clock53, clock54, clock55, clock56, clock57, clock58, clock59,
  clock60, clock61, clock62, clock63, clock64, clock65, clock66, clockStar};
  PImage clockBack;
  SoundFile clockMusic;
  Levels clockLevel;

//#Desert Planet#
  Objects dune1 = new Objects("box", 0, 0, -5.73098, 32.5611, 16.1857, 10.5469);
  Objects dune2 = new Objects("box", 123.671, -319.464, -5.73098, 67.6475, 22.4739, 10.5469);
  Objects dune3 = new Objects("box", 123.671, -382.095, -5.73098, 67.6475, 22.4739, 10.5469);
  Objects dune4 = new Objects("box", 95.1753, -350.523, -5.73098, 24.5014, 42.2995, 10.5469);
  Objects dune5 = new Objects("box", 153.501, -350.523, -5.73098, 24.5014, 42.2995, 10.5469);
  Objects dune6 = new Objects("box", -98.1137, -350.523, -5.73098, 24.5014, 42.2995, 10.5469);
  Objects dune7 = new Objects("box", -156.439, -350.523, -5.73098, 24.5014, 42.2995, 10.5469);
  Objects dune8 = new Objects("box", -127.944, -382.095, -5.73098, 67.6475, 22.4739, 10.5469);
  Objects dune9 = new Objects("box", -127.944, -319.464, -5.73098, 67.6475, 22.4739, 10.5469);
  Objects dune10 = new Objects("box", -0.136345, -17.889, -5.73098, 67.6475, 22.4739, 10.5469);
  Objects dune11 = new Objects("box", -0.136345, -80.5199, -5.73098, 67.6475, 22.4739, 10.5469);
  Objects dune12 = new Objects("box", -28.632, -48.9485, -5.73098, 24.5014, 42.2995, 10.5469);
  Objects dune13 = new Objects("box", 29.6936, -48.9485, -5.73098, 24.5014, 42.2995, 10.5469);
  Objects dune14 = new Objects("box", 55.3204, -17.889, -5.73098, 67.6475, 22.4739, 10.5469);
  Objects dune15 = new Objects("box", 55.3204, -40.4411, -5.73098, 40.8896, 22.4739, 10.5469);
  Objects dune16 = new Objects("box", 93.5768, -25.1559, -3.38799, 23.0631, 22.4739, 10.5469);
  Objects dune17 = new Objects("box", 103.166, -30.9432, -2.08173, 23.0631, 22.4739, 10.5469);
  Objects dune18 = new Objects("box", 132, -44.2679, -7.00978, 23.0631, 22.4739, 10.5469);
  Objects dune19 = new Objects("box", 117.996, -44.2679, -7.00978, 23.0631, 22.4739, 10.5469);
  Objects dune20 = new Objects("box", 120.049, -66.8766, -7.00978, 23.0631, 22.4739, 10.5469);
  Objects dune21 = new Objects("box", 108.623, -85.052, -3.32956, 23.0631, 22.4739, 13.9328);
  Objects dune22 = new Objects("box", 95.3737, -98.79, -5.91937, 13.4635, 13.7556, 35.5322);
  Objects dune23 = new Objects("box", 99.9241, -105.123, -5.9366, 13.4635, 13.7556, 35.5322);
  Objects dune24 = new Objects("box", 108.634, -102.618, -10.0396, 13.4635, 13.7556, 27.5605);
  Objects dune25 = new Objects("box", 108.634, -111.488, -10.0396, 13.4635, 13.7556, 27.5605);
  Objects dune26 = new Objects("box", 114.854, -121.031, -10.3059, 10.9801, 11.2183, 28.8542);
  Objects dune27 = new Objects("box", 117.423, -132.096, -10.6704, 10.9801, 11.2183, 28.8542);
  Objects dune28 = new Objects("box", 120.073, -143.049, -10.8433, 10.9801, 11.2183, 28.8542);
  Objects dune29 = new Objects("box", 124.685, -150.44, -10.8485, 10.9801, 11.2183, 28.8542);
  Objects dune30 = new Objects("box", 128.461, -161.234, -10.9746, 10.9801, 11.2183, 28.8542);
  Objects dune31 = new Objects("box", 132.78, -141.76, -11.8441, 24.3727, 15.519, 27.5605);
  Objects dune32 = new Objects("box", 151.097, -134.593, -13.7705, 13.4635, 13.7556, 22.2156);
  Objects dune33 = new Objects("box", 164.401, -146.847, -13.7705, 13.4635, 13.7556, 22.2156);
  Objects dune34 = new Objects("box", 155.43, -146.847, -13.7705, 13.4635, 13.7556, 22.2156);
  Objects dune35 = new Objects("box", 164.401, -137.784, -13.7705, 13.4635, 13.7556, 22.2156);
  Objects dune36 = new Objects("box", 177.338, -137.784, -13.7705, 13.4635, 13.7556, 22.2156);
  Objects dune37 = new Objects("box", 185.339, -132.781, -13.4826, 10.9801, 11.2183, 21.3519);
  Objects dune38 = new Objects("box", 194.418, -127.884, -13.4826, 10.9801, 11.2183, 21.3519);
  Objects dune39 = new Objects("box", 202.179, -123.88, -13.4826, 10.9801, 11.2183, 21.3519);
  Objects dune40 = new Objects("box", 169.967, -88.4678, -7.40543, 23.0631, 22.4739, 10.5469);
  Objects dune41 = new Objects("box", 174.514, -102.258, -9.50093, 10.9801, 11.2183, 28.8542);
  Objects dune42 = new Objects("box", 182.047, -96.9336, -9.50093, 10.9801, 11.2183, 28.8542);
  Objects dune43 = new Objects("box", 220.071, -154.708, -13.4826, 10.9801, 11.2183, 21.3519);
  Objects dune44 = new Objects("box", 212.31, -158.712, -13.4826, 10.9801, 11.2183, 21.3519);
  Objects dune45 = new Objects("box", 203.23, -163.609, -13.4826, 10.9801, 11.2183, 21.3519);
  Objects dune46 = new Objects("box", 218.265, -202.401, -12.2072, 10.9801, 11.2183, 21.3519);
  Objects dune47 = new Objects("box", 227.345, -197.504, -12.2072, 10.9801, 11.2183, 21.3519);
  Objects dune48 = new Objects("box", 235.106, -193.5, -12.2072, 10.9801, 11.2183, 21.3519);
  Objects dune49 = new Objects("box", 192.765, -233.063, -9.39845, 10.9801, 19.7299, 21.3519);
  Objects dune50 = new Objects("box", 188.092, -252.869, -7.22663, 10.9801, 19.7299, 21.3519);
  Objects dune51 = new Objects("box", 200.48, -249.693, -11.1665, 10.9801, 11.2183, 21.3519);
  Objects dune52 = new Objects("box", 200.48, -260.525, -7.07602, 10.9801, 11.2183, 21.3519);
  Objects dune53 = new Objects("box", 216.539, -256.215, -12.912, 22.2751, 19.7299, 21.3519);
  Objects dune54 = new Objects("box", 217.593, -283.282, -13.3735, 10.9801, 57.4273, 21.3519);
  Objects dune55 = new Objects("box", 201.104, -303.363, -13.3735, 22.4663, 10.2097, 21.3519);
  Objects dune56 = new Objects("box", 185.213, -298.334, -13.3735, 22.4663, 10.2097, 21.3519);
  Objects dune57 = new Objects("box", 179.314, -307.018, -13.3735, 22.4663, 10.2097, 21.3519);
  Objects dune58 = new Objects("box", 73.5889, -422.948, -5.73096, 24.5014, 42.2995, 10.5469);
  Objects dune59 = new Objects("box", 62.8739, -388.686, -5.73096, 15.5273, 42.2995, 10.5469);
  Objects dune60 = new Objects("box", 50.8635, -367.175, -5.73096, 15.5273, 22.8941, 10.5469);
  Objects dune61 = new Objects("box", 73.6564, -383.946, -5.73096, 15.5273, 22.8941, 10.5469);
  Objects dune62 = new Objects("box", 35.1975, -368.278, -5.73096, 15.5273, 22.8941, 10.5469);
  Objects dune63 = new Objects("box", 11.2875, -422.918, -5.73096, 24.5014, 21.3693, 10.5469);
  Objects dune64 = new Objects("box", 18.5547, -443.442, -5.73096, 24.5014, 21.3693, 10.5469);
  Objects dune65 = new Objects("box", 48.1086, -444.863, -5.73096, 10.4979, 12.2418, 10.5469);
  Objects dune66 = new Objects("box", 45.3325, -433.033, -2.28708, 35.3444, 12.2418, 10.5469);
  Objects dune67 = new Objects("box", 42.7217, -424.844, -8.33653, 44.7983, 12.2418, 10.5469);
  Objects dune68 = new Objects("box", 15.7103, -395.778, -3.09123, 34.9098, 23.972, 12.2017);
  Objects dune69 = new Objects("box", 13.978, -372.815, 0.708903, 31.4452, 21.3693, 12.2017);
  Objects dune70 = new Objects("box", -8.3938, -375.133, 0.708903, 19.632, 21.3693, 12.2017);
  Objects dune71 = new Objects("box", -36.959, -369.171, 0.708903, 13.8041, 21.3693, 12.2017);
  Objects dune72 = new Objects("box", -24.1572, -371.989, -10.1445, 13.8041, 21.3693, 12.2017);
  Objects dune73 = new Objects("box", -44.9125, -384.858, -2.23895, 10.4979, 12.2418, 10.5469);
  Objects dune74 = new Objects("box", -39.1369, -408.478, -8.33653, 25.3421, 7.60187, 10.5469);
  Objects dune75 = new Objects("box", -10.904, -404.599, -2.28708, 35.3444, 12.2418, 10.5469);
  Objects dune76 = new Objects("box", -24.5715, -414.378, -2.35192, 10.196, 30.5985, 10.5469);
  Objects dune77 = new Objects("box", -36.8554, -416.368, -2.9143, 24.3613, 10.29, 10.5469);
  Objects dune78 = new Objects("box", -53.1432, -414.378, -2.35192, 10.196, 22.1344, 10.5469);
  Objects dune79 = new Objects("box", -66.521, -411.726, -5.84073, 21.911, 22.1344, 10.5469);
  Objects dune80 = new Objects("box", -84.5335, -400.975, -5.84073, 21.911, 22.1344, 10.5469);
  Objects dune81 = new Objects("box", -84.5335, -379.371, -5.84073, 21.911, 22.1344, 10.5469);
  Objects dune82 = new Objects("box", -71.6102, -365.252, -5.84073, 21.911, 22.1344, 10.5469);
  Objects dune83 = new Objects("box", -83.2049, -307.216, -5.84073, 27.9198, 31.3742, 10.5469);
  Objects dune84 = new Objects("box", -64.6476, -288.837, -5.84073, 27.9198, 31.3742, 10.5469);
  Objects dune85 = new Objects("box", -49.529, -274.829, -5.84073, 27.9198, 31.3742, 10.5469);
  Objects dune86 = new Objects("box", -36.8375, -261.643, -5.84073, 27.9198, 31.3742, 10.5469);
  Objects dune87 = new Objects("box", 0.381115, -226.092, -5.84073, 57.0016, 63.6213, 10.5469);
  Objects duneStar = new Objects("launch", 0, -224.575, 0);                         //BUILD lavaStar
  Objects[] duneGroup = {dune1, dune2, dune3, dune4, dune5, dune6, dune7, dune8, dune9,
  dune10, dune11, dune12, dune13, dune14, dune15, dune16, dune17, dune18, dune19, 
  dune20, dune21, dune22, dune23, dune24, dune25, dune26, dune27, dune28, dune29, 
  dune30, dune31, dune32, dune33, dune34, dune35, dune36, dune37, dune38, dune39, 
  dune40, dune41, dune42, dune43, dune44, dune45, dune46, dune47, dune48, dune49, 
  dune50, dune51, dune52, dune53, dune54, dune55, dune56, dune57, dune58, dune59, 
  dune60, dune61, dune62, dune63, dune64, dune65, dune66, dune67, dune68, dune69, 
  dune70, dune71, dune72, dune73, dune74, dune75, dune76, dune77, dune78, dune79, 
  dune80, dune81, dune82, dune83, dune84, dune85, dune86, dune87, duneStar};
  PImage duneBack;
  SoundFile duneMusic;
  Levels duneLevel;


Levels activeLevel;


//#### Init ####//
public void setup() {
  //shapeMode(CENTER);

  size(1000, 700, P3D);

  //Anim setup
      //Idle
        idle1 = loadShape("anims/idle/idle_000001.obj");
        idle[0] = idle1;
        idle2 = loadShape("anims/idle/idle_000002.obj");
        idle[1] = idle2;
        idle3 = loadShape("anims/idle/idle_000003.obj");
        idle[2] = idle3;
        idle4 = loadShape("anims/idle/idle_000004.obj");
        idle[3] = idle4;
        idle5 = loadShape("anims/idle/idle_000005.obj");
        idle[4] = idle5;
        idle6 = loadShape("anims/idle/idle_000006.obj");
        idle[5] = idle6;
        idle7 = loadShape("anims/idle/idle_000007.obj");
        idle[6] = idle7;
        idle8 = loadShape("anims/idle/idle_000008.obj");
        idle[7] = idle8;
        idle9 = loadShape("anims/idle/idle_000009.obj");
        idle[8] = idle9;
        idle10 = loadShape("anims/idle/idle_000010.obj");
        idle[9] = idle10;
        idle11 = loadShape("anims/idle/idle_000011.obj");
        idle[10] = idle11;
        idle12 = loadShape("anims/idle/idle_000012.obj");
        idle[11] = idle12;
        idle13 = loadShape("anims/idle/idle_000013.obj");
        idle[12] = idle13;
        idle14 = loadShape("anims/idle/idle_000014.obj");
        idle[13] = idle14;
        idle15 = loadShape("anims/idle/idle_000015.obj");
        idle[14] = idle15;
        idle16 = loadShape("anims/idle/idle_000016.obj");
        idle[15] = idle16;
        idle17 = loadShape("anims/idle/idle_000017.obj");
        idle[16] = idle17;
        idle18 = loadShape("anims/idle/idle_000018.obj");
        idle[17] = idle18;
        idle19 = loadShape("anims/idle/idle_000019.obj");
        idle[18] = idle19;
        idle20 = loadShape("anims/idle/idle_000020.obj");
        idle[19] = idle20;
        idle21 = loadShape("anims/idle/idle_000021.obj");
        idle[20] = idle21;
        idle22 = loadShape("anims/idle/idle_000022.obj");
        idle[21] = idle22;
        idle23 = loadShape("anims/idle/idle_000023.obj");
        idle[22] = idle23;
        idle24 = loadShape("anims/idle/idle_000024.obj");
        idle[23] = idle24;
        idle25 = loadShape("anims/idle/idle_000025.obj");
        idle[24] = idle25;
        idle26 = loadShape("anims/idle/idle_000026.obj");
        idle[25] = idle26;
        idle27 = loadShape("anims/idle/idle_000027.obj");
        idle[26] = idle27;
        idle28 = loadShape("anims/idle/idle_000028.obj");
        idle[27] = idle28;
        idle29 = loadShape("anims/idle/idle_000029.obj");
        idle[28] = idle29;
        idle30 = loadShape("anims/idle/idle_000030.obj");
        idle[29] = idle30;
        idle31 = loadShape("anims/idle/idle_000031.obj");
        idle[30] = idle31;
        idle32 = loadShape("anims/idle/idle_000032.obj");
        idle[31] = idle32;
        idle33 = loadShape("anims/idle/idle_000033.obj");
        idle[32] = idle33;
        idle34 = loadShape("anims/idle/idle_000034.obj");
        idle[33] = idle34;
        idle35 = loadShape("anims/idle/idle_000035.obj");
        idle[34] = idle35;
        idle36 = loadShape("anims/idle/idle_000036.obj");
        idle[35] = idle36;
        idle37 = loadShape("anims/idle/idle_000037.obj");
        idle[36] = idle37;
        idle38 = loadShape("anims/idle/idle_000038.obj");
        idle[37] = idle38;
        idle39 = loadShape("anims/idle/idle_000039.obj");
        idle[38] = idle39;
      
      //Run
          run1 = loadShape("anims/run/run_000001.obj");
          run[0] = run1;
          run2 = loadShape("anims/run/run_000002.obj");
          run[1] = run2;
          run3 = loadShape("anims/run/run_000003.obj");
          run[2] = run3;
          run4 = loadShape("anims/run/run_000004.obj");
          run[3] = run4;
          run5 = loadShape("anims/run/run_000005.obj");
          run[4] = run5;
          run6 = loadShape("anims/run/run_000006.obj");
          run[5] = run6;
          run7 = loadShape("anims/run/run_000007.obj");
          run[6] = run7;
          run8 = loadShape("anims/run/run_000008.obj");
          run[7] = run8;
          run9 = loadShape("anims/run/run_000009.obj");
          run[8] = run9;
          run10 = loadShape("anims/run/run_000010.obj");
          run[9] = run10;
          run11 = loadShape("anims/run/run_000011.obj");
          run[10] = run11;
          run12 = loadShape("anims/run/run_000012.obj");
          run[11] = run12;
          run13 = loadShape("anims/run/run_000013.obj");
          run[12] = run13;
          run14 = loadShape("anims/run/run_000014.obj");
          run[13] = run14;
          run15 = loadShape("anims/run/run_000015.obj");
          run[14] = run15;
          run16 = loadShape("anims/run/run_000016.obj");
          run[15] = run16;
          run17 = loadShape("anims/run/run_000017.obj");
          run[16] = run17;
          run18 = loadShape("anims/run/run_000018.obj");
          run[17] = run18;
          run19 = loadShape("anims/run/run_000019.obj");
          run[18] = run19;
          run20 = loadShape("anims/run/run_000020.obj");
          run[19] = run20;
          run21 = loadShape("anims/run/run_000021.obj");
          run[20] = run21;
          run22 = loadShape("anims/run/run_000022.obj");
          run[21] = run22;
          run23 = loadShape("anims/run/run_000023.obj");
          run[22] = run23;
          run24 = loadShape("anims/run/run_000024.obj");
          run[23] = run24;
          run25 = loadShape("anims/run/run_000025.obj");
          run[24] = run25;
          run26 = loadShape("anims/run/run_000026.obj");
          run[25] = run26;
          run27 = loadShape("anims/run/run_000027.obj");
          run[26] = run27;
          run28 = loadShape("anims/run/run_000028.obj");
          run[27] = run28;
          run29 = loadShape("anims/run/run_000029.obj");
          run[28] = run29;
          run30 = loadShape("anims/run/run_000030.obj");
          run[29] = run30;
          run31 = loadShape("anims/run/run_000031.obj");
          run[30] = run31;
          run32 = loadShape("anims/run/run_000032.obj");
          run[31] = run32;
          run33 = loadShape("anims/run/run_000033.obj");
          run[32] = run33;
          run34 = loadShape("anims/run/run_000034.obj");
          run[33] = run34;
          run35 = loadShape("anims/run/run_000035.obj");
          run[34] = run35;
          run36 = loadShape("anims/run/run_000036.obj");
          run[35] = run36;
          run37 = loadShape("anims/run/run_000037.obj");
          run[36] = run37;
          run38 = loadShape("anims/run/run_000038.obj");
          run[37] = run38;
          run39 = loadShape("anims/run/run_000039.obj");
          run[38] = run39;

  //camera setup
    beginCamera();
    camera();
    translate(marioX, marioY+200, marioZ-250);
    rotateX(radians(341));
    rotateY(PI);
    endCamera();

  //mario setup
    spin = new SoundFile(this, "audio/Mario18.wav"); 
    launchSound = new SoundFile(this, "audio/launchStar.wav"); 
    jump1 = new SoundFile(this, "audio/Mario38.wav");
    jump2 = new SoundFile(this, "audio/Mario39.wav");
    jump3 = new SoundFile(this, "audio/Mario40.wav");
    jump4 = new SoundFile(this, "audio/Mario41.wav");
    jumpSounds[0] = jump1;
    jumpSounds[1] = jump2;
    jumpSounds[2] = jump3;
    jumpSounds[3] = jump4;
    mario = loadShape("anims/idle/idle_000001.obj");
    pushMatrix();
    translate(marioX, marioY, marioZ);
    scale(100);
    rotateZ(PI);
    rotateY(PI);
    shape(mario);
    popMatrix();

  //Levels setup

    testStar.loadObj();
    testMusic = new SoundFile(this, "audio/testTheme.wav");
    testBack = loadImage("backgrounds/sky.png");
    testLevel = new Levels(testGroup, testMusic, testBack);

    yoshiStar.loadObj();
    yoshiMusic = new SoundFile(this, "audio/SMG_galaxy01_strm.wav");
    yoshiBack = loadImage("backgrounds/sky.png");
    yoshiLevel = new Levels(yoshiGroup, yoshiMusic, yoshiBack);

    lavaPlanet.loadObj();
    lavaStar.loadObj();
    lavaMusic = new SoundFile(this, "audio/SMG_galaxy02_strm.wav");
    lavaBack = loadImage("backgrounds/meltyMolten.jpg");
    lavaLevel = new Levels(lavaGroup, lavaMusic, lavaBack);

    clockStar.loadObj();
    clockMusic = new SoundFile(this, "audio/SMG2_galaxy01_multi.wav");
    clockBack = loadImage("backgrounds/clockwork.jpg");
    clockLevel = new Levels(clockGroup, clockMusic, clockBack);

    duneStar.loadObj();
    duneMusic = new SoundFile(this, "audio/SMG_galaxy19_strm.wav");
    duneBack = loadImage("backgrounds/clockwork.jpg");
    duneLevel = new Levels(duneGroup, duneMusic, duneBack);

    activeLevel = testLevel;
  
  frameRate(26);
}



//#### Main Loop ####//
public void draw() {
  // **misc**
    activeLevel.skybox.resize(width, height);
    background(activeLevel.skybox);
    lights();
    spotLight(255, 0, 0, marioX, marioY, marioZ, 0, 1, 0, 0, 500);


  //***Objects***
  movingObjects = activeLevel.loadLevel();


  if (launching) {
    launch();
    camX = marioX;
    camY = marioY-400;
    camZ = marioZ-750;
  } else {
    startLaunch = true; //this is somewhat confusingly named. It does not mean start a launch. It means is this the first frame of a launch
    //***Mario's Movement Controls***
      if (w) {
        //println("w key is pressed");
        move('w', activeLevel.objects);
      }if (a) {
        move('a', activeLevel.objects);
      }
      if (s) {
        move('s', activeLevel.objects);
      }
      if (d) {
        move('d', activeLevel.objects);
      }

      if (q) {
        marioRot -= 3;
        if (marioRot >= 360) {
          marioRot -= 360;
        } else if (marioRot <= -360) {
          marioRot += 360;
        }
      }
      if (e) {
        marioRot += 3;
        if (marioRot >= 360) {
          marioRot -= 360;
        } else if (marioRot <= -360) {
          marioRot += 360;
        }
      }


      if (space && jumpCooldown == 0) {
        println(jumpTimer);
        if (jumpTimer == 0){
          jumpCooldown = 20;
          println(jumpCooldown);
        }else{
          if (jumpTimer == 50) {
            jumpIndex = int(random(0, 3));
            jumpSounds[jumpIndex].play();
          }
        jumpTimer -= 1;
        move(' ', activeLevel.objects);
        }
      }else{
        if (gravity(activeLevel.objects)){
          jumpTimer = 50;
          jumpCooldown = 0;
          println("landed");
          landed = true;
        } else {
          landed = false;
        }
      }

    //spinning to fall slower and gain some added height. NYFI 
      if (v && spinCooldown == 0) {
        if (spinTimer == 0) {
          v = false;
          cameraBypass = false;
          spinCooldown = 10;
        }else {
          if (spinTimer == 8) {
            spin.play();
            //collision(activeLevel.objects, 0, 0, 0); //updates nearStar. I know this is a bit of a hack job...
            if (nearStar) {
              println("Wahooo!!");
              launching = true;
              nearStar = false;
            }
          }
          spinTimer -= 1;
          cameraBypass=true;;
          marioRot += 90;
          if (marioRot >= 360) {
          marioRot -= 360;
          } else if (marioRot <= -360) {
          marioRot += 360;
          }
        }
      }else {
        if (spinCooldown > 0) {
          println("spin cooldown", spinCooldown);
          spinCooldown -=1;
        }else {
          spinTimer = 8;
        }
      }

    }
  //*** Update Mario's Coords ***  
    objCollision(movingObjects);
    if (!collision(activeLevel.objects, marioXChange, 0, 0)){
      marioX += marioXChange;
    }
    if (!collision(activeLevel.objects, 0, marioYChange, 0)){
    }
      marioY += marioYChange;
    if (!collision(activeLevel.objects, 0, 0, marioZChange)){
      marioZ += marioZChange;
    }
    
    marioXChange = 0.0;
    marioYChange = 0.0;
    marioZChange = 0.0;
    if (w || a || s || d) {
      animate(run);
    }else {
      animate(idle);
    }
    animFrame +=1;
  // *** Camera Controls ***
      if (r) {
        camZoom -= 10;
      }
      if (f) {
        camZoom += 10;
      }
      camX = marioX;
      camY = marioY-400;
      camZ = marioZ - camZoom;
      if (cameraMode == 'z') {
        if (!cameraBypass) {
          cameraYRot = marioRot-90;
        }
        camX = (cos(radians(cameraYRot))*camZoom)+marioX;
        camZ = (sin(radians(cameraYRot))*camZoom)+marioZ;
      }else if (cameraMode == 'x') {
        if (!cameraBypass) {
          cameraYRot = marioRot;
        }
        camX = (cos(radians(cameraYRot))*camZoom)+marioX;
        camZ = (sin(radians(cameraYRot))*camZoom)+marioZ;
      }else if (cameraMode == 'c') {
        if (!cameraBypass) {
          cameraYRot = marioRot-180;
        }
        camX = (cos(radians(cameraYRot))*camZoom)+marioX;
        camZ = (sin(radians(cameraYRot))*camZoom)+marioZ;
      }
      camera(camX, camY, camZ, // eyeX, eyeY, eyeZ
        marioX, marioY, marioZ, // centerX, centerY, centerZ
        0.0, 1.0, 0.0); // upX, upY, upZ

  // ***Moving Mario***
    marioShadowBox.x = marioX;
    marioShadowBox.y = marioY+marioShadowBox.sizeY/2;
    marioShadowBox.z = marioZ;
    //marioShadowBox.create();
    pushMatrix();
    translate(marioX, marioY, marioZ);
    println("Mario is at:", marioX, marioY, marioZ, "; facing:", marioRot);
    scale(100);
    rotateZ(PI);
    rotateY(radians(marioRot));
    noStroke();
    fill(0);
    //box(5, 0, 5);
    fill(255);
    stroke(0);
    shape(mario);
    popMatrix();
    
    oldMarioX = marioX;
    oldMarioY = marioY;
    oldMarioZ = marioZ;

    oldMarioRot = marioRot;

    oldCameraRot = cameraRot;

    //println("Running at", frameRate, "fps");
  

}

//#### My Functions ####//

//Checks if mario should be able to move, if so moves him
void move(char WASD, Objects[] currentLevel){
  float[] changes = new float[0];
  float xChange;
  float zChange;
  float yChange;
  changes = moveCalc(WASD, marioRot, currentLevel);
  xChange = changes[1];
  yChange = changes[2];
  zChange = changes[0];

  marioXChange += xChange;
  marioYChange -= yChange;
  marioZChange += zChange;


}

//Calculates mario's movement. Implemented to make sure 'W' always moves mario forward, relative to mario's direction
float[] moveCalc(char WASD, float currentRot, Objects[] currentLevel){
  boolean jumping = false;
  float tempRot = currentRot; 
  float[] moves = new float[3];
  if (WASD == 'w'){
    tempRot = currentRot;
  } else if (WASD == 'a') {
    tempRot = currentRot + 270;
  } else if (WASD == 's') {
    tempRot = currentRot + 180;
  } else if (WASD == 'd') {
    tempRot = currentRot + 90;
  } else if (WASD == ' ') {
    jumping = true;
    //println("Jumping");
    if (jumpTimer >= 1){
      //marioY -= 20;
      jumpTimer -= 1;
    }
  }
  if (jumping){
    moves[0] = 0;
    moves[1] = 0;
    moves[2] = 15;
    //println("jumping");
  }else{
    moves[0] = round(15*cos(radians(tempRot))); // Z
    moves[1] = round(-15*sin(radians(tempRot))); // X
    moves[2] = 0; // Y
    //println("Moving by", moves[0], moves[1]);
  }
  return moves;
  
}

// pulls mario back down. returns true if Mario is on the ground
boolean gravity(Objects[] currentLevel){
  if (!collision(currentLevel, 0, -G, 0)){
    marioY += G;
    if (marioY >= 700) {
      marioY = 0;
      marioX = 0;
      marioZ = 0;
    }
    return false;
  }else{
    return true;
  }
}

void launch(){
  int levelSelect;
  if (startLaunch) {
    launchSound.play();
    marioRot = 0;
    spinTimer = 0;
    initY = marioY;
    startLaunch = false;
  }else if (marioY <= (initY-500)) {
    activeLevel.theme.stop();
    levelSelect = int(random(0,4));
    switch (levelSelect) {
      case 0 :
        yoshiLevel.newLevel = true;
        activeLevel = yoshiLevel;
      break;	
      case 1 :
        lavaLevel.newLevel = true; 
        activeLevel = lavaLevel;
      break;
      case 2 :
        clockLevel.newLevel = true; 
        activeLevel = clockLevel;
      break;
      case 3 :
        duneLevel.newLevel = true; 
        activeLevel = duneLevel;
      break;
    }
    marioX = 0.0;
    marioY = 0.0;
    marioZ = 0.0;
    launching = false;
  }else {
    marioY -= 100;
  }
}

//used to check if moving objects will hit mario. Returns how much mario's X, Y, and Z should be offset by
boolean objCollision(Objects[] movingStuff){;
  float xPush = 0.0;
  float yPush = 0.0;
  float zPush = 0.0;
  Objects tempObj;
  Objects[] closeStuff = new Objects[0];
  for (int i = 0; i < movingStuff.length; i++) {
    if (dist(movingStuff[i].x, movingStuff[i].y, movingStuff[i].z, marioX, marioY, marioZ) <=1000) {
      tempObj = movingStuff[i];
      closeStuff = (Objects[]) append(closeStuff, tempObj); //SOME DOCS ON THIS WOULD BE NICE, PROCESSING! AHHHHHHH! Oh, wait, it's right there
    }
  }
  //println("Moving close stuff:", closeStuff.length);
  for (int i = 0; i < closeStuff.length; i++) {
    //println(closeStuff[i].shape);

      /*  
      //Display corners of Mario's hitbox
        pushMatrix();
        fill(255);
        //bottom corner
        translate(marioX-75, marioY-175, marioZ-37.5);
        sphere(5);
        popMatrix();
        pushMatrix();
        fill(255);
        //top corner
        translate(marioX+75, marioY, marioZ+37.5);
        sphere(5);
        popMatrix();
      //display corners of Object's hitbox
        pushMatrix();
        fill(255);
        //top corner
        translate(closeStuff[i].tCornX, closeStuff[i].tCornY, closeStuff[i].tCornZ);
        sphere(5);
        popMatrix();
        pushMatrix();
        fill(255);
        //bottom corner
        translate(closeStuff[i].bCornX, closeStuff[i].bCornY, closeStuff[i].bCornZ);
        sphere(5);
        popMatrix();


      
      println(marioX-75, "<=", closeStuff[i].bCornX, "&&", marioX+75, ">=", closeStuff[i].tCornX);
      println(marioY-175, "<=", closeStuff[i].bCornY, "&&", marioY, ">=", closeStuff[i].tCornY);
      println(marioZ-37.5, "<=", closeStuff[i].bCornZ, "&&", marioZ+37.5, ">=", closeStuff[i].tCornZ);
      */
      if ( (marioX-75 <= closeStuff[i].bCornX && marioX+75 >= closeStuff[i].tCornX) &&
          (marioY-175 <= closeStuff[i].bCornY && marioY >= closeStuff[i].tCornY) &&
          (marioZ-37.5 <= closeStuff[i].bCornZ && marioZ+37.5 >= closeStuff[i].tCornZ) ) {
        //println("Collision");

        xPush += closeStuff[i].movedX;
        yPush += closeStuff[i].movedY -G;
        println("Being Y Pushed:", yPush);
        zPush += closeStuff[i].movedZ;
        
      }
    }
    
    if ((xPush == 0.0) && (yPush == 0.0) && (zPush == 0.0)) {
      return false;
    }else {
      marioXChange += xPush;
      marioYChange -= yPush;
      marioZChange += zPush;

      /*
      //!!!!!!!!!!!!!!!!!!!FIX THIS!!!!!!!!!!!!!!!!!!!!
      if (!collision(activeLevel.objects, xPush, 0, 0)) {
        marioX += xPush;
      }
      if (!collision(activeLevel.objects, 0, yPush, 0)) {
        marioY += yPush;
      }
      if (!collision(activeLevel.objects, xPush, 0, 0)) {
        marioZ += zPush;
      }
      */
      return true;
    }

}

// checks if the Max/Min of mario's hitbox is trying to overlap the Min/Max of any other object w/in 2000 pixels' hitbox
boolean collision(Objects[] levelStuff, float xMove, float yMove, float zMove){
  float propX = marioX + xMove;
  float propY = marioY - yMove;
  float propZ = marioZ + zMove;
  Objects tempObj;
  Objects[] closeStuff = new Objects[0];
  for (int i = 0; i < levelStuff.length; i++) {
    if (dist(levelStuff[i].x, levelStuff[i].y, levelStuff[i].z, propX, propY, propZ) <=2000) {
      tempObj = levelStuff[i];
      //println(i, levelStuff[i].getClass().getSimpleName(), levelStuff[i].shape);
      closeStuff = (Objects[]) append(closeStuff, tempObj); //SOME DOCS ON THIS WOULD BE NICE, PROCESSING! AHHHHHHH! Oh, wait, it's right there
    }
  }
  //println(closeStuff.length);
  for (int i = 0; i < closeStuff.length; i++) {
    //println(closeStuff[i].shape);
    if (closeStuff[i].shape == "launch") {
      //println("Near Launch Star!");
      if (dist(closeStuff[i].x,closeStuff[i].y,closeStuff[i].z,propX,propY,propZ)<=100) {
        nearStar = true;
      }
    }else if((closeStuff[i].shape == "box") || (closeStuff[i].shape == "movingBox")){

      //println("Mario's close to", closeStuff[i].shape, "at", closeStuff[i].x, closeStuff[i].y, closeStuff[i].z);
      
      //code for testing hitboxes
        /**
        //Display corners of Mario's hitbox
        pushMatrix();
        fill(255);
        //bottom corner
        translate(propX-75, propY-175, propZ-37.5);
        sphere(5);
        popMatrix();
        pushMatrix();
        fill(255);
        //top corner
        translate(propX+75, propY, propZ+37.5);
        sphere(5);
        popMatrix();
        
        //display corners of Object's hitbox
        pushMatrix();
        fill(255);
        //top corner
        translate(closeStuff[i].tCornX, closeStuff[i].tCornY, closeStuff[i].tCornZ);
        sphere(5);
        popMatrix();
        pushMatrix();
        fill(255);
        //bottom corner
        translate(closeStuff[i].bCornX, closeStuff[i].bCornY, closeStuff[i].bCornZ);
        sphere(5);
        popMatrix();
        
        println(propX-75 <= closeStuff[i].bCornX && propX+75 >= closeStuff[i].tCornX);
        println(propY, "<=", closeStuff[i].bCornY, "&&", propY-175, ">=", closeStuff[i].tCornY, (propY <= closeStuff[i].bCornY && propY-175 >= closeStuff[i].tCornY));
        println(propZ-37.5 <= closeStuff[i].bCornZ && propZ+37.5 >= closeStuff[i].tCornZ);
        */

      if ( (propX-75 <= closeStuff[i].bCornX && propX+75 >= closeStuff[i].tCornX) &&
          (propY-175 <= closeStuff[i].bCornY && propY >= closeStuff[i].tCornY) &&
          (propZ-37.5 <= closeStuff[i].bCornZ && propZ+37.5 >= closeStuff[i].tCornZ) ) {
        //println("Collision");
        return true;
      }
    }
  }
  return false;

}

void animate(PShape[] animSet){
  if (animFrame > animSet.length-1) {
    animFrame = 0;
  }
    mario = animSet[animFrame];
}


//#### Event Functions ####//
void keyPressed() {
  if (key == 'w') {
    w = true;
  }
  if (key == 'a') {
    a = true;
  }
  if (key == 's') {
    s = true;
  }
  if (key == 'd') {
    d = true;
  }
  if (key == 'q') {
    q = true;
  }
  if (key == 'e') {
    e = true;
  }
  if (key == ' ') {
    space = true;
  }
  if (key == 'v') {
    v = true;
  }
  if (key == 'z') {
    cameraMode = 'z';
  }
  if (key == 'x') {
    cameraMode = 'x';
  }
  if (key == 'c') {
    cameraMode = 'c';
  }
  if (key == 'r') {
    r = true;
  }
  if (key == 'f') {
    f = true;
  }
  if (key == 't') {
    camZoom = 750;
  }
}

void keyReleased() {
  //println("Key Released!");
  if (key == 'w') {
    w = false;
  }
  if (key == 'a') {
    a = false;
  }
  if (key == 's') {
    s = false;
  }
  if (key == 'd') {
    d = false;
  }
  if (key == 'q') {
    q = false;
  }
  if (key == 'e') {
    e = false;
  }
  if (key == ' ') {
    space = false;
  }
  if (key == 'r') {
    r = false;
  }
  if (key == 'f') {
    f = false;
  }
}