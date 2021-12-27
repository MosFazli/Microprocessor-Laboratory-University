
;CodeVisionAVR C Compiler V3.12 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega32
;Program type           : Application
;Clock frequency        : 8.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 512 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega32
	#pragma AVRPART MEMORY PROG_FLASH 32768
	#pragma AVRPART MEMORY EEPROM 1024
	#pragma AVRPART MEMORY INT_SRAM SIZE 2048
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x085F
	.EQU __DSTACK_SIZE=0x0200
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF __lcd_x=R5
	.DEF __lcd_y=R4
	.DEF __lcd_maxx=R7

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_tbl10_G100:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G100:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

_0x3:
	.DB  0xC0,0x0,0xF9,0x0,0xA4,0x0,0xB0,0x0
	.DB  0x99,0x0,0x92,0x0,0x82,0x0,0xF8,0x0
	.DB  0x80,0x0,0x90,0x0,0x0,0x0,0x1,0x0
	.DB  0x2,0x0,0x3,0x0,0x4,0x0,0x5,0x0
	.DB  0x6,0x0,0x7,0x0,0x8,0x0,0x9,0x0
_0x0:
	.DB  0x44,0x45,0x43,0x20,0x54,0x4F,0x20,0x42
	.DB  0x49,0x4E,0x0,0x43,0x4F,0x55,0x4E,0x54
	.DB  0x49,0x4E,0x47,0x20,0x30,0x20,0x54,0x4F
	.DB  0x20,0x31,0x0,0x43,0x4F,0x55,0x4E,0x54
	.DB  0x49,0x4E,0x47,0x20,0x30,0x20,0x54,0x4F
	.DB  0x20,0x32,0x0,0x43,0x4F,0x55,0x4E,0x54
	.DB  0x49,0x4E,0x47,0x20,0x30,0x20,0x54,0x4F
	.DB  0x20,0x33,0x0,0x43,0x4F,0x55,0x4E,0x54
	.DB  0x49,0x4E,0x47,0x20,0x30,0x20,0x54,0x4F
	.DB  0x20,0x34,0x0,0x43,0x4F,0x55,0x4E,0x54
	.DB  0x49,0x4E,0x47,0x20,0x30,0x20,0x54,0x4F
	.DB  0x20,0x35,0x0,0x43,0x4F,0x55,0x4E,0x54
	.DB  0x49,0x4E,0x47,0x20,0x30,0x20,0x54,0x4F
	.DB  0x20,0x36,0x0,0x43,0x4F,0x55,0x4E,0x54
	.DB  0x49,0x4E,0x47,0x20,0x30,0x20,0x54,0x4F
	.DB  0x20,0x37,0x0,0x43,0x4F,0x55,0x4E,0x54
	.DB  0x49,0x4E,0x47,0x20,0x30,0x20,0x54,0x4F
	.DB  0x20,0x38,0x0,0x43,0x4F,0x55,0x4E,0x54
	.DB  0x49,0x4E,0x47,0x20,0x30,0x20,0x54,0x4F
	.DB  0x20,0x39,0x0,0x43,0x41,0x4E,0x27,0x54
	.DB  0x20,0x43,0x4F,0x55,0x4E,0x54,0x0,0x43
	.DB  0x4F,0x55,0x4E,0x54,0x49,0x4E,0x47,0x20
	.DB  0x31,0x20,0x54,0x4F,0x20,0x30,0x0,0x43
	.DB  0x4F,0x55,0x4E,0x54,0x49,0x4E,0x47,0x20
	.DB  0x32,0x20,0x54,0x4F,0x20,0x30,0x0,0x43
	.DB  0x4F,0x55,0x4E,0x54,0x49,0x4E,0x47,0x20
	.DB  0x33,0x20,0x54,0x4F,0x20,0x30,0x0,0x43
	.DB  0x4F,0x55,0x4E,0x54,0x49,0x4E,0x47,0x20
	.DB  0x34,0x20,0x54,0x4F,0x20,0x30,0x0,0x43
	.DB  0x4F,0x55,0x4E,0x54,0x49,0x4E,0x47,0x20
	.DB  0x35,0x20,0x54,0x4F,0x20,0x30,0x0,0x43
	.DB  0x4F,0x55,0x4E,0x54,0x49,0x4E,0x47,0x20
	.DB  0x36,0x20,0x54,0x4F,0x20,0x30,0x0,0x43
	.DB  0x4F,0x55,0x4E,0x54,0x49,0x4E,0x47,0x20
	.DB  0x37,0x20,0x54,0x4F,0x20,0x30,0x0,0x43
	.DB  0x4F,0x55,0x4E,0x54,0x49,0x4E,0x47,0x20
	.DB  0x38,0x20,0x54,0x4F,0x20,0x30,0x0,0x43
	.DB  0x4F,0x55,0x4E,0x54,0x49,0x4E,0x47,0x20
	.DB  0x39,0x20,0x54,0x4F,0x20,0x30,0x0
