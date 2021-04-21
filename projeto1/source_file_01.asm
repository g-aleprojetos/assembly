;
; Curso de Assembly
;
; MCU: PIC16F84A   Clock:4MHz
;
; Autor: Alexandre   Data: abril 2021
;

	list p=16f84A							;microcontrolador utilizado PIC16F84A

; --- Arquivo inclu�dos no projeto ---
	#include<pic16f84a.inc>					;inclui o arquivo do PIC16F84A

; --- FUSE Bits ---

; Cristal oscilador externo 4MHZ, sem watchdog timer, com power up timer, sem prote��o do c�digo
	__config _XT_OSC & _WDT_OFF & _PWRTE_ON & _CP_OFF


; --- Pagina��o de mem�ria ---
						 ;bcf - bit clear file - limpa o bit colocando em 0
	#define     bank0     bcf STATUS,RP0     ;Cria um mnem�nico para o banco 0 de mem�ria
						 ;bsf - bit set file - seta o bit colocando em 1
	#define     bank1     bsf STATUS,RP0     ;Cria um mnem�nico para o banco 1 de mem�ria


