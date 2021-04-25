;
; Curso de Assembly
;
; 
; Aciona LED1 ligado em RB1, a partir de um bot�o ligado em RB0 
; Aciona LED2 ligado em RB3, a partir de um bot�o ligado em RB2
;
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
	#define		botao2		PORTB,RB2			;Bot�o 2 ligado em RB2	


; --- Sa�das ---
	#define		led1		PORTB,RB1			;Led 1 ligado em RB1
	#define		led2		PORTB,RB3			;Led 3 ligado em RB3


; --- Vetor de RESET ---
				org			H'0000'				;Origem no endere�o 0000h de mem�ria
				goto		inicio				;Desvia do vetor de interrup��o

; --- Vetor de Interrup��o ---
				org			H'0004'				;Todas as interrup��es apontam para este endere�o
				retfie							;Retorna de interrup��o


; --- Programa Principal ---
inicio:
				bank1							;Seleciona o banco 1 de mem�ria
				movlw		H'FF'				;W = B'1111 1111'
				movwf		TRISA				;TRISA = H'FF' (todos os bits s�o entrada)
				movlw		h'F5'				;W = B'1111 0101'
				movwf		TRISB				;TRISB = H'F5' configura RB1 e RB3 como saida)
				bank0							;Seleciona o banco 0 de mem�ria
				movlw		H'F5'				;W = B'1111 0101'
				movwf		PORTB				;LEDs iniciam desligados

loop:											;Loop infinito
				call		trata_but1			;Chama a sub-rotina para tratar bot�o 1
				call		trata_but2			;chama a sub-rotina para tratar bot�o 2

				goto		loop				;Volta para label loop

; --- Desenvolvimento das Sub-Rotinas ---

; --- Sub-Rotina para tratar bot�o 1 ---
trata_but1:
				btfsc		botao1				;Botao foi pressionado?
				goto		apaga_led1			;N�o, desvia para lebel apaga LED1
				bsf			led1				;Sim, liga led1
				return							;Retorna da sub-rotina
			
apaga_led1:
				bcf			led1				;Apaga led1
				return							;Retorna da sub-rotina

; --- Sub-Rotina para tratar bot�o 2 ---
trata_but2:										
				btfsc		botao2				;Botao foi pressionado?
				goto		apaga_led2			;N�o, desvia para lebel apaga LED2
				bsf			led2				;Sim, liga led2
				return							;Retorna da sub-rotina
			
apaga_led2:
				bcf			led2				;Apaga led2
				return							;Retorna da sub-rotina

				end								;final		