_0x2020003:
	.DB  0x80,0xC0

__GLOBAL_INI_TBL:
	.DW  0x02
	.DW  __base_y_G101
	.DW  _0x2020003*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x260

	.CSEG
;# include <mega32.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include <stdio.h>
;#include <delay.h>
;#asm
       .equ __lcd_port=0x18;
; 0000 0006 #endasm
;#include <lcd.h>
;
;
;void main(void)
; 0000 000B {

	.CSEG
_main:
; .FSTART _main
; 0000 000C 
; 0000 000D int i = 0;
; 0000 000E int LED[10] = {0b0000,0b0001,0b0010,0b0011,0b0100,0b0101,0b0110,0b0111,0b1000,0b1001};
; 0000 000F int LEDSEG[10] = {0b11000000,0b11111001,0b10100100,0b10110000,0b10011001,0b10010010,0b10000010,0b11111000,0b10000000,0b1 ...
; 0000 0010 
; 0000 0011     PORTB = 0x00;
	SBIW R28,40
	LDI  R24,40
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x3*2)
	LDI  R31,HIGH(_0x3*2)
	CALL __INITLOCB
;	i -> R16,R17
;	LED -> Y+20
;	LEDSEG -> Y+0
	__GETWRN 16,17,0
	LDI  R30,LOW(0)
	OUT  0x18,R30
; 0000 0012     DDRB = 0x00;
	OUT  0x17,R30
; 0000 0013     lcd_init(16);
	LDI  R26,LOW(16)
	CALL _lcd_init
; 0000 0014     lcd_clear();
	CALL _lcd_clear
; 0000 0015     lcd_gotoxy(3,0);
	LDI  R30,LOW(3)
	ST   -Y,R30
	LDI  R26,LOW(0)
	CALL _lcd_gotoxy
; 0000 0016     lcd_putsf("DEC TO BIN");
	__POINTW2FN _0x0,0
	CALL _lcd_putsf
; 0000 0017 
; 0000 0018 
; 0000 0019 while (1)
_0x4:
; 0000 001A       {
; 0000 001B 
; 0000 001C         DDRA = 0xFF;
	LDI  R30,LOW(255)
	OUT  0x1A,R30
; 0000 001D         DDRD = 0xFF;
	OUT  0x11,R30
; 0000 001E 
; 0000 001F 
; 0000 0020         if(PINC.7 == 1){
	SBIS 0x13,7
	RJMP _0x7
; 0000 0021             if(PINC.0 == 1 && PINC.1 == 0 && PINC.2 == 0 && PINC.3 == 0){
	SBIS 0x13,0
	RJMP _0x9
	SBIC 0x13,1
	RJMP _0x9
	SBIC 0x13,2
	RJMP _0x9
	SBIS 0x13,3
	RJMP _0xA
_0x9:
	RJMP _0x8
_0xA:
; 0000 0022                 lcd_gotoxy(0,1);
	CALL SUBOPT_0x0
; 0000 0023                 lcd_putsf("COUNTING 0 TO 1");
	__POINTW2FN _0x0,11
	CALL SUBOPT_0x1
; 0000 0024                 for(i = 0 ; i <= 1 ; i++){
_0xC:
	__CPWRN 16,17,2
	BRGE _0xD
; 0000 0025                     PORTA = LED[i];
	CALL SUBOPT_0x2
; 0000 0026                     PORTD = LEDSEG[i];
; 0000 0027                     delay_ms(100);
; 0000 0028                 }
	__ADDWRN 16,17,1
	RJMP _0xC
_0xD:
; 0000 0029             }
; 0000 002A             if(PINC.0 == 0 && PINC.1 == 1 && PINC.2 == 0 && PINC.3 == 0){
_0x8:
	SBIC 0x13,0
	RJMP _0xF
	SBIS 0x13,1
	RJMP _0xF
	SBIC 0x13,2
	RJMP _0xF
	SBIS 0x13,3
	RJMP _0x10
_0xF:
	RJMP _0xE
_0x10:
; 0000 002B                 lcd_gotoxy(0,1);
	CALL SUBOPT_0x0
; 0000 002C                 lcd_putsf("COUNTING 0 TO 2");
	__POINTW2FN _0x0,27
	CALL SUBOPT_0x1
; 0000 002D                 for(i = 0 ; i <= 2 ; i++){
_0x12:
	__CPWRN 16,17,3
	BRGE _0x13
; 0000 002E                     PORTA = LED[i];
	CALL SUBOPT_0x2
; 0000 002F                     PORTD = LEDSEG[i];
; 0000 0030                     delay_ms(100);
; 0000 0031                 }
	__ADDWRN 16,17,1
	RJMP _0x12
_0x13:
; 0000 0032             }
; 0000 0033             if(PINC.0 == 1 && PINC.1 == 1 && PINC.2 == 0 && PINC.3 == 0){
_0xE:
	SBIS 0x13,0
	RJMP _0x15
	SBIS 0x13,1
	RJMP _0x15
	SBIC 0x13,2
	RJMP _0x15
	SBIS 0x13,3
	RJMP _0x16
_0x15:
	RJMP _0x14
_0x16:
; 0000 0034                 lcd_gotoxy(0,1);
	CALL SUBOPT_0x0
; 0000 0035                 lcd_putsf("COUNTING 0 TO 3");
	__POINTW2FN _0x0,43
	CALL SUBOPT_0x1
; 0000 0036                 for(i = 0 ; i <= 3 ; i++){
_0x18:
	__CPWRN 16,17,4
	BRGE _0x19
; 0000 0037                     PORTA = LED[i];
	CALL SUBOPT_0x2
; 0000 0038                     PORTD = LEDSEG[i];
; 0000 0039                     delay_ms(100);
; 0000 003A                 }
	__ADDWRN 16,17,1
	RJMP _0x18
_0x19:
; 0000 003B             }
; 0000 003C             if(PINC.0 == 0 && PINC.1 == 0 && PINC.2 == 1 && PINC.3 == 0){
_0x14:
	SBIC 0x13,0
	RJMP _0x1B
	SBIC 0x13,1
	RJMP _0x1B
	SBIS 0x13,2
	RJMP _0x1B
	SBIS 0x13,3
	RJMP _0x1C
_0x1B:
	RJMP _0x1A
_0x1C:
; 0000 003D                 lcd_gotoxy(0,1);
	CALL SUBOPT_0x0
; 0000 003E                 lcd_putsf("COUNTING 0 TO 4");
	__POINTW2FN _0x0,59
	CALL SUBOPT_0x1
; 0000 003F                 for(i = 0 ; i <= 4 ; i++){
_0x1E:
	__CPWRN 16,17,5
	BRGE _0x1F
; 0000 0040                     PORTA = LED[i];
	CALL SUBOPT_0x2
; 0000 0041                     PORTD = LEDSEG[i];
; 0000 0042                     delay_ms(100);
; 0000 0043                 }
	__ADDWRN 16,17,1
	RJMP _0x1E
_0x1F:
; 0000 0044             }
; 0000 0045             if(PINC.0 == 1 && PINC.0 == 1 && PINC.2 == 1 && PINC.3 == 0){
_0x1A:
	SBIS 0x13,0
	RJMP _0x21
	SBIS 0x13,0
	RJMP _0x21
	SBIS 0x13,2
	RJMP _0x21
	SBIS 0x13,3
	RJMP _0x22
_0x21:
	RJMP _0x20
_0x22:
; 0000 0046                 lcd_gotoxy(0,1);
	CALL SUBOPT_0x0
; 0000 0047                 lcd_putsf("COUNTING 0 TO 5");
	__POINTW2FN _0x0,75
	CALL SUBOPT_0x1
; 0000 0048                 for(i = 0 ; i <= 5 ; i++){
_0x24:
	__CPWRN 16,17,6
	BRGE _0x25
; 0000 0049                     PORTA = LED[i];
	CALL SUBOPT_0x2
; 0000 004A                     PORTD = LEDSEG[i];
; 0000 004B                     delay_ms(100);
; 0000 004C                 }
	__ADDWRN 16,17,1
	RJMP _0x24
_0x25:
; 0000 004D             }
; 0000 004E             if(PINC.0 == 0 && PINC.1 == 1 && PINC.2 == 1 && PINC.3 == 0){
_0x20:
	SBIC 0x13,0
	RJMP _0x27
	SBIS 0x13,1
	RJMP _0x27
	SBIS 0x13,2
	RJMP _0x27
	SBIS 0x13,3
	RJMP _0x28
_0x27:
	RJMP _0x26
_0x28:
; 0000 004F                 lcd_gotoxy(0,1);
	CALL SUBOPT_0x0
; 0000 0050                 lcd_putsf("COUNTING 0 TO 6");
	__POINTW2FN _0x0,91
	CALL SUBOPT_0x1
; 0000 0051                 for(i = 0 ; i <= 6 ; i++){
_0x2A:
	__CPWRN 16,17,7
	BRGE _0x2B
; 0000 0052                     PORTA = LED[i];
	CALL SUBOPT_0x2
; 0000 0053                     PORTD = LEDSEG[i];
; 0000 0054                     delay_ms(100);
; 0000 0055                 }
	__ADDWRN 16,17,1
	RJMP _0x2A
_0x2B:
; 0000 0056             }
; 0000 0057             if(PINC.0 == 1 && PINC.1 == 1 && PINC.2 == 1 && PINC.3 == 0){
_0x26:
	SBIS 0x13,0
	RJMP _0x2D
	SBIS 0x13,1
	RJMP _0x2D
	SBIS 0x13,2
	RJMP _0x2D
	SBIS 0x13,3
	RJMP _0x2E
_0x2D:
	RJMP _0x2C
_0x2E:
; 0000 0058                 lcd_gotoxy(0,1);
	CALL SUBOPT_0x0
; 0000 0059                 lcd_putsf("COUNTING 0 TO 7");
	__POINTW2FN _0x0,107
	CALL SUBOPT_0x1
; 0000 005A                 for(i = 0 ; i <= 7 ; i++){
_0x30:
	__CPWRN 16,17,8
	BRGE _0x31
; 0000 005B                     PORTA = LED[i];
	CALL SUBOPT_0x2
; 0000 005C                     PORTD = LEDSEG[i];
; 0000 005D                     delay_ms(100);
; 0000 005E                 }
	__ADDWRN 16,17,1
	RJMP _0x30
_0x31:
; 0000 005F             }
; 0000 0060             if(PINC.0 == 0 && PINC.1 == 0 && PINC.2 == 0 && PINC.3 == 1){
_0x2C:
	SBIC 0x13,0
	RJMP _0x33
	SBIC 0x13,1
	RJMP _0x33
	SBIC 0x13,2
	RJMP _0x33
	SBIC 0x13,3
	RJMP _0x34
_0x33:
	RJMP _0x32
_0x34:
; 0000 0061                 lcd_gotoxy(0,1);
	CALL SUBOPT_0x0
; 0000 0062                 lcd_putsf("COUNTING 0 TO 8");
	__POINTW2FN _0x0,123
	CALL SUBOPT_0x1
; 0000 0063                 for(i = 0 ; i <= 8 ; i++){
_0x36:
	__CPWRN 16,17,9
	BRGE _0x37
; 0000 0064                     PORTA = LED[i];
	CALL SUBOPT_0x2
; 0000 0065                     PORTD = LEDSEG[i];
; 0000 0066                     delay_ms(100);
; 0000 0067                 }
	__ADDWRN 16,17,1
	RJMP _0x36
_0x37:
; 0000 0068             }
; 0000 0069             if(PINC.0 == 1 && PINC.1 == 0 && PINC.2 == 0 && PINC.3 == 1){
_0x32:
	SBIS 0x13,0
	RJMP _0x39
	SBIC 0x13,1
	RJMP _0x39
	SBIC 0x13,2
	RJMP _0x39
	SBIC 0x13,3
	RJMP _0x3A
_0x39:
	RJMP _0x38
_0x3A:
; 0000 006A                 lcd_gotoxy(0,1);
	CALL SUBOPT_0x0
; 0000 006B                 lcd_putsf("COUNTING 0 TO 9");
	__POINTW2FN _0x0,139
	CALL SUBOPT_0x1
; 0000 006C                 for(i = 0 ; i <= 9 ; i++){
_0x3C:
	__CPWRN 16,17,10
	BRGE _0x3D
; 0000 006D                     PORTA = LED[i];
	CALL SUBOPT_0x2
; 0000 006E                     PORTD = LEDSEG[i];
; 0000 006F                     delay_ms(100);
; 0000 0070                 }
	__ADDWRN 16,17,1
	RJMP _0x3C
_0x3D:
; 0000 0071             }
; 0000 0072             if(PINC.0 == 0 && PINC.1 == 0 && PINC.2 == 0 && PINC.3 == 0){
_0x38:
	SBIC 0x13,0
	RJMP _0x3F
	SBIC 0x13,1
	RJMP _0x3F
	SBIC 0x13,2
	RJMP _0x3F
	SBIS 0x13,3
	RJMP _0x40
_0x3F:
	RJMP _0x3E
_0x40:
; 0000 0073                 lcd_gotoxy(3,1);
	CALL SUBOPT_0x3
; 0000 0074                 lcd_putsf("CAN'T COUNT");
; 0000 0075             }
; 0000 0076 
; 0000 0077 
; 0000 0078         } else{
_0x3E:
	RJMP _0x41
_0x7:
; 0000 0079             if(PINC.0 == 1 && PINC.1 == 0 && PINC.2 == 0 && PINC.3 == 0){
	SBIS 0x13,0
	RJMP _0x43
	SBIC 0x13,1
	RJMP _0x43
	SBIC 0x13,2
	RJMP _0x43
	SBIS 0x13,3
	RJMP _0x44
_0x43:
	RJMP _0x42
_0x44:
; 0000 007A                 lcd_gotoxy(0,1);
	CALL SUBOPT_0x0
; 0000 007B                 lcd_putsf("COUNTING 1 TO 0");
	__POINTW2FN _0x0,167
	CALL _lcd_putsf
; 0000 007C                 for(i = 1 ; i >=0 ; i--){
	__GETWRN 16,17,1
_0x46:
	TST  R17
	BRMI _0x47
; 0000 007D                 PORTA = LED[i];
	CALL SUBOPT_0x2
; 0000 007E                 PORTD = LEDSEG[i];
; 0000 007F                 delay_ms(100);
; 0000 0080                 }
	__SUBWRN 16,17,1
	RJMP _0x46
_0x47:
; 0000 0081             }
; 0000 0082             if(PINC.0 == 0 && PINC.1 == 1 && PINC.2 == 0 && PINC.3 == 0){
_0x42:
	SBIC 0x13,0
	RJMP _0x49
	SBIS 0x13,1
	RJMP _0x49
	SBIC 0x13,2
	RJMP _0x49
	SBIS 0x13,3
	RJMP _0x4A
_0x49:
	RJMP _0x48
_0x4A:
; 0000 0083                 lcd_gotoxy(0,1);
	CALL SUBOPT_0x0
; 0000 0084                 lcd_putsf("COUNTING 2 TO 0");
	__POINTW2FN _0x0,183
	CALL _lcd_putsf
; 0000 0085                 for(i = 2 ; i >=0 ; i--){
	__GETWRN 16,17,2
_0x4C:
	TST  R17
	BRMI _0x4D
; 0000 0086                 PORTA = LED[i];
	CALL SUBOPT_0x2
; 0000 0087                 PORTD = LEDSEG[i];
; 0000 0088                 delay_ms(100);
; 0000 0089                 }
	__SUBWRN 16,17,1
	RJMP _0x4C
_0x4D:
; 0000 008A             }
; 0000 008B             if(PINC.0 == 1 && PINC.1 == 1 && PINC.2 == 0 && PINC.3 == 0){
_0x48:
	SBIS 0x13,0
	RJMP _0x4F
	SBIS 0x13,1
	RJMP _0x4F
	SBIC 0x13,2
	RJMP _0x4F
	SBIS 0x13,3
	RJMP _0x50
_0x4F:
	RJMP _0x4E
_0x50:
; 0000 008C                 lcd_gotoxy(0,1);
	CALL SUBOPT_0x0
; 0000 008D                 lcd_putsf("COUNTING 3 TO 0");
	__POINTW2FN _0x0,199
	CALL _lcd_putsf
; 0000 008E                 for(i = 3 ; i >=0 ; i--){
	__GETWRN 16,17,3
_0x52:
	TST  R17
	BRMI _0x53
; 0000 008F                 PORTA = LED[i];
	CALL SUBOPT_0x2
; 0000 0090                 PORTD = LEDSEG[i];
; 0000 0091                 delay_ms(100);
; 0000 0092                 }
	__SUBWRN 16,17,1
	RJMP _0x52
_0x53:
; 0000 0093             }
; 0000 0094             if(PINC.0 == 0 && PINC.1 == 0 && PINC.2 == 1 && PINC.3 == 0){
_0x4E:
	SBIC 0x13,0
	RJMP _0x55
	SBIC 0x13,1
	RJMP _0x55
	SBIS 0x13,2
	RJMP _0x55
	SBIS 0x13,3
	RJMP _0x56
_0x55:
	RJMP _0x54
_0x56:
; 0000 0095                 lcd_gotoxy(0,1);
	CALL SUBOPT_0x0
; 0000 0096                 lcd_putsf("COUNTING 4 TO 0");
	__POINTW2FN _0x0,215
	CALL _lcd_putsf
; 0000 0097                 for(i = 4 ; i >=0 ; i--){
	__GETWRN 16,17,4
_0x58:
	TST  R17
	BRMI _0x59
; 0000 0098                 PORTA = LED[i];
	CALL SUBOPT_0x2
; 0000 0099                 PORTD = LEDSEG[i];
; 0000 009A                 delay_ms(100);
; 0000 009B                 }
	__SUBWRN 16,17,1
	RJMP _0x58
_0x59:
; 0000 009C             }
; 0000 009D             if(PINC.0 == 1 && PINC.1 == 0 && PINC.2 == 1 && PINC.3 == 0){
_0x54:
	SBIS 0x13,0
	RJMP _0x5B
	SBIC 0x13,1
	RJMP _0x5B
	SBIS 0x13,2
	RJMP _0x5B
	SBIS 0x13,3
	RJMP _0x5C
_0x5B:
	RJMP _0x5A
_0x5C:
; 0000 009E                 lcd_gotoxy(0,1);
	CALL SUBOPT_0x0
; 0000 009F                 lcd_putsf("COUNTING 5 TO 0");
	__POINTW2FN _0x0,231
	CALL _lcd_putsf
; 0000 00A0                 for(i = 5 ; i >=0 ; i--){
	__GETWRN 16,17,5
_0x5E:
	TST  R17
	BRMI _0x5F
; 0000 00A1                 PORTA = LED[i];
	CALL SUBOPT_0x2
; 0000 00A2                 PORTD = LEDSEG[i];
; 0000 00A3                 delay_ms(100);
; 0000 00A4                 }
	__SUBWRN 16,17,1
	RJMP _0x5E
_0x5F:
; 0000 00A5             }
; 0000 00A6             if(PINC.0 == 0 && PINC.1 == 1 && PINC.2 == 1 && PINC.3 == 0){
_0x5A:
	SBIC 0x13,0
	RJMP _0x61
	SBIS 0x13,1
	RJMP _0x61
	SBIS 0x13,2
	RJMP _0x61
	SBIS 0x13,3
	RJMP _0x62
_0x61:
	RJMP _0x60
_0x62:
; 0000 00A7                 lcd_gotoxy(0,1);
	CALL SUBOPT_0x0
; 0000 00A8                 lcd_putsf("COUNTING 6 TO 0");
	__POINTW2FN _0x0,247
	CALL _lcd_putsf
; 0000 00A9                 for(i = 6 ; i >=0 ; i--){
	__GETWRN 16,17,6
_0x64:
	TST  R17
	BRMI _0x65
; 0000 00AA                 PORTA = LED[i];
	CALL SUBOPT_0x2
; 0000 00AB                 PORTD = LEDSEG[i];
; 0000 00AC                 delay_ms(100);
; 0000 00AD                 }
	__SUBWRN 16,17,1
	RJMP _0x64
_0x65:
; 0000 00AE             }
; 0000 00AF             if(PINC.0 == 1 && PINC.1 == 1 && PINC.2 == 1 && PINC.3 == 0){
_0x60:
	SBIS 0x13,0
	RJMP _0x67
	SBIS 0x13,1
	RJMP _0x67
	SBIS 0x13,2
	RJMP _0x67
	SBIS 0x13,3
	RJMP _0x68
_0x67:
	RJMP _0x66
_0x68:
; 0000 00B0                 lcd_gotoxy(0,1);
	CALL SUBOPT_0x0
; 0000 00B1                 lcd_putsf("COUNTING 7 TO 0");
	__POINTW2FN _0x0,263
	CALL _lcd_putsf
; 0000 00B2                 for(i = 7 ; i >=0 ; i--){
	__GETWRN 16,17,7
_0x6A:
	TST  R17
	BRMI _0x6B
; 0000 00B3                 PORTA = LED[i];
	CALL SUBOPT_0x2
; 0000 00B4                 PORTD = LEDSEG[i];
; 0000 00B5                 delay_ms(100);
; 0000 00B6                 }
	__SUBWRN 16,17,1
	RJMP _0x6A
_0x6B:
; 0000 00B7             }
; 0000 00B8             if(PINC.0 == 0 && PINC.1 == 0 && PINC.2 == 0 && PINC.3 == 1){
_0x66:
	SBIC 0x13,0
	RJMP _0x6D
	SBIC 0x13,1
	RJMP _0x6D
	SBIC 0x13,2
	RJMP _0x6D
	SBIC 0x13,3
	RJMP _0x6E
_0x6D:
	RJMP _0x6C
_0x6E:
; 0000 00B9                 lcd_gotoxy(0,1);
	CALL SUBOPT_0x0
; 0000 00BA                 lcd_putsf("COUNTING 8 TO 0");
	__POINTW2FN _0x0,279
	CALL _lcd_putsf
; 0000 00BB                 for(i = 8 ; i >=0 ; i--){
	__GETWRN 16,17,8
_0x70:
	TST  R17
	BRMI _0x71
; 0000 00BC                 PORTA = LED[i];
	CALL SUBOPT_0x2
; 0000 00BD                 PORTD = LEDSEG[i];
; 0000 00BE                 delay_ms(100);
; 0000 00BF                 }
	__SUBWRN 16,17,1
	RJMP _0x70
_0x71:
; 0000 00C0             }
; 0000 00C1             if(PINC.0 == 1 && PINC.1 == 0 && PINC.2 == 0 && PINC.3 == 1){
_0x6C:
	SBIS 0x13,0
	RJMP _0x73
	SBIC 0x13,1
	RJMP _0x73
	SBIC 0x13,2
	RJMP _0x73
	SBIC 0x13,3
	RJMP _0x74
_0x73:
	RJMP _0x72
_0x74:
; 0000 00C2                 lcd_gotoxy(0,1);
	CALL SUBOPT_0x0
; 0000 00C3                 lcd_putsf("COUNTING 9 TO 0");
	__POINTW2FN _0x0,295
	CALL _lcd_putsf
; 0000 00C4                 for(i = 9 ; i >=0 ; i--){
	__GETWRN 16,17,9
_0x76:
	TST  R17
	BRMI _0x77
; 0000 00C5                 PORTA = LED[i];
	CALL SUBOPT_0x2
; 0000 00C6                 PORTD = LEDSEG[i];
; 0000 00C7                 delay_ms(100);
; 0000 00C8                 }
	__SUBWRN 16,17,1
	RJMP _0x76
_0x77:
; 0000 00C9             }
; 0000 00CA             if(PINC.0 == 0 && PINC.1 == 0 && PINC.2 == 0 && PINC.3 == 0){
_0x72:
	SBIC 0x13,0
	RJMP _0x79
	SBIC 0x13,1
	RJMP _0x79
	SBIC 0x13,2
	RJMP _0x79
	SBIS 0x13,3
	RJMP _0x7A
_0x79:
	RJMP _0x78
_0x7A:
; 0000 00CB                 lcd_gotoxy(3,1);
	CALL SUBOPT_0x3
; 0000 00CC                 lcd_putsf("CAN'T COUNT");
; 0000 00CD             }
; 0000 00CE         }
_0x78:
_0x41:
; 0000 00CF 
; 0000 00D0       }
	RJMP _0x4
; 0000 00D1 }
_0x7B:
	RJMP _0x7B
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG
    .equ __lcd_direction=__lcd_port-1
    .equ __lcd_pin=__lcd_port-2
    .equ __lcd_rs=0
    .equ __lcd_rd=1
    .equ __lcd_enable=2
    .equ __lcd_busy_flag=7

	.DSEG

	.CSEG
