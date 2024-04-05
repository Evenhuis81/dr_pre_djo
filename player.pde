class Player {
    color fillColor = color(255, 0, 0);
    boolean grounded = true;
    PVector pos, vel, acc;
    float maxVelX = 0.1;
    float maxVelY = 0.3;
    float friction = 0.9;
    int w = 1;
    int h = 1;

    Player(float x, float y) {
        pos = new PVector(x, y);
        vel = new PVector();
        acc = new PVector(0, 0.003); // gravity
        acc = new PVector();
    }

    void update() {
        vel.add(acc);
        if (grounded) vel.x *= friction;
        limitX(vel, maxVelX);
        limitY(vel, maxVelY);

        // Collisions
        // if (pos.y + 40 > height) pos.y = height - 40;

        pos.add(vel);
    }

    void show() {
        noStroke();
        fill(fillColor);

        tv.tvRect(pos.x, pos.y, w, h);
    }

    void limitX(PVector vel, float maxVelX) {
        if (vel.x > maxVelX) vel.x = maxVelX;
        else if (vel.x < -maxVelX) vel.x = -maxVelX;
    }

    void limitY(PVector vel, float maxVelY) {
        if (vel.y > maxVelY) vel.y = maxVelY;
        else if (vel.y < -maxVelY) vel.y = -maxVelY;
    }
}
