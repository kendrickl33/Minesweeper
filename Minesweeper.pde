import de.bezier.guido.*;
public final static int NUM_ROWS = 16;
public final static int NUM_COLS = 16;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines; //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    
    for(int i = 0; i < NUM_ROWS; i++){
        for(int r = 0; r < NUM_COLS; r++){
            buttons[i][r] = new MSButton(i,r);
        }
    }
    
    
    mines = new ArrayList <MSButton>();
    int mi = ((NUM_ROWS / 2) * 3);
    for(int i = 0; i < mi;i++){
        setMines();
    }
}
public void setMines()
{
    int ro = (int) (Math.random()*NUM_ROWS);
    int co = (int) (Math.random()*NUM_COLS);
    if(!mines.contains(buttons[ro][co])){
        mines.add(buttons[ro][co]);
    }
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    int b = 0;
    for(int i = 0; i < mines.size();i++){
        if(mines.get(i).flagged == true){
            b++;
        }
    }
    if(b == ((NUM_ROWS / 2) * 3)){
        return true;
    }
    return false;
}
public void displayLosingMessage()
{
    buttons[8][4].setLabel("Y");
    buttons[8][5].setLabel("O");
    buttons[8][6].setLabel("U");
    buttons[8][7].setLabel(" ");
    buttons[8][8].setLabel("L");
    buttons[8][9].setLabel("O");
    buttons[8][10].setLabel("S");
    buttons[8][11].setLabel("T");
   for (int i =0; i < mines.size (); i++) {
   mines.get(i).flagged = false;
   mines.get(i).clicked = true;
 }
}
public void displayWinningMessage()
{
    buttons[8][4].setLabel("Y");
    buttons[8][5].setLabel("O");
    buttons[8][6].setLabel("U");
    buttons[8][7].setLabel(" ");
    buttons[8][8].setLabel("W");
    buttons[8][9].setLabel("O");
    buttons[8][10].setLabel("N");
    buttons[8][11].setLabel("!");
}
public boolean isValid(int r, int c)
{
    if(r < 0 || c < 0){
        return false;
    }
    if(r < NUM_ROWS && c < NUM_COLS){
        return true;
    }
    return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    if(isValid(row + 1, col + 1) == true){
    if(mines.contains(buttons[row + 1][col + 1])){
      numMines++;
    }
  }
  if(isValid(row -1, col + 1) == true){
    if(mines.contains(buttons[row - 1][col + 1])){
      numMines++;
    }
  }
  if(isValid(row -1, col - 1 )== true){
    if(mines.contains(buttons[row - 1][col - 1])){
      numMines++;
    }
  }
  if(isValid(row + 1, col - 1) == true){
    if(mines.contains(buttons[row + 1][col - 1])){
      numMines++;
    }
  }
  if(isValid(row, col + 1) == true){
    if(mines.contains(buttons[row][col + 1])){
      numMines++;
    }
  }
  if(isValid(row + 1, col )== true){
    if(mines.contains(buttons[row + 1][col])){
      numMines++;
    }
  }
   if(isValid(row - 1, col) == true){
    if(mines.contains(buttons[row - 1][col])){
      numMines++;
    }
  }
  if(isValid(row, col - 1 )== true){
    if(mines.contains(buttons[row][col - 1])){
      numMines++;
    }
  }
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        if(mouseButton == RIGHT){
            flagged = !flagged;
        }else if(mines.contains( this )){
            displayLosingMessage();
        }else if(countMines(myRow,myCol) > 0){
            setLabel(str(countMines(myRow,myCol)));
        }else{
            if(isValid(myRow + 1,myCol + 1) && buttons[myRow + 1][myCol + 1].clicked == false){
                buttons[myRow + 1][myCol + 1].mousePressed();
            }
            if(isValid(myRow + 1,myCol - 1) && buttons[myRow + 1][myCol - 1].clicked == false){
                buttons[myRow + 1][myCol - 1].mousePressed();
            }
            if(isValid(myRow - 1,myCol + 1) && buttons[myRow - 1][myCol + 1].clicked == false){
                buttons[myRow - 1][myCol + 1].mousePressed();
            }
            if(isValid(myRow - 1,myCol - 1) && buttons[myRow - 1][myCol - 1].clicked == false){
                buttons[myRow - 1][myCol - 1].mousePressed();
            }
            if(isValid(myRow,myCol + 1) && buttons[myRow][myCol + 1].clicked == false){
                buttons[myRow][myCol + 1].mousePressed();
            }
            if(isValid(myRow + 1,myCol) && buttons[myRow + 1][myCol].clicked == false){
                buttons[myRow + 1][myCol].mousePressed();
            }
            if(isValid(myRow - 1,myCol) && buttons[myRow - 1][myCol].clicked == false){
                buttons[myRow - 1][myCol].mousePressed();
            }
            if(isValid(myRow,myCol - 1) && buttons[myRow][myCol - 1].clicked == false){
                buttons[myRow][myCol - 1].mousePressed();
            }

        }
    }
    public void draw () 
    {    
        if (flagged)
            fill(25, 113, 255);
        else if( clicked && mines.contains(this) ) 
        fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
