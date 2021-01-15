private static final int SCREEN_WIDTH = 1280; //<>// //<>//
private static final int SCREEN_HEIGHT = 720;

private static final int NUMBER_OF_BALLS = 100;
private Ball[] ballList = new Ball[NUMBER_OF_BALLS];

private PVector position = new PVector(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
private PVector direction = new PVector(0, 0);
private PVector speed = new PVector(0, 0);

void setup() {
  size(1280, 720);
  background(0);

  // Init ball arraylist
  for (int i = 0; i < NUMBER_OF_BALLS; i++)
    this.ballList[i] = new Ball(this, 50, 50, random(0, 255), random(0, 255), random(0, 255));
}
void draw() {
  clear();

  // Object drawing
  for (Ball ball : ballList) {
    ball.checkPosition();
    
    fill(ball.r, ball.g, ball.b);
    ellipse(ball.position.x, ball.position.y, ball.width, ball.height);
    
    ball.move();
  }
}

public static class Ball {

  private final PApplet applet;
  
  public final float width, height;
  public final float r, g, b;
  public PVector position, direction, speed;

  public Ball(PApplet applet, float width, float height, float r, float g, float b) {
    this.applet = applet;
    this.width = width;
    this.height = height;
    this.r = r;
    this.g = g;
    this.b = b;
    this.position = new PVector(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
    this.direction = new PVector();
    this.speed = new PVector();
    
    recalculateDirection();
    recalculateSpeed();
  }

  public void checkPosition() {
    final WindowBound bound = WindowBound.getCorrespondingBound(this, position.x, position.y);
  
    if (bound == null)
      return;
  
    println("Boing on " + bound);
  
    if (bound == WindowBound.TOP || bound == WindowBound.BOTTOM) {
      direction.set(direction.x, -direction.y);
    } else if (bound == WindowBound.LEFT || bound == WindowBound.RIGHT) {
      direction.set(-direction.x, direction.y);
    }
  
    println("New direction : " + direction.x + ", " + direction.y);
  
    recalculateSpeed();
  }

  public void recalculateDirection() {
    float xDirection = applet.random(-1, 1);
    if (xDirection == 0)
      xDirection = 1;
    final float yDirection = applet.random(0, 1);

    println("New direction : " + xDirection + ", " + yDirection);
    this.direction = new PVector(xDirection, yDirection);
  }

  public void recalculateSpeed() {
    float xSpeed = applet.random(2, 10);
    final float ySpeed = applet.random(2, 4);

    println("New speed : " + xSpeed + ", " + ySpeed);
    this.speed = new PVector(xSpeed, ySpeed);
  }
  
  public void move() {
    this.position.add(direction.x * speed.x, direction.y * speed.y); 
  }
  
}

public static enum WindowBound {
  TOP, 
    LEFT, 
    RIGHT, 
    BOTTOM;

  public static WindowBound getCorrespondingBound(Ball ball, float posX, float posY) {
    if (posY - ball.height/2 <= 0)
      return TOP;
    else if (posY + ball.height/2 >= SCREEN_HEIGHT)
      return BOTTOM;
    if (posX - ball.width/2 <= 0)
      return LEFT;
    else if (posX + ball.width/2 >= SCREEN_WIDTH)
      return RIGHT;

    return null;
  }

  public static boolean isOutOfBounds(Ball ball, float posX, float posY) {
    return getCorrespondingBound(ball, posX, posY) != null;
  }
}