__lcd_delay_G101:
; .FSTART __lcd_delay_G101
    ldi   r31,15
__lcd_delay0:
    dec   r31
    brne  __lcd_delay0
	RET
; .FEND
__lcd_ready:
; .FSTART __lcd_ready
    in    r26,__lcd_direction
    andi  r26,0xf                 ;set as input
    out   __lcd_direction,r26
    sbi   __lcd_port,__lcd_rd     ;RD=1
    cbi   __lcd_port,__lcd_rs     ;RS=0
__lcd_busy:
	RCALL __lcd_delay_G101
    sbi   __lcd_port,__lcd_enable ;EN=1
	RCALL __lcd_delay_G101
    in    r26,__lcd_pin
    cbi   __lcd_port,__lcd_enable ;EN=0
	RCALL __lcd_delay_G101
    sbi   __lcd_port,__lcd_enable ;EN=1
	RCALL __lcd_delay_G101
    cbi   __lcd_port,__lcd_enable ;EN=0
    sbrc  r26,__lcd_busy_flag
    rjmp  __lcd_busy
	RET
; .FEND
__lcd_write_nibble_G101:
; .FSTART __lcd_write_nibble_G101
    andi  r26,0xf0
    or    r26,r27
    out   __lcd_port,r26          ;write
    sbi   __lcd_port,__lcd_enable ;EN=1
	CALL __lcd_delay_G101
    cbi   __lcd_port,__lcd_enable ;EN=0
	CALL __lcd_delay_G101
	RET
