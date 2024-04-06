void keyPressed() {
    if (key == 'a' || key == 'A') player.acc.x -= 0.01;
    if (key == 'd' || key == 'D') player.acc.x += 0.01;
    if (key == 'q' || key == 'Q') tv.zoomIn();
    if (key == 'e' || key == 'E') tv.zoomOut();
}

void keyReleased() {
    if (key == 'a' || key == 'A') player.acc.x += 0.01;
    if (key == 'd' || key == 'D') player.acc.x -= 0.01;
}

void mousePressed() { // 37 = left, 39 = right
    if (mouseButton == 37) tv.mousePress();
}

void mouseReleased() {
    if (tv.panning) tv.mouseRelease();
}

void mouseDragged() {
    if (tv.panning) tv.mouseDrag();
}

void mouseWheel(MouseEvent event) {
  if (event.getCount() > 0) tv.zoomOut();
  else tv.zoomIn();
}
