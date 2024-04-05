class TransformedView {
    PVector screenTL, screenBR, worldTL, worldBR, offset, scale, worldLength, screen, screen2, beforeWorldZoom, afterWorldZoom;
    PVector startPan = new PVector();
    PVector world = new PVector();
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

    PVector world2Screen(float x, float y) {
        PVector screenTemp = new PVector(x, y).sub(offset);
        screenTemp.x *= scale.x;
        screenTemp.y *= scale.y;

        return screenTemp;
    }

    PVector screen2World(float x, float y) {
        PVector worldTemp = new PVector(x, y);
        worldTemp.x /= scale.x;
        worldTemp.y /= scale.y;
        worldTemp.add(offset);

        return worldTemp;
    }

    void tvRect(float x, float y, float w, float h) {
        screen = world2Screen(x, y);
        rect(screen.x, screen.y, w * scale.x, h * scale.y);
    }

    void tvLine(float x, float y, float x2, float y2) {
        screen = world2Screen(x, y);
        screen2 = world2Screen(x2, y2);
        line(screen.x, screen.y, screen2.x, screen2.y);
    }

    void show() {
        strokeWeight(0.05 * scale.x);
        stroke(0, 0, 255);
        noFill();

        tvRect(worldTL.x, worldTL.y, worldLength.x, worldLength.y);

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
        beforeWorldZoom = screen2World(mouseX, mouseY);

        scale.mult(scaleFactor);

        afterWorldZoom = screen2World(mouseX, mouseY);

        offset.add(PVector.sub(beforeWorldZoom, afterWorldZoom));
    }

    void zoomIn() {
        beforeWorldZoom = screen2World(mouseX, mouseY);

        scale.div(scaleFactor);

        afterWorldZoom = screen2World(mouseX, mouseY);

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