; .FEND
__lcd_write_data:
; .FSTART __lcd_write_data
	ST   -Y,R26
    cbi  __lcd_port,__lcd_rd 	  ;RD=0
    in    r26,__lcd_direction
    ori   r26,0xf0 | (1<<__lcd_rs) | (1<<__lcd_rd) | (1<<__lcd_enable) ;set as output
    out   __lcd_direction,r26
    in    r27,__lcd_port
    andi  r27,0xf
    ld    r26,y
	RCALL __lcd_write_nibble_G101
    ld    r26,y
    swap  r26
	RCALL __lcd_write_nibble_G101
    sbi   __lcd_port,__lcd_rd     ;RD=1
	JMP  _0x2080001
; .FEND
__lcd_read_nibble_G101:
; .FSTART __lcd_read_nibble_G101
    sbi   __lcd_port,__lcd_enable ;EN=1
	CALL __lcd_delay_G101
    in    r30,__lcd_pin           ;read
    cbi   __lcd_port,__lcd_enable ;EN=0
	CALL __lcd_delay_G101
    andi  r30,0xf0
	RET
; .FEND
_lcd_read_byte0_G101:
; .FSTART _lcd_read_byte0_G101
	CALL __lcd_delay_G101
	RCALL __lcd_read_nibble_G101
    mov   r26,r30
	RCALL __lcd_read_nibble_G101
    cbi   __lcd_port,__lcd_rd     ;RD=0
    swap  r30
    or    r30,r26
	RET
