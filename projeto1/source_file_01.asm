;
; Curso de Assembly
;
; MCU: PIC16F84A   Clock:4MHz
;
; Autor: Alexandre   Data: abril 2021
;

	list p=16f84A							;microcontrolador utilizado PIC16F84A

; --- Arquivo incluídos no projeto ---
	#include<pic16f84a.inc>					;inclui o arquivo do PIC16F84A

; --- FUSE Bits ---

; Cristal oscilador externo 4MHZ, sem watchdog timer, com power up timer, sem proteção do código
	__config _XT_OSC & _WDT_OFF & _PWRTE_ON & _CP_OFF


; --- Paginação de memória ---
							;bcf - bit clear file - limpa o bit colocando em 0
	#define		bank0		bcf STATUS,RP0		;Cria um mnemônico para o banco 0 de memória
							;bsf - bit set file - seta o bit colocando em 1
	#define		bank1		bsf STATUS,RP0		;Cria um mnemônico para o banco 1 de memória

; --- Entradas ---
	#define		botao1		PORTB,RB0			;Botão 1 ligado em RB0


; --- Saídas ---
	#define		led1		PORTB,RB7			;Led 1 ligado em RB7


; --- Vetor de RESET ---
				org			H'0000'				;Origem no endereço 0000h de memória
				goto		inicio				;Desvia do vetor de interrupção

; --- Vetor de Interrupção ---
				org			H'0004'				;Todas as interrupções apontam para este endereço
				retfie							;Retorna de interrupção


; --- Programa Principal ---
inicio:
				bank1							;Seleciona o banco 1 de memória
				movlw		h'7F'				;W= B'01111111'
				movwf		TRISB				;TRISB = H'7F' (apenas o RB7 como saida)
				bank0							;Seleciona o banco 0 de memória
				

				end			
