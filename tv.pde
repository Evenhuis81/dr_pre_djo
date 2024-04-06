class TransformedView {
    PVector screenTL, screenBR, worldTL, worldBR, offset, scale, worldLength;
    PVector startPan = new PVector();
    PVector world = new PVector();
    PVector screen = new PVector();
    PVector screen2 = new PVector();
    PVector beforeWorldZoom = new PVector();
    PVector afterWorldZoom = new PVector();
    boolean panning = false;
    float scaleFactor = 1.1;

    TransformedView(PVector worldTL, PVector worldBR, PVector offset, PVector scale) {
        this.worldTL = worldTL;
        this.worldBR = worldBR;
        this.offset = offset;
        this.scale = scale;
        screenTL = new PVector(0, 0);
        screenBR = new PVector(width, height);
        worldLength = new PVector(worldBR.x - worldTL.x, worldBR.y - worldTL.y);

    }

    void world2Screen(PVector world) {
        screen.set(world.x, world.y).sub(offset);
        screen.x *= scale.x;
        screen.y *= scale.y;
    }

    void world2Screen(PVector world, PVector world2) {
        screen.set(world.x, world.y).sub(offset);
        screen.x *= scale.x;
        screen.y *= scale.y;
        screen2.set(world2.x, world2.y).sub(offset);
        screen2.x *= scale.x;
        screen2.y *= scale.y;
    }

    void world2Screen(float x1, float y1, float x2, float y2) {
        screen.set(x1, y1).sub(offset);
        screen.x *= scale.x;
        screen.y *= scale.y;
        screen2.set(x2, y2).sub(offset);
        screen2.x *= scale.x;
        screen2.y *= scale.y;
    }

    void screen2World(float x, float y) {
        world.set(x, y);
        world.x /= scale.x;
        world.y /= scale.y;
        world.add(offset);
    }

    void screen2World(PVector screen) {
        world.set(screen.x, screen.y);
        world.x /= scale.x;
        world.y /= scale.y;
        world.add(offset);
    }

    void tvRect(PVector pos, float w, float h) {
        world2Screen(pos);
        rect(screen.x, screen.y, w * scale.x, h * scale.y);
    }

    void tvLine(PVector pos, PVector pos2) {
        world2Screen(pos, pos2);
        line(screen.x, screen.y, screen2.x, screen2.y);
    }

    void tvLine(float x1, float y1, float x2, float y2) {
        world2Screen(x1, y1, x2, y2);
        line(screen.x, screen.y, screen2.x, screen2.y);
    }

    void show() {
        strokeWeight(0.05 * scale.x);
        stroke(0, 0, 255);
        noFill();

        tvRect(worldTL, worldLength.x, worldLength.y);

        strokeWeight(0.025 * scale.x);
        stroke(100);

        for (float y = worldTL.y + 1; y < worldBR.y; y++) {
            tvLine(worldTL.x, y, worldBR.x, y);
            for (float x = worldTL.x + 1; x < worldBR.x; x++) {
                tvLine(x, worldTL.y, x, worldBR.y);
            }
        }
    }

    void zoomOut() {
        screen2World(mouseX, mouseY);
        beforeWorldZoom.set(world.x, world.y);

        scale.mult(scaleFactor);

        screen2World(mouseX, mouseY);
        afterWorldZoom.set(world.x, world.y);

        offset.add(PVector.sub(beforeWorldZoom, afterWorldZoom));
    }

    void zoomIn() {
        screen2World(mouseX, mouseY);
        beforeWorldZoom.set(world.x, world.y);

        scale.div(scaleFactor);

        screen2World(mouseX, mouseY);
        afterWorldZoom.set(world.x, world.y);

        offset.add(PVector.sub(beforeWorldZoom, afterWorldZoom));
    }

    void mousePress() {
        panning = true;

        startPan.set(mouseX, mouseY);
    }
    
    void mouseRelease() {
        panning = false;
    }

    void mouseDrag() {
        offset.sub(new PVector((mouseX - startPan.x) / scale.x, (mouseY - startPan.y) / scale.y));

        startPan.set(mouseX, mouseY);
    }
}
