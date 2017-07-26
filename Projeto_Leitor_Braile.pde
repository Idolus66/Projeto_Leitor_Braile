// Teste github
import blobscanner.*;


Detector bs;
PImage img,imgaux;

int threshold = 255;

int blobnum;
int blobrefId;

float blobrefX,blobrefY;

float blobH, blobW;

boolean scan, linhas;

boolean[] matrizBlob = new boolean[7];
boolean[] passos = new boolean[10];
boolean blobrefEsq = true;
String testeAtivo= "ATIVOS: ";
String letraBlob;
int somaBlob = 0;


color boundingBoxCol = color(255, 0, 0);
int boundingBoxThickness = 1;


void setup(){
  background(0);
  size(500,500);
  textFont((createFont("Calibri",28,true)));
  
  img = loadImage("img1.jpg");
  img = get();
  surface.setResizable(true);
  surface.setSize(img.width, img.height);
  blobrefX = img.width;
  blobrefY = img.height;
  blobW =50;
  blobH =50;
  bs = new Detector(this, threshold);
}


void draw(){
  background(0);
  image(img,0,0);
  img.filter(THRESHOLD);
 
  bs.imageFindBlobs(img);
  blobnum = bs.getBlobsNumber();
  //image(img,0,0);
  //fill(150);
  //rect(20,20,60,60);
  //fill(255);
  //text(blobnum-1,30,50);
  
  if (mousePressed){
    fill(255);
    noStroke();
    ellipse(mouseX,mouseY,blobW,blobH);
  }
  img = get();
  if (keyPressed)
  {
    if (key == 'c' || key == 'C')
    background(0);
    img = get();
    if (key == 's' || key == 'S')
    scan = true;
    if (key == 'g' || key == 'G')
    image(imgaux,0,0);
  }
   
   
   

  
   
if (scan)
{

  img.loadPixels();
  bs.findBlobs(img.pixels, img.width, img.height);
  bs.loadBlobsFeatures();
  bs.drawBox(boundingBoxCol, boundingBoxThickness);
  
  bs.weightBlobs(false);
  bs.findCentroids();
  
  
  
for(int i = 0; i < bs.getBlobsNumber(); i++) {
 
stroke(0, 255, 0);
strokeWeight(2);
 

//...and draws a point to their location.
point(bs.getCentroidX(i), bs.getCentroidY(i));

//Write coordinate to the screen.
fill(255);
textFont((createFont("Calibri",14,true)));
text("x-> " + bs.getCentroidX(i) + "\ny-> " + bs.getCentroidY(i)+ "\nId-> "+ i,
                       bs.getCentroidX(i)+30, bs.getCentroidY(i));
                       

// VERIFICA LETRA:

if ((bs.getCentroidX(i) < blobrefX) && (bs.getCentroidY(i) < blobrefY))  {
 blobrefX = bs.getCentroidX(i);
 blobrefY = bs.getCentroidY(i);
 blobrefId = i;

}


if (!passos[1])
 matrizBlob[0] = true;


if (i != blobrefId){
  
// Verifica a localidade dos pontos com base em sua referência  
// ------------------------------------
// ------------------------------------



if (bs.getCentroidX(i) < blobrefX && bs.getCentroidY(i) > blobrefY-blobH && bs.getCentroidY(i) < blobrefY+blobH )
{
  blobrefId = i;
  blobrefX = bs.getCentroidX(i);
  blobrefY = bs.getCentroidY(i);
  blobrefEsq = true;
  matrizBlob[0] = true;
  matrizBlob[1] = true;
  passos[0] = true;
} 
else 
if (bs.getCentroidX(i) > blobrefX && bs.getCentroidY(i) > blobrefY-blobH && bs.getCentroidY(i) < blobrefY+blobH )
{
  blobrefEsq = true;
  matrizBlob[0] = true;
  matrizBlob[1] = true;
  passos[0] = true;
  
}
else
if (bs.getCentroidX(i) < blobrefX-blobW*1.5 && bs.getCentroidY(i) > blobrefY+ blobH && !passos[0] )
{
  blobrefEsq = false;
  passos[1] = true;
  matrizBlob[0] = false;
  matrizBlob[1] = true;
  passos[2] = true;
  
} 
else
if (bs.getCentroidX(i) >= blobrefX-blobW && bs.getCentroidY(i) > blobrefY+ blobH && !passos[0] && !passos[2])
{
  matrizBlob[0] = true;
  matrizBlob[1] = false;
  //matrizBlob[3] = true;
  //blobrefEsq = true;
  //println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
}





if (blobrefEsq){
  
  if (bs.getCentroidX(i) < blobrefX+blobW && bs.getCentroidY(i) > blobrefY+blobH && bs.getCentroidY(i)< blobrefY+3*blobH)
  {
    matrizBlob[2] = true;
  }
  
  if (bs.getCentroidX(i) > blobrefX+blobW && bs.getCentroidY(i) > blobrefY+blobH && bs.getCentroidY(i)< blobrefY+3*blobH)
  {
    matrizBlob[3] = true;
  }
  
  if (bs.getCentroidX(i) < blobrefX+blobW && bs.getCentroidY(i) > blobrefY+3*blobH && bs.getCentroidY(i)< blobrefY+7*blobH)
  {
    matrizBlob[4] = true;
  }
  
  if (bs.getCentroidX(i) > blobrefX+blobW && bs.getCentroidY(i) > blobrefY+3*blobH && bs.getCentroidY(i)< blobrefY+7*blobH)
  {
    matrizBlob[5] = true;
  }
  
  
} 
else
{
  if (bs.getCentroidX(i) < blobrefX-blobW && bs.getCentroidY(i) > blobrefY+blobH && bs.getCentroidY(i)< blobrefY+3*blobH)
  {
    matrizBlob[2] = true;
  }
  
   if (bs.getCentroidX(i) > blobrefX-blobW && bs.getCentroidY(i) > blobrefY+blobH && bs.getCentroidY(i)< blobrefY+3*blobH)
  {
    matrizBlob[3] = true;
  }
  
  if (bs.getCentroidX(i) < blobrefX-blobW && bs.getCentroidY(i) > blobrefY+3*blobH && bs.getCentroidY(i)< blobrefY+7*blobH)
  {
    matrizBlob[4] = true;
  }
  
  if (bs.getCentroidX(i) > blobrefX-blobW && bs.getCentroidY(i) > blobrefY+3*blobH && bs.getCentroidY(i)< blobrefY+7*blobH)
  {
    matrizBlob[5] = true;
  }
  
}



// ------------------------------------
// ------------------------------------
// ------------------------------------
}


// Mostra o id e o local X do ponto de referencia no console (APENAS PARA TESTES)

println("ID REF: "+blobrefId+ "\n X REF:  "+blobrefX);


}

imgaux = get();

// Tratamento caso o usuario insira mais de 6 pontos na tela, fazendo com que não seja, pora ora,
// possível a captação do caractere inserido.

for (int p = 0; p <=  6; p++){
  try{
if (matrizBlob[p])
{
testeAtivo+= (p)+"  ";
if (p == 0)
somaBlob += 1;
if (p == 1)
somaBlob += 2;
if (p == 2)
somaBlob += 4;
if (p == 3)
somaBlob += 8;
if (p == 4)
somaBlob += 16;
if (p == 5)
somaBlob += 32;


}
  } catch(IndexOutOfBoundsException e){
    
    testeAtivo = "MUITOS PONTOS";
  }
  
}

switch(somaBlob)
{
 case 1:   letraBlob = "A";  break; 
 case 5:   letraBlob = "B";  break; 
 case 3:   letraBlob = "C";  break; 
 case 11:  letraBlob = "D";  break; 
 case 9:   letraBlob = "E";  break; 
 case 7:   letraBlob = "F";  break;
 case 15:  letraBlob = "G";  break;
 case 13:  letraBlob = "H";  break;
 case 6:   letraBlob = "I";  break;
 case 14:  letraBlob = "J";  break;

 
 
 
 default:  letraBlob = "NoN";  break;  
}

somaBlob = 0;


println("PONTOS "+testeAtivo);
testeAtivo = "";

println("LETRA: "+letraBlob);

for (int i = 0; i < matrizBlob.length; i++)
  matrizBlob[i] = false;
}
  

  
  scan = false;
  
}