//array that holds each pixl
Bacteria [] pixls;

//integers to track time
int counter = 0;
int endTime = 1000;

//integers to track the pixl that covers the most tiles
int most = 0;
int newValue = 0;
int bestPixl = 0;

//int to determine the number of pixl on the screen
int totalNumPixls = (int)pow(10, (int)(Math.random() * 2) + 1);
 
void setup() {
  //sets up bacground
 	size(500, 500);
  background(255);
  
  //initializes pixls array
  pixls = new Bacteria[totalNumPixls];
 
  //fills up array with a random pixl class
  for (int i = 0; i < pixls.length; i++)
   pixls[i] = new Bacteria ((int)(Math.random() * 256), (int)(Math.random() * 256), (int)(Math.random() * 256));
}   
void draw() {    
  //raise timer
  counter++;
  
  //for loop to make pixls random walk and show
   for (int i = 0; i < pixls.length; i++){
     pixls[i].show();
     pixls[i].randomWalk(); 
   }
   
   //if time is long enough, end the program
   if (counter >= endTime) {
     noLoop();
     
     //for loop will find the pixl that covers the screen the most
     for (int i = 0; i < pixls.length; i++){
        boolean isMost = bacteriaCounting(pixls[i].colorR, pixls[i].colorG, pixls[i].colorB);
   
        if (isMost){
          bestPixl = i;
        }
     }
     
     endScreen();
   }
 }  
 
 //function to find pixl most cover
 boolean bacteriaCounting(int r,int g, int b) {
   newValue = 0;
   
   for (int y = 1; y < 500; y += 10){
     for (int x = 1; x < 500; x += 10){
       if (get(x, y) == color(r, g, b)){
         newValue++;
       }
     }
   }
   
   if (newValue > most){
     most = newValue;
     return true;
   } else
   return false;
 }
 
 //function to print end
 void endScreen() {
   fill(255);
   rect(70, 20, 360, 30);
   
   fill(0);
   textSize(20);
   text("The Pixl that covered the most: #" + bestPixl, 80, 40);
 }
 
 
 //bacteria class that makes random walkers
 class Bacteria {     
   //member variables
   int myX, myY, colorR, colorG, colorB;
   
   //constructer
   Bacteria (int r, int g, int b) {
     //sets color
     colorR = r;
     colorG = g;
     colorB = b;
     
     //sets origin
     myX = 250;
     myY = 250;
   }
   
   void show(){
     inBox();
     
     fill(colorR, colorG, colorB);
     rect(myX, myY, 10, 10);
   }
   
   void randomWalk() {
     myX = myX + ((int)(Math.random() * 3) - 1) * 10;
     myY = myY + ((int)(Math.random() * 3) - 1) * 10;
   }
   
   //function dedicated for organizing cluster of if statements to keep pixls in canvas
   void inBox() {
     if (myX < 0)
       myX = 0;
     if (myX > 490)
       myX = 490;
     if (myY < 0)
       myY = 0;
     if (myY > 490)
       myY = 490;
   }
 }    
