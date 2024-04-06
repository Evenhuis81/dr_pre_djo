TransformedView tv;
Player player;

void setup() {
    size(1200, 800);

    PVector topLeft = new PVector(10, 8);
    PVector bottomRight = new PVector(20, 16);
    PVector offset = new PVector(0, 0);
    PVector scale = new PVector(40, 40);

    tv = new TransformedView(topLeft, bottomRight, offset, scale);

    player = new Player(11, 9);
}

void draw() {
    background(0);

    tv.show();

    player.update();

    player.show();
}