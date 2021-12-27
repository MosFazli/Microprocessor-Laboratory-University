# include <mega32.h>
#include <stdio.h>
#include <delay.h>
#asm
       .equ __lcd_port=0x18;
#endasm
#include <lcd.h>


void main(void)
{

int i = 0;
int LED[10] = {0b0000,0b0001,0b0010,0b0011,0b0100,0b0101,0b0110,0b0111,0b1000,0b1001};
int LEDSEG[10] = {0b11000000,0b11111001,0b10100100,0b10110000,0b10011001,0b10010010,0b10000010,0b11111000,0b10000000,0b10010000};
    
    PORTB = 0x00;
    DDRB = 0x00;
    lcd_init(16);
    lcd_clear();
    lcd_gotoxy(3,0);
    lcd_putsf("DEC TO BIN");

        
while (1)
      {
  
        DDRA = 0xFF;
        DDRD = 0xFF;
  
                  
        if(PINC.7 == 1){
            if(PINC.0 == 1 && PINC.1 == 0 && PINC.2 == 0 && PINC.3 == 0){
                lcd_gotoxy(0,1);
                lcd_putsf("COUNTING 0 TO 1");
                for(i = 0 ; i <= 1 ; i++){
                    PORTA = LED[i];
                    PORTD = LEDSEG[i];
                    delay_ms(100);
                }
            }
            if(PINC.0 == 0 && PINC.1 == 1 && PINC.2 == 0 && PINC.3 == 0){
                lcd_gotoxy(0,1);
                lcd_putsf("COUNTING 0 TO 2");
                for(i = 0 ; i <= 2 ; i++){
                    PORTA = LED[i];
                    PORTD = LEDSEG[i];
                    delay_ms(100);
                }
            }
            if(PINC.0 == 1 && PINC.1 == 1 && PINC.2 == 0 && PINC.3 == 0){
                lcd_gotoxy(0,1);
                lcd_putsf("COUNTING 0 TO 3");
                for(i = 0 ; i <= 3 ; i++){
                    PORTA = LED[i];
                    PORTD = LEDSEG[i];
                    delay_ms(100);
                }
            }
            if(PINC.0 == 0 && PINC.1 == 0 && PINC.2 == 1 && PINC.3 == 0){
                lcd_gotoxy(0,1);
                lcd_putsf("COUNTING 0 TO 4");
                for(i = 0 ; i <= 4 ; i++){
                    PORTA = LED[i];
                    PORTD = LEDSEG[i];
                    delay_ms(100);
                }
            }
            if(PINC.0 == 1 && PINC.0 == 1 && PINC.2 == 1 && PINC.3 == 0){
                lcd_gotoxy(0,1);
                lcd_putsf("COUNTING 0 TO 5");
                for(i = 0 ; i <= 5 ; i++){
                    PORTA = LED[i];
                    PORTD = LEDSEG[i];
                    delay_ms(100);
                }
            }
            if(PINC.0 == 0 && PINC.1 == 1 && PINC.2 == 1 && PINC.3 == 0){
                lcd_gotoxy(0,1);
                lcd_putsf("COUNTING 0 TO 6");
                for(i = 0 ; i <= 6 ; i++){
                    PORTA = LED[i];
                    PORTD = LEDSEG[i];
                    delay_ms(100);
                }
            }
            if(PINC.0 == 1 && PINC.1 == 1 && PINC.2 == 1 && PINC.3 == 0){
                lcd_gotoxy(0,1);
                lcd_putsf("COUNTING 0 TO 7");
                for(i = 0 ; i <= 7 ; i++){
                    PORTA = LED[i];
                    PORTD = LEDSEG[i];
                    delay_ms(100);
                }
            }
            if(PINC.0 == 0 && PINC.1 == 0 && PINC.2 == 0 && PINC.3 == 1){
                lcd_gotoxy(0,1);
                lcd_putsf("COUNTING 0 TO 8");
                for(i = 0 ; i <= 8 ; i++){
                    PORTA = LED[i];
                    PORTD = LEDSEG[i];
                    delay_ms(100);
                }
            }
            if(PINC.0 == 1 && PINC.1 == 0 && PINC.2 == 0 && PINC.3 == 1){
                lcd_gotoxy(0,1);
                lcd_putsf("COUNTING 0 TO 9");
                for(i = 0 ; i <= 9 ; i++){
                    PORTA = LED[i];
                    PORTD = LEDSEG[i];
                    delay_ms(100);
                }
            }
            if(PINC.0 == 0 && PINC.1 == 0 && PINC.2 == 0 && PINC.3 == 0){
                lcd_gotoxy(3,1);
                lcd_putsf("CAN'T COUNT");
            }
            
            
        } else{
            if(PINC.0 == 1 && PINC.1 == 0 && PINC.2 == 0 && PINC.3 == 0){
                lcd_gotoxy(0,1);
                lcd_putsf("COUNTING 1 TO 0");
                for(i = 1 ; i >=0 ; i--){
                PORTA = LED[i];
                PORTD = LEDSEG[i];
                delay_ms(100);          
                }
            }
            if(PINC.0 == 0 && PINC.1 == 1 && PINC.2 == 0 && PINC.3 == 0){
                lcd_gotoxy(0,1);
                lcd_putsf("COUNTING 2 TO 0");
                for(i = 2 ; i >=0 ; i--){
                PORTA = LED[i];
                PORTD = LEDSEG[i];
                delay_ms(100);          
                }
            }
            if(PINC.0 == 1 && PINC.1 == 1 && PINC.2 == 0 && PINC.3 == 0){
                lcd_gotoxy(0,1);
                lcd_putsf("COUNTING 3 TO 0");
                for(i = 3 ; i >=0 ; i--){
                PORTA = LED[i];
                PORTD = LEDSEG[i];
                delay_ms(100);          
                }
            }
            if(PINC.0 == 0 && PINC.1 == 0 && PINC.2 == 1 && PINC.3 == 0){
                lcd_gotoxy(0,1);
                lcd_putsf("COUNTING 4 TO 0");
                for(i = 4 ; i >=0 ; i--){
                PORTA = LED[i];
                PORTD = LEDSEG[i];
                delay_ms(100);          
                }
            }
            if(PINC.0 == 1 && PINC.1 == 0 && PINC.2 == 1 && PINC.3 == 0){
                lcd_gotoxy(0,1);
                lcd_putsf("COUNTING 5 TO 0");
                for(i = 5 ; i >=0 ; i--){
                PORTA = LED[i];
                PORTD = LEDSEG[i];
                delay_ms(100);          
                }
            }
            if(PINC.0 == 0 && PINC.1 == 1 && PINC.2 == 1 && PINC.3 == 0){
                lcd_gotoxy(0,1);
                lcd_putsf("COUNTING 6 TO 0");
                for(i = 6 ; i >=0 ; i--){
                PORTA = LED[i];
                PORTD = LEDSEG[i];
                delay_ms(100);          
                }
            }
            if(PINC.0 == 1 && PINC.1 == 1 && PINC.2 == 1 && PINC.3 == 0){
                lcd_gotoxy(0,1);
                lcd_putsf("COUNTING 7 TO 0");
                for(i = 7 ; i >=0 ; i--){
                PORTA = LED[i];
                PORTD = LEDSEG[i];
                delay_ms(100);          
                }
            }
            if(PINC.0 == 0 && PINC.1 == 0 && PINC.2 == 0 && PINC.3 == 1){
                lcd_gotoxy(0,1);
                lcd_putsf("COUNTING 8 TO 0");
                for(i = 8 ; i >=0 ; i--){
                PORTA = LED[i];
                PORTD = LEDSEG[i];
                delay_ms(100);          
                }
            }
            if(PINC.0 == 1 && PINC.1 == 0 && PINC.2 == 0 && PINC.3 == 1){
                lcd_gotoxy(0,1);
                lcd_putsf("COUNTING 9 TO 0");
                for(i = 9 ; i >=0 ; i--){
                PORTA = LED[i];
                PORTD = LEDSEG[i];
                delay_ms(100);          
                }
            }
            if(PINC.0 == 0 && PINC.1 == 0 && PINC.2 == 0 && PINC.3 == 0){
                lcd_gotoxy(3,1);
                lcd_putsf("CAN'T COUNT");
            }   
        }

      }
}
