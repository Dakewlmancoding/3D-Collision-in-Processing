import processing.sound.*;


public class Levels {
    Objects[] objects;
    SoundFile theme;
    PImage skybox;
    boolean newLevel = true;
    public Levels (Objects[] levelObjs, SoundFile levelTheme, PImage background) {
        objects = levelObjs;
        theme = levelTheme;
        skybox = background;
    }

    public Objects[] loadLevel(){
        //println("loading");
        Objects[] moving = new Objects[0];
        if (newLevel) {
            theme.loop();
            newLevel = false;
        }
        for (Objects i : objects) {
            i.create();
            if (i.moving) {
                moving = (Objects[]) append(moving, i);
                
            }
        }
        return moving;
    }


}