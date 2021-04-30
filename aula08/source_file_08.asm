;
; Curso de Assembly
;
; Instruções de Desvio Condicional 
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
	#define		botao2		PORTB,RB2			;Botão 2 ligado em RB2	


; --- Saídas ---
	#define		led1		PORTB,RB1			;Led 1 ligado em RB1
	#define		led2		PORTB,RB3			;Led 3 ligado em RB3

; ---Registradores de uso geral ---
	cblock					H'0C'				;inicio da memória do usuário

				regist1							;registrador auxiliar
				regist2							;registrador auxiliar

	endc										;Final da memória do usuário


; --- Vetor de RESET ---
				org			H'0000'				;Origem no endereço 0000h de memória
				goto		inicio				;Desvia do vetor de interrupção

; --- Vetor de Interrupção ---
				org			H'0004'				;Todas as interrupções apontam para este endereço
				retfie							;Retorna de interrupção


; --- Programa Principal ---
inicio:
				bank1							;Seleciona o banco 1 de memória
				movlw		H'FF'				;W = B'1111 1111'
				movwf		TRISA				;TRISA = H'FF' (todos os bits são entrada)
				movlw		h'FF'				;W = B'1111 1111'
				movwf		TRISB				;TRISB = H'FF' (todos os bits são entrada)
				bank0							;Seleciona o banco 0 de memória (padrão)
				clrf		regist1
				clrf		regist2

loop:											;Loop infinito

				movlw		B'00000000'			;W = 10
				movwf		regist2				;regist2 = 10
				
aux:
				

				btfsc		regist2,2			;Bit 2 do regist2 igual a zero?
				goto		aux					;Não. Desvia para aux
				goto		loop				;Sim. Desvia para loop
			

				goto		loop				;Volta para label loop


				end								;final	

				

;     INSTRUÇÕES:
; ----------------------------------
;
; DECFSZ	f,d
;
; Decrementa f (d = f - 1) e desvia* se f = 0
;
; d = 0 (W) ou d = 1 (f)
;
; ----------------------------------
;
; INCFSZ	f,d
;
; Incrementa f (d = f + 1) e desvia* se f = 0
;
; d = 0 (W) ou d = 1 (f)
;
; ----------------------------------
;
; BTFSC		f,b
;
; Testa bit do registrador f, desvia* se igual a zero
;
;  
;
; ----------------------------------
;
; BTFSS		f,b
;
; Testa bit do registrador f, desvia* se igual a um
;
;  
;
; ----------------------------------
;
;
;
; * O mesmo que saltar a próxima linha
;
; ------------------------------------------------