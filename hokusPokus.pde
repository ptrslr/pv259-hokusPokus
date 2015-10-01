import processing.pdf.*;

int cols = 0, rows = 0, cellSize = 0, gridLength = 0;

char[] grid = new char[0];

PFont font;

void setup() {
    size(640, 640, P2D);
    colorMode(HSB);
    background(10);

    fill(50);
    font = createFont("Inconsolata", 16, true);
    textAlign(LEFT, TOP);
    textFont(font);

    grid = gridInit();
}

class gridItem {
    char itemChar = 'a';
    color itemColor = 50;

    void randomizeChar() {
        itemChar = char(int(random(32, 127)));
    }
}

char[] gridInit() {
    cellSize = 16;
    cols = width / cellSize;
    rows = height / cellSize;
    gridLength = cols * rows;

    char randomChar = 'a';
    char[] grid = new char[gridLength];

    for (int i = 0; i < grid.length; ++i) {
        randomChar = char(int(random(32, 127)));

        grid[i] = randomChar;
    }

    return grid;
}

char[] randomizeGrid(char[] randomGrid) {
    int randomPos = 0, changes = 100;
    int n = int(random(changes));

    char randomChar = 'a';


    for (int i = 0; i < n; ++i) {
        randomChar = char(int(random(33, 128)));
        randomPos = int(random(randomGrid.length));

        // println(randomPos, randomChar);
        randomGrid[randomPos] = randomChar;
    }

    return randomGrid;
}

void draw() {
    background(10);

    int posX = 0;
    int posY = 0;

    grid = randomizeGrid(grid);

    for (int i = 0; i < grid.length; ++i) {
        posX = (i % cols) * cellSize;
        posY = (i / rows) * cellSize;

        // println(grid.length, posX, posY);
        text(grid[i], posX, posY);
    }
}

void mouseMoved() {

}