
// LCDキャラクタディスプレイ関数のインクルード
#include <LiquidCrystal.h>
#include <Serial.h>

// 変数の定義
#define LED_PIN 13
char buffer[255];
//ア=0x1b
int inputdegit = 0;

// 使用するピンの定義(RS,R/W,Enable,DB4,DB5,DB6,DB7)
LiquidCrystal lcd(7, 8, 9, 10, 11, 12, 13);
 
// 初期化
void setup(){
 
  // シリアルポートを9600 bps[ビット/秒]で初期化
  Serial.begin(9600);
  
  buffer[0]= ' ';
  
  // LCDにオープニングメッセージを表示する
  lcd.begin(2,16);          // IDE0017の場合のみ必要
  lcd.clear();              //　LCD表示をクリア
  lcd.print("Arduino"); // 1行目にメッセージを表示
  lcd.setCursor(3,1);       // カーソルを2行目3カラム目にセット
  lcd.print("TL Moniter"); // 2行目にメッセージを表示
  delay(500);               // 500ミリ秒プログラムを一時停止する
                            // つまり0.5秒の間表示されている
}
 
// 繰り返し処理
void loop(){
 
   // LCDが持っているすべての文字パターン（20H-FFH）を表示する
  short c=0;                // 文字コード用の変数定義
  int   i,j;                // 表示カラム位置用の変数定義
  char tmp;
  
  // シリアルポートより1文字読み込む
  //inputchar = Serial.read();
  Serial.readBytesUntil('\0', buffer, 254);
  
  if(inputdegit != (buffer[0]+buffer[1]) ){
    inputdegit = (buffer[0]+buffer[1]);
  } else {
    i=0;
    while(i<255){
      lcd.clear();              //　LCD表示をクリア
      lcd.print(&buffer[i]); // 1行目にメッセージを表示
      for(j=0;j<16 && '\0' != buffer[i+j];j++);
      lcd.setCursor(0,1);       // カーソルを2行目0カラム目にセット
      lcd.print(&buffer[i+j]); // メッセージを表示
      for(;j<32 && '\0' != buffer[i+j];j++);
      
      delay(2000);
      if(j>=32)
        i += j;
      else
        break;
    }
  }
}
