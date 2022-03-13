//In my defense, I didn't know there was a Java type called 'Object'
public class Objects{
    String shape;
    String path;    //refers to file path for objects. NOT CURVE of moving boxes
    PShape obj;
    boolean moving;
    float speed;
    float progress;
    String direction;

    float x;
    float y;
    float z;

    float oldX;     //position on previous frame. Used for moving objects to update push vales for Matio
    float oldY;
    float oldZ;

    float movedX;   //amount moved from previous frame. Used for moving objects to update push vales for Matio
    float movedY;
    float movedZ;


    float tCornX;   // top corner pos. used for collision
    float tCornY;
    float tCornZ;

    float bCornX;   // bottom corner pos. used for collision
    float bCornY;
    float bCornZ;

                    //Curve params for moving boxes and sling stars (latter NYI)
    float p1X;      //vertex 1
    float p1Y;
    float p1Z;

    float p2X;      //Control Point 1
    float p2Y;
    float p2Z;

    float p3X;      //Control Point 2
    float p3Y;
    float p3Z;

    float p4X;      //vertex 2
    float p4Y;
    float p4Z;

    float sizeX;
    float sizeY;
    float sizeZ;

    float cenX;     // center of object. Used for loaded objs
    float cenY;
    float cenZ;

    //box constructor
                                    // Note: The given X,Y,Z coords/sizes are set to be scaled from Blender (this includes axis changes)
    public Objects (String shapeType, float xPos, float yPos, float zPos, float shapeSizeX, float shapeSizeY, float shapeSizeZ) {
        shape = shapeType;
        x = -1*(xPos*30);
        y = -1*(zPos*30);
        z = yPos*30;
        sizeX = shapeSizeX*30;
        sizeY = shapeSizeZ*30;
        sizeZ = shapeSizeY*30;
        tCornX = x - (sizeX/2);
        tCornY = y - (sizeY/2);
        tCornZ = z - (sizeZ/2);

        bCornX = x + (sizeX/2);
        bCornY = y + (sizeY/2);
        bCornZ = z + (sizeZ/2);
    }
    //movingBox constructor
                                                        // Note: The given X,Y,Z coords/sizes are set to be scaled from Blender (this includes axis changes)
    public Objects (String shapeType, float moveSpeed, float[] curveParams, float shapeSizeX, float shapeSizeY, float shapeSizeZ) {
        shape = shapeType;
        moving = true;
        speed = moveSpeed; // > = slower, < = faster (1/speed)
        progress = 0; //++1 until == speed, then --1 until == 0 
        x = -1*(curveParams[0]*30);
        y = -1*(curveParams[2]*30);
        z = curveParams[1]*30;
        sizeX = shapeSizeX*30;
        sizeY = shapeSizeZ*30;
        sizeZ = shapeSizeY*30;
        tCornX = x - (sizeX/2);
        tCornY = y - (sizeY/2);
        tCornZ = z - (sizeZ/2);

        bCornX = x + (sizeX/2);
        bCornY = y + (sizeY/2);
        bCornZ = z + (sizeZ/2);

        //Note: I pass the curve params in the constructor as p1, p2, p3, p4. curve() wants them as p2, p1, p3, p4
        p1X = -1*(curveParams[0]*30);
        p1Y = -1*(curveParams[2]*30);
        p1Z = curveParams[1]*30;
        
        p2X = -1*(curveParams[3]*30);
        p2Y = -1*(curveParams[5]*30);
        p2Z = curveParams[4]*30;

        p3X = -1*(curveParams[6]*30);
        p3Y = -1*(curveParams[8]*30);
        p3Z = curveParams[7]*30;

        p4X = -1*(curveParams[9]*30);
        p4Y = -1*(curveParams[11]*30);
        p4Z = curveParams[10]*30;
    }
    //geom constructor. Mostly implemented. Big issue is reverse engeneering how processing calculates the default, top-left corner of an obj, because it's often wrong...
    public Objects (String shapeType, String objName, float xPos, float yPos, float zPos, float shapeSizeX, float shapeSizeY, float shapeSizeZ) {
        shape = shapeType;
        path = objName;
        x = -1*(xPos*30);
        y = -1*(zPos*30);
        z = yPos*30;
        sizeX = shapeSizeX*30;
        sizeY = shapeSizeZ*30;
        sizeZ = shapeSizeY*30;

    }

    //Launch Star constructor. Still do not know how Processing does the origin, but this seems to just work...
    public Objects (String shapeType, float xPos, float yPos, float zPos) {
        shape = shapeType;
        path = "launch.obj";
        x = -1*(xPos*30);
        y = -1*(zPos*30);
        z = yPos*30;

        sizeX = 13.6*30;
        sizeY = 13.1*30;
        sizeZ = 0.967*30;



    }
        public boolean loadObj(){
            if ((shape == "box") || (shape == "movingBox")) {
                return false; // this should never return as such, as it's currently a manual call. Implemented if I ever need dynamic calls
            }else{
                obj = loadShape(path);
                return true;
            }
        }

        public void create(){
            //println("Creating a", shape, "at", x,y,z);
            if (shape == "box"){
                pushMatrix();
                translate(x, y, z);
                box(sizeX, sizeY, sizeZ);
                popMatrix();
            }else if (shape == "hitBox"){
                pushMatrix();
                noFill();
                //noStroke();
                translate(x, y, z);
                box(sizeX, sizeY, sizeZ);
                fill(255);
                stroke(0);
                popMatrix();
            } else if (shape == "geom") {
                //println("loading", path, "at", x,y,z, "of size", sizeX, sizeY, sizeZ);
                pushMatrix();
                translate(x, y, z);
                scale(30, 30, 30);
                //rotateZ(PI);
                shape(obj);
                popMatrix();

                pushMatrix();
                fill(255);
                translate(x,y,z);
                scale(30,30,30);
                sphere(5);
                popMatrix();
            } else if (shape == "launch") {
                pushMatrix();
                translate(x, y, z);
                scale(30, 30, 30);
                rotateZ(PI);
                rotateY(PI);
                shape(obj);
                popMatrix();
            }else if (shape == "movingBox") {
                if (progress >= speed) { // should never be >, but contingency
                    direction = "backwards";
                }else if (progress <= 0) {
                    direction = "forwards";
                }
                if (direction == "forwards") {
                    progress +=1;
                }else if (direction == "backwards") {
                    progress -=1;
                }
                oldX = x;
                oldY = y;
                oldZ = z;

                x = curvePoint(p2X, p1X, p3X, p4X, (progress/speed));
                y = curvePoint(p2Y, p1Y, p3Y, p4Y, (progress/speed));
                z = curvePoint(p2Z, p1Z, p3Z, p4Z, (progress/speed));

                movedX = x - oldX;
                movedY = y - oldY;
                movedZ = z - oldZ;

                tCornX = x - (sizeX/2);
                tCornY = y - (sizeY/2);
                tCornZ = z - (sizeZ/2);

                bCornX = x + (sizeX/2);
                bCornY = y + (sizeY/2);
                bCornZ = z + (sizeZ/2);
                pushMatrix();
                noFill();
                //Note: curve() wants them as p2, p1, p3, p4
                curve(p2X, p2Y, p2Z, p1X, p1Y, p1Z, p3X, p3Y, p3Z, p4X, p4Y, p4Z);
                fill(255);
                popMatrix();
                pushMatrix();
                translate(x, y, z);
                box(sizeX, sizeY, sizeZ);
                popMatrix();
                
            }
        }


}