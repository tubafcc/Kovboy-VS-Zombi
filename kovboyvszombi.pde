//Tuğba Fıçıcı 30116005
/*
Kovboy vs Zombiler
Amaç:
  Zombiler kovboya değmeden zombileri öldür.
Oynanış:
  Zombilere nişan al ve mouse tuşunu kullanarak mermi sık.
Oyun:
  Oyun 4 bölümden oluşur. Bölüm başı zombilerin hızı değişmektedir.
*/

//Kullanılan tek kütüphane "Sound" kütüphanesidir.

//Değişkenler-->
import processing.sound.*;
SoundFile zombisesi;
SoundFile mermisesi;

PImage bg;
PImage kovboy;
PImage zombi;
PImage menu;
PImage over;

ArrayList<mermi> mermiler = new ArrayList<mermi>();

int mermi=0;
int zombix=0;

PFont worta;
PFont wkucuk;
PFont western;

int hiz=2;
int score;

boolean start=true;
boolean end=false;
boolean gameover=false;
boolean oyna=false;

float a;//geriye olusturma 
float dx,dy;

int mermiciz=0;

PVector eklencek=new PVector(5,5);

zombie[] stage1=new zombie[50];
//<--Değişkenler

void setup(){
      size(1500,844);
//Kullanılan sesler yüklendi-->       
      zombisesi=new SoundFile(this, "zombi.mp3");
      mermisesi=new SoundFile(this, "silah2.mp3");
//<--

//Kullanılan resimler yüklendi-->  
      bg=loadImage("bgnew.jpg");
      zombi=loadImage("zombie.png");
      kovboy=loadImage("kovboyp.png");
      menu=loadImage("menu.jpg");
      over=loadImage("gameover.jpg");
//<--
      
//Kullanılan Fontlar yüklendi.-->      
      western=createFont("RioGrande.ttf",150);
      worta=createFont("RioGrande.ttf",50);
      wkucuk=createFont("RioGrande.ttf",30);
//<-- 
      score=0;
      
      dx=0;
      dy=0;
      a=0;
//Zombiler oluşturuluyor-->
      for(int i=0;i<stage1.length;i++){
        stage1[i]=new zombie(a);a+=250;
      }
//<--

//Mermiler oluşturuluyor-->      
      for(int i = 0; i <200 ; i++)
        {
          mermiler.add(new mermi());
        }
//<--
}

