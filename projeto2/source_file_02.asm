;
; Curso de Assembly
;
;
; Aciona um LED ligado em RB7, a partir de um bot�o ligado em RB0
; Obs.:
;
; LED ligado no modo current sourcing:
;
; '0' - apaga
; '1' - acende
;
; Bot�o ligado com resistor de pull-up:
;
; '0' - bot�o acionado
; '1' - bot�o liberado
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
	#define		bank0		bcf STATUS,RP0		;Cria um mnem�nico para o banco 0 de mem�ria
							;bsf - bit set file - seta o bit colocando em 1
	#define		bank1		bsf STATUS,RP0		;Cria um mnem�nico para o banco 1 de mem�ria

; --- Entradas ---
	#define		botao1		PORTB,RB0			;Bot�o 1 ligado em RB0


; --- Sa�das ---
	#define		led1		PORTB,RB7			;Led 1 ligado em RB7


; --- Vetor de RESET ---
				org			H'0000'				;Origem no endere�o 0000h de mem�ria
				goto		inicio				;Desvia do vetor de interrup��o

; --- Vetor de Interrup��o ---
				org			H'0004'				;Todas as interrup��es apontam para este endere�o
				retfie							;Retorna de interrup��o


; --- Programa Principal ---
inicio:
				bank1							;Seleciona o banco 1 de mem�ria
				movlw		H'FF'				;W = B'11111111'
				movwf		TRISA				;TRISA = H'FF' (todos os bits s�o entrada)
				movlw		h'7F'				;W = B'01111111'
				movwf		TRISB				;TRISB = H'7F' (apenas o RB7 como saida)
				bank0							;Seleciona o banco 0 de mem�ria
				movlw		H'FF'				;W = B'11111111'
				movwf		PORTB				;RB7 (configurando como sa�da)	inicia em HIGH

loop:
		
				btfsc		botao1				;Botao foi pressionado?
				goto		apaga_led1			;N�o, desvia para lebel apaga LED1
				bsf			led1				;Sim, liga led1
				goto		loop				;volta para label loop
			
apaga_led1:
				bcf			led1				;Apaga led1
				goto		loop				;Volta para label loop

				end								;final		
