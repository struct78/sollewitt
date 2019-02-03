import wblut.math.*;
import wblut.processing.*;
import wblut.core.*;
import wblut.hemesh.*;
import wblut.geom.*;

HE_Mesh mesh;
WB_Render render;
HEC_Box cube;

ArrayList<HE_Mesh> meshes;
ArrayList<Integer> colours;

int rows = 3;
int columns = 7;
int gutter = 100;
int cubeSize;
float theta = 0.01;

void settings() {
  fullScreen(P3D);
  smooth(8);
}

void setup() {
  render = new WB_Render(this);
  cubeSize = round(((width / columns) - gutter) * .75);
  create();
}

void create() {
  meshes = new ArrayList<HE_Mesh>();
  colours = new ArrayList<Integer>();

  for (int x = 0 ; x < rows * columns; x++ ) {
    cube = new HEC_Box().setDepth(cubeSize+round(random(-100, 50))).setHeight(cubeSize+round(random(-100, 50))).setWidth(cubeSize+round(random(-100, 50)));
    mesh = new HE_Mesh(cube);

    HE_FaceIterator fitr = mesh.fItr();

    while (fitr.hasNext()) {
      fitr.next().setColor(color(random(255), random(255), random(255)));
    }

    meshes.add(mesh);
    colours.add(color(180, 80+random(-30, 30), 200));
  }
}

void draw() {
  background(210);
  noStroke();
  translate((width/columns)-(cubeSize/2), height/rows-(cubeSize/2));

  for (int i = 0 ; i < meshes.size(); i++) {
    int x = (cubeSize + round(gutter * 1.25)) * (i%columns);
    int y = (cubeSize + round(gutter * 1.25)) * (i%rows);

    pushMatrix();

    translate(x, y);
    rotateX(map(mouseY, 0, height, -PI, 0));
    rotateZ(map(mouseX, 0, width, -PI, PI));

    mesh = meshes.get(i);

    noStroke();
    render.drawFaces(mesh);
    render.drawFacesFC(mesh);

    popMatrix();
  }
}

void keyPressed() {
  if (key == ' ') {
    create();
  }
}
