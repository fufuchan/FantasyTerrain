int cols, rows;
int scl = 20;
int w = 2000;
int h = 2000;

float col = 255;
float flying = 0;

float[][] terrain;
ArrayList <PVector> terrainXColour;
ArrayList <PVector> terrainYColour;

void setup() {
  size (600, 600, P3D);
  cols = w / scl;
  rows = h / scl;
  
  terrain = new float[cols][rows];
  terrainXColour = new ArrayList <PVector>();
  terrainYColour = new ArrayList <PVector>();
  
  for (int i = 0; i < cols; i++) {
  PVector terrainXCol = new PVector(random(col / 3), random(col / 2), random(col));
  PVector terrainYCol = new PVector(random(col / 3), random(col / 2), random(200, col));

  terrainXColour.add(terrainXCol);
  terrainYColour.add(terrainYCol);
  }
}

void draw() {
  
  flying -= 0.1;
  
  float yoff = flying;

  for (int y = 0; y < rows; y++) {
      float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -150, 150);
      xoff += 0.2;
    }
    yoff += 0.2;
   }
  
  background (255, 143, 234, 50);
  //noFill();
  translate (width / 2, height / 2);
  rotateX(PI / 3);
  
  translate (-w / 2, - h / 2);
  for (int y = 0; y < rows - 1; y++) {
    PVector tempTerrainYCol = terrainYColour.get(y);
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      PVector tempTerrainXCol = terrainXColour.get(x);
      stroke(tempTerrainXCol.x, tempTerrainXCol.y, tempTerrainXCol.z, 50);
      fill(tempTerrainXCol.x, tempTerrainXCol.y, tempTerrainXCol.z);
      vertex (x * scl, y * scl, terrain [x][y]);
      fill(tempTerrainYCol.x, tempTerrainYCol.y, tempTerrainYCol.z);
      vertex (x * scl, (y + 1) * scl, terrain [x][y + 1]);      
      
    }
    endShape();
  }
}
