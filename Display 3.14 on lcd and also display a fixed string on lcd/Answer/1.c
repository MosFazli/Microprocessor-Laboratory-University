#include <mega32.h>
#include <stdio.h>
#include <delay.h>
#include <math.h>
#asm
        .equ __lcd_port=0x18;
#endasm
#include <lcd.h>

void main(void)
{

char str[5];
float piNumber = 3.14159;


while (1)
      {
      DDRB = 0x00;
      PORTB = 0x00;
      DDRA = 0xFF;
      lcd_init(16);
      
      if(PINA.0 == 0){
      lcd_gotoxy(0,0);
      lcd_putsf("This is Exercise");       
        lcd_gotoxy(0,1);
        lcd_putsf("for Microproccesor");  
        }
      if(PINA.0 == 1){
      lcd_gotoxy(0,0);
      lcd_putsf("Mostafa Fazli");       
        lcd_gotoxy(1,1);
        sprintf(str,"Pi = %.2f",piNumber);
        lcd_puts(str);
        delay_ms(50);

        }
}

}