void draw(){
//Giriş sayfası dizaynı-->  
    if(true){
    background(menu);
    fill(#583F08);
    textSize(30);
    textFont(western);
    text("PLAY",300,height/2-100);///-->giris
    textFont(worta);
    text("NASIL OYNANIR?",50,height/2+30);
    textFont(wkucuk);
    text("Mouse-click tusu ile zombilere ates etmeniz",50,height/2+100);
    text("gerekmektedir.4 bolum mevcuttur.Bu bolumlerde",50,height/2+140);
    text("zombiler farkli hizlara sahipler.",50,height/2+180);
    text("zombiler kovboya dokunursa oyun biter.",50,height/2+220);
     }
//<--Giris Sayfası

    boolean s1=false;
//Zombi hızlarının kontrol edilmesi-->
    if(oyna){
    if(zombix>10 && zombix<20){hiz=3;}
    if(zombix>20 && zombix<30){hiz=5;}
    if(zombix>30 && zombix<40){hiz=7;}
//<--Zombi hızları kontrolü   
    
    background(bg);
    
//Bölümlerin kontrol edilip ekrana yazdırılması-->
    if(zombix==1){
      stageCiz s=new stageCiz();
      s.ciz("STAGE 1");
      s.yoket(); 
    }
    if(zombix==10){
      stageCiz s=new stageCiz();
      s.ciz("STAGE 2");
      s.yoket(); 
    }
    if(zombix==20){
      stageCiz s=new stageCiz();
      s.ciz("STAGE 3");
      s.yoket(); 
    }
    if(zombix==30){
      stageCiz s=new stageCiz();
      s.ciz("FINAL");
      s.yoket(); 
    }
    if(zombix==50){
      end=true;
      zombisesi.stop();
    }
//<--Bölüm kontrolü

//Kovboyun çizilmesi-->
    kovboy kb=new kovboy();
    kb.ciz();
//<--kovboy
    
//Mermi çizilmesi-->
    for(mermi mermi1 : mermiler)
      {
      mermi1.ciz();
      }
//<--mermi   

//Zombilerin çizilmesi-->    
    for(int i=0;i<stage1.length;i++){
      stage1[i].ciz();
      stage1[i].istila();
    }
//<--zombi  
}

//Oyun bitişi-->

//Kaybederse-->
    if(gameover){
        background(over);
        fill(255);
        textFont(western);
        text("GAMEOVER",380,height/2-200);
    
    }
    //<--Kaybederse
    
    //-->Kazanırsa
    if(end){
        background(menu);
        fill(#583F08);
        textFont(western);
        text("YOU WIN",100,height/2);
    }
//<--Kazanırsa


//-->Oyunun bitişi
}

//Bölüm başlıklarının yazılması için oluşturulan class-->
class stageCiz{
    PVector kn=new PVector(width/2-100,200);
    void ciz(String yazi){
      fill(#583F08);textFont(worta);text(yazi,kn.x,kn.y);
    }
    void yoket(){
      kn.x=4000;
    }
}
//<-- Bölüm başlıkları

//Kovboy Classı-->
class kovboy{
    PVector kovboyv=new PVector(0,474);
    void ciz(){
      image(kovboy,kovboyv.x,kovboyv.y);}
}
//<--Kovboy

//Zombi Classı-->
class zombie{
    PVector zombiv=new PVector(1320,524);//zombinin başlangıç konumu
    zombie(float a){//constructer -->aralarında ki mesafeyi ayarlamak için
    zombiv.x+=a;//mesafenin eklenmesi
    }
    boolean display=true;//Çizilmesinin kontrolü
    
    void ciz(){
     if(display){
      image(zombi,zombiv.x,zombiv.y);}else{zombiv.x=4000;zombiv.y=4000;}
      zombiv.x-=hiz;//Zombilere hız eklenmesi
        
    }
    void istila(){//eğer kovboya dokunursa
      if(zombiv.x<=145 && zombiv.y<3000){
        gameover=true;//Dokunduklarında kaybedersiniz.
      }
    } 
}
//<--Zombi



//Mermi class-->
class mermi{
      boolean mCiz=true;//Merminin çizilmesinin kontrolü
      boolean ates=false;//Ateşlendi mi? kontrolü
      PVector mermiv=new PVector(144,612);//Merminin çıkış konumu
      float aci;
      void ciz(){
        if(mCiz){
            if(ates==true){//ateşlendi mi? kontrolü
                  mermiv.x+=cos(aci)*20;//konuma gönderilen açının kosinüsünün eklenmesi
                  mermiv.y+=sin(aci)*20;//konuma gönderilen açının sinüsünün eklenmesi
                  fill(#6C6C6C);
                  circle(mermiv.x,mermiv.y,8);//mermi çizimi
                  fill(255);
             }
             int b=0;
             for(int i=zombix;i<stage1.length;i++){//Mermiler zombilere çarpıp çarpmadıklarının kontrolü
                 PVector konum=stage1[i].zombiv;
                 if(mermiv.x>=konum.x && mermiv.y>=konum.y){//eğer aynı konumda iseler
                      stage1[i].display=false;//zombiyi ekrandan sil
                      mermiv=new PVector(-4000,-4000);//mermiyi ekranda başka bir yere taşı
                      zombix++;
                  }
                  b+=250;//zombiler arasındaki mesafe
                  
          }
      }}
      void ates(float acii,boolean atess){//mermi ateşlendiğinde constructer gibi kullanılır.
        ates=atess;
        aci=acii;
      }

}
//<--Mermi


void mouseClicked(){
    start=false;//Oyunun başlaması için değişken
    oyna=true;//Oyunun başlaması için değişken
}
void mouseReleased(){
       mermisesi.play();//Her tıklandığında mermi sesinin oynatılması.
       dx=mouseX;//İmleç yönü tespiti için
       dy=mouseY;//İmleç yönü tespiti için
       float aci=(dy-612)/(dx-146);//Silaha göre mermi gidiş açısının ayarlanması
       mermiler.get(mermi).ates(aci,true);//Mermilerin ateş edilmesi
       if(mermi<200)mermi++;//Mermi sayılarının kontrol edilmesi
       zombisesi.play();//Zombi sesinin başlatılması
  }
