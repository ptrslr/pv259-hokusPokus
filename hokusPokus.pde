// Hokus Pokus
// Experimental school project

// author: Peter Solař
// inspiration: http://codedoodl.es/_/neilcarpenter/ascii-trail

import processing.pdf.*;

int cols = 0, rows = 0, cellSize = 0, gridLength = 0, hoverRadius = 0;

float defaultColorH, defaultColorS, defaultColorB;
color defaultColor, defaultBackground;

// char[] grid = new char[0];
GridItem[] grid = new GridItem[0];

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

    float itemColorH, itemColorS, itemColorB;
    color itemColor = defaultColor;


    GridItem(char itemChar, color itemColor) {
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
    cellSize = 16;
    cols = width / cellSize;
    rows = height / cellSize;
    gridLength = cols * rows;

    hoverRadius = 2;

    char randomChar = 'a';
    GridItem[] grid = new GridItem[gridLength];

    for (int i = 0; i < grid.length; ++i) {

        grid[i] = new GridItem('a', defaultColor);
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

    // makes sure that gridPos stays in grid range
    newGridPos = (mouseX / cellSize) + (mouseY / cellSize * cols) ;

    if (newGridPos < gridLength) {
        gridPos = newGridPos;
    }

    // iterates through grid based on mouse position and hoverRadius
    for (int i = 0; i <= hoverRadius * 2; ++i) {
        for (int j = 0; j <= hoverRadius * 2; ++j) {
            radiusGridPos = (gridPos + i - hoverRadius) + ((j - hoverRadius) * cols);

            edgeDetection = gridPos % cols + i - hoverRadius;

            if (radiusGridPos >= 0 && radiusGridPos < gridLength && edgeDetection >= 0 && edgeDetection < cols) {
                grid[radiusGridPos].randomizeColor();
            }

            // println(gridPos % cols - i / 2);
        }
    }

    println(mouseX, mouseY, gridPos, gridLength);
}
