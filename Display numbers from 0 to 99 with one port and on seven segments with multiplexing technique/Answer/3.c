#include <mega32.h>
//#include <stdio.h>
#include <delay.h>
//#asm
//       .equ __lcd_port=0x18;
//#endasm
//#include <lcd.h>

void main(void)
{

int seg[10] = {0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x6F};
int i = 0 , j = 0, k = 0;
//PORTB = 0x00;
     // DDRB = 0x00;
     // lcd_init(16);
     // lcd_clear();
      //lcd_gotoxy(0,4);
      //lcd_putsf("COUNTER");

while (1)
      {
      DDRA = 0xFF;
      DDRC = 0xFF;
      DDRD = 0x00;
      
      
          if(PIND.0 == 0){
              for(k = 0 ; k < 27;k++){         
                  PORTC.0 = 0;
                  PORTC.1 = 1;
                  PORTA = seg[i];
                  delay_ms(1);
                  
                  //lcd_gotoxy(0,1);
                  //lcd_putsf("count 0 to 99");
                  
                  if(j != 0){
                      PORTC.1 = 0;
                      PORTC.0 = 1;
                      PORTA = seg[j];
                      delay_ms(1);
                  }
              }
              i++;
              if(i==10){
               i= 0 ;
               j++;
              }
              if(j == 10){
               j = 0;
              }
          }
          if(PIND.0 == 1){
          //i = 9;
          //j = 9;
              for(k = 0 ; k < 27;k++){
              
                  //lcd_gotoxy(0,1);
                  //lcd_putsf("count 99 to 0");
                           
                  PORTC.0 = 0;
                  PORTC.1 = 1;
                  PORTA = seg[i];
                  delay_ms(1);
                  
                      PORTC.1 = 0;
                      PORTC.0 = 1;
                      PORTA = seg[j];
                      delay_ms(1);
                  
              }
              i--;
              if(i==-1){
               i= 9 ;
               j--;
              }
              if(j == -1){
               j = 9;
              }
          }
          if(PIND.1 == 1){
           i = 0;
           j = 0;
          }
          if(PIND.2 == 1){
           while(1){
           PORTC.0 = 0;
           //lcd_gotoxy(0,1);
           //lcd_putsf("stop in number"+ i+j);
                  PORTC.1 = 1;
                  PORTA = seg[i];
                  delay_ms(1);
                  PORTC.1 = 0;
                  PORTC.0 = 1;
                  PORTA = seg[j];
                  delay_ms(1);
                  if(PIND.2 == 0){
                  break;
                  }
           }
          }
      }


}