; .FEND
_lcd_gotoxy:
; .FSTART _lcd_gotoxy
	ST   -Y,R26
	CALL __lcd_ready
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-__base_y_G101)
	SBCI R31,HIGH(-__base_y_G101)
	LD   R30,Z
	LDD  R26,Y+1
	ADD  R26,R30
	CALL __lcd_write_data
	LDD  R5,Y+1
	LDD  R4,Y+0
	ADIW R28,2
	RET
; .FEND
_lcd_clear:
; .FSTART _lcd_clear
	CALL __lcd_ready
	LDI  R26,LOW(2)
	CALL __lcd_write_data
	CALL __lcd_ready
	LDI  R26,LOW(12)
	CALL __lcd_write_data
	CALL __lcd_ready
	LDI  R26,LOW(1)
	CALL __lcd_write_data
	LDI  R30,LOW(0)
	MOV  R4,R30
	MOV  R5,R30
	RET
; .FEND
_lcd_putchar:
; .FSTART _lcd_putchar
	ST   -Y,R26
    push r30
    push r31
    ld   r26,y
    set
    cpi  r26,10
    breq __lcd_putchar1
    clt
	CP   R5,R7
	BRLO _0x2020004
	__lcd_putchar1:
	INC  R4
	LDI  R30,LOW(0)
	ST   -Y,R30
	MOV  R26,R4
	RCALL _lcd_gotoxy
	brts __lcd_putchar0
