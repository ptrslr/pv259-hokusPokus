// Hokus Pokus
// Experimental school project

// author: Peter Solař
// inspiration: http://codedoodl.es/_/neilcarpenter/ascii-trail

import processing.pdf.*;

int cols = 0, rows = 0, cellSize = 0, gridLength = 0, hoverRadius = 0;

float defaultColorH, defaultColorS, defaultColorB;
color defaultColor, defaultBackground;

// char[] grid = new char[0];
GridItem[] grid;

PFont font;

void setup() {
    size(1024, 640, P2D);

    colorMode(HSB, 360, 100, 100);

    defaultColorH = 137;
    defaultColorS = 57;
    defaultColorB = 68;

    defaultColor = color(defaultColorH, defaultColorS, defaultColorB);
    defaultBackground = color(defaultColorH, defaultColorS, defaultColorB);

    fill(defaultColor);
    font = createFont("Inconsolata", 16, true);
    textAlign(LEFT, TOP);
    textFont(font);

    grid = gridInit();
}

// GridItem object class
class GridItem {
    char itemChar = 'a';
    int posX, posY;
    float itemColorH, itemColorS, itemColorB;
    color itemColor = defaultColor;

    GridItem(int posX, int posY, char itemChar, color itemColor) {
        this.posX = posX;
        this.posY = posY;

        this.itemChar = itemChar;
        this.itemColor = itemColor;

        itemColorH = hue(itemColor);
        itemColorS = saturation(itemColor);
        itemColorB = brightness(itemColor);
    }

    void randomizeChar() {
        itemChar = char(int(random(32, 127)));
    }

    void randomizeColor() {
        itemColorB = int(random(50));
        itemColor = color(itemColorH, itemColorS, itemColorB);
    }

    void brightenColor() {
        itemColor = 255;
    }

    void darkenColor() {
        if (itemColorB + defaultColorB / 200 <= defaultColorB) {
            itemColorB += defaultColorB / 200;
            itemColor = color(itemColorH, itemColorS, itemColorB);
        }
        else {
            itemColor = defaultColor;
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

// initializes grid
GridItem[] gridInit() {
    int posX = 0, posY = 0;

    cellSize = 16;
    cols = width / cellSize;
    rows = height / cellSize;
    gridLength = cols * rows;

    hoverRadius = 64;

    char randomChar = 'a';
    GridItem[] grid = new GridItem[gridLength];

    for (int i = 0; i < grid.length; ++i) {
        posX = (i % cols) * cellSize;
        posY = (i / cols) * cellSize;

        grid[i] = new GridItem(posX, posY, 'a', defaultColor);
    }

    return grid;
}

// randomizes grid
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

// renders grid
void renderGrid(GridItem[] randomGrid) {
    // position coordinates on screen
    int posX = 0;
    int posY = 0;

    for (int i = 0; i < grid.length; ++i) {
        posX = (i % cols) * cellSize;
        posY = (i / cols) * cellSize;

        // println(grid.length, posX, posY);
        fill(grid[i].getColor());
        text(grid[i].getChar(), posX, posY);

        grid[i].darkenColor();
    }
}

void draw() {
    frameRate(120);
    background(defaultBackground);

    grid = randomizeGrid(grid);
    renderGrid(grid);
}

void mouseMoved() {
    int gridPos = 0, newGridPos = 0, radiusGridPos = 0, edgeDetection = 0;
    int gridLength = rows * cols;
    int posX, posY, x, y;
    float distance = 0;

    for (int i = 0; i < gridLength; i++) {
        posX = grid[i].posX;
        posY = grid[i].posY;

        x = posX + cellSize / 2;
        y = posY + cellSize / 2;
        distance = sqrt(pow(x - mouseX, 2) + pow(y - mouseY, 2));
        if (distance <= hoverRadius) {
            grid[i].randomizeColor();
        }
    }

    println(mouseX, mouseY, gridPos, gridLength);
}
