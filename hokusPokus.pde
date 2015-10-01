import processing.pdf.*;

int cols = 0, rows = 0, cellSize = 0, gridLength = 0;
color defaultItemColor;

// char[] grid = new char[0];
GridItem[] grid = new GridItem[0];

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

class GridItem {
    char itemChar = 'a';
    color itemColor = defaultItemColor;

    GridItem(char itemChar, color itemColor) {
        this.itemChar = itemChar;
        this.itemColor = itemColor;
    }

    void randomizeChar() {
        itemChar = char(int(random(32, 127)));
    }

    void randomizeColor() {
        itemColor = int(random(255));
    }

    void brightenColor() {
        itemColor = 255;
    }

    void darkenColor() {
        if (itemColor - 10 >= defaultItemColor) {
            itemColor -= 10;
        }
    }

    char getChar() {
        return itemChar;
    }

    color getColor() {
        return itemColor;
    }

    void setChar(char newChar) {
        itemChar = newChar;
    }

    void setColor(color newColor) {
        itemColor = newColor;
    }
}

GridItem[] gridInit() {
    cellSize = 16;
    cols = width / cellSize;
    rows = height / cellSize;
    gridLength = cols * rows;

    defaultItemColor = 30;

    char randomChar = 'a';
    GridItem[] grid = new GridItem[gridLength];

    for (int i = 0; i < grid.length; ++i) {

        grid[i] = new GridItem('a', defaultItemColor);
    }

    return grid;
}

GridItem[] randomizeGrid(GridItem[] randomGrid) {
    int randomPos = 0, changes = 100;
    int n = int(random(changes));

    char randomChar = 'a';


    for (int i = 0; i < n; ++i) {
        randomChar = char(int(random(33, 128)));
        randomPos = int(random(randomGrid.length));

        // println(randomPos, randomChar);
        randomGrid[randomPos].randomizeChar();
    }

    return randomGrid;
}

void draw() {
    background(10);
    frameRate(30);

    int posX = 0;
    int posY = 0;

    grid = randomizeGrid(grid);

    for (int i = 0; i < grid.length; ++i) {
        posX = (i % cols) * cellSize;
        posY = (i / rows) * cellSize;

        // println(grid.length, posX, posY);
        fill(grid[i].getColor());
        text(grid[i].getChar(), posX, posY);

        grid[i].darkenColor();
    }
}

void mouseMoved() {
    int gridPos = 0;

    gridPos = (mouseX / cellSize + 1) + (mouseY / cellSize * cols) - 1;

    grid[gridPos].brightenColor();

    println(mouseX, mouseY, gridPos, gridLength);
}