_0x2020004:
	INC  R5
    rcall __lcd_ready
    sbi  __lcd_port,__lcd_rs ;RS=1
	LD   R26,Y
	CALL __lcd_write_data
__lcd_putchar0:
    pop  r31
    pop  r30
	JMP  _0x2080001
; .FEND
_lcd_putsf:
; .FSTART _lcd_putsf
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
_0x2020008:
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ADIW R30,1
	STD  Y+1,R30
	STD  Y+1+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x202000A
	MOV  R26,R17
	RCALL _lcd_putchar
	RJMP _0x2020008
_0x202000A:
	LDD  R17,Y+0
	ADIW R28,3
	RET
; .FEND
__long_delay_G101:
; .FSTART __long_delay_G101
    clr   r26
    clr   r27
__long_delay0:
    sbiw  r26,1         ;2 cycles
    brne  __long_delay0 ;2 cycles
	RET
; .FEND
__lcd_init_write_G101:
; .FSTART __lcd_init_write_G101
	ST   -Y,R26
    cbi  __lcd_port,__lcd_rd 	  ;RD=0
    in    r26,__lcd_direction
    ori   r26,0xf7                ;set as output
    out   __lcd_direction,r26
    in    r27,__lcd_port
    andi  r27,0xf
    ld    r26,y
	CALL __lcd_write_nibble_G101
    sbi   __lcd_port,__lcd_rd     ;RD=1
	RJMP _0x2080001
; .FEND
_lcd_init:
; .FSTART _lcd_init
	ST   -Y,R26
    cbi   __lcd_port,__lcd_enable ;EN=0
    cbi   __lcd_port,__lcd_rs     ;RS=0
	LDD  R7,Y+0
	LD   R30,Y
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G101,2
	LD   R30,Y
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G101,3
	CALL SUBOPT_0x4
	CALL SUBOPT_0x4
	CALL SUBOPT_0x4
	RCALL __long_delay_G101
	LDI  R26,LOW(32)
	RCALL __lcd_init_write_G101
	RCALL __long_delay_G101
	LDI  R26,LOW(40)
	CALL SUBOPT_0x5
	LDI  R26,LOW(4)
	CALL SUBOPT_0x5
	LDI  R26,LOW(133)
	CALL SUBOPT_0x5
    in    r26,__lcd_direction
    andi  r26,0xf                 ;set as input
    out   __lcd_direction,r26
    sbi   __lcd_port,__lcd_rd     ;RD=1
	CALL _lcd_read_byte0_G101
	CPI  R30,LOW(0x5)
	BREQ _0x202000B
	LDI  R30,LOW(0)
	RJMP _0x2080001
_0x202000B:
	CALL __lcd_ready
	LDI  R26,LOW(6)
	CALL __lcd_write_data
	CALL _lcd_clear
	LDI  R30,LOW(1)
_0x2080001:
	ADIW R28,1
	RET
; .FEND

	.CSEG

	.CSEG

	.DSEG
__base_y_G101:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 18 TIMES, CODE SIZE REDUCTION:48 WORDS
SUBOPT_0x0:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(1)
	JMP  _lcd_gotoxy

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x1:
	CALL _lcd_putsf
	__GETWRN 16,17,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 18 TIMES, CODE SIZE REDUCTION:337 WORDS
SUBOPT_0x2:
	MOVW R30,R16
	MOVW R26,R28
	ADIW R26,20
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	OUT  0x1B,R30
	MOVW R30,R16
	MOVW R26,R28
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	OUT  0x12,R30
	LDI  R26,LOW(100)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x3:
	LDI  R30,LOW(3)
	ST   -Y,R30
	LDI  R26,LOW(1)
	CALL _lcd_gotoxy
	__POINTW2FN _0x0,155
	JMP  _lcd_putsf

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x4:
	CALL __long_delay_G101
	LDI  R26,LOW(48)
	JMP  __lcd_init_write_G101

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x5:
	CALL __lcd_write_data
	JMP  __long_delay_G101


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x7D0
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

__INITLOCB:
__INITLOCW:
	ADD  R26,R28
	ADC  R27,R29
__INITLOC0:
	LPM  R0,Z+
	ST   X+,R0
	DEC  R24
	BRNE __INITLOC0
	RET

;END OF CODE MARKER
__END_OF_CODE:
