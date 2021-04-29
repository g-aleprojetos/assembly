;
; Curso de Assembly
;
; 
; Aciona LED1 ligado em RB1 e apaga LED2 ligado em RB3 
; Aguarda 500 milissegundos 
; Aciona LED2 ligado em RB3 e apaga LED1 ligado em RB1
; Aguarda 500 milissegundos 
;
; Obs.:
;
; LEDs ligado no modo current sourcing:
;
; '0' - apaga
; '1' - acende
;
; Cálculo de ciclo de Máquina:
;
; Ciclo de máquina = 1/(Freq Cristal)/4 = 1us (micro segundo)
; 
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
				movlw		h'F5'				;W = B'1111 0101'
				movwf		TRISB				;TRISB = H'F5' configura RB1 e RB3 como saida)
				bank0							;Seleciona o banco 0 de memória
				movlw		H'F5'				;W = B'1111 0101'
				movwf		PORTB				;LEDs iniciam desligados

loop:											;Loop infinito

				bsf			led1				;liga LED1
				bcf			led2				;desliga LED2
				call		delay500ms			;chama sub rotina
				bcf			led1				;desliga LED1
				bsf			led2				;liga LED1
				call		delay500ms			;chama sub rotina

				goto		loop				;Volta para label loop

; --- Desenvolvimento das Sub-Rotinas ---

; --- Sub-Rotina de delay ---

delay500ms:

				movlw		D'200'				;Move o valor para W
				movwf		H'0C'				;Inicializa a variável tempo0

												;4 ciclos de máquina

aux1:
				movlw		D'250'				;Move o valoe para w
				movwf		H'0D'				;Inicializa a variavel tempo1

												;2 ciclos de máquina
aux2:
				nop								;Gastar 1 ciclo de máquina
				nop
				nop
				nop
				nop
				nop
				nop

				decfsz		H'0D'				;Decrementa tempo1 até que seja igual 0
				goto		aux2				;Vai para a lebal aux2

												;250 x 10 ciclos de máquina = 2500 ciclos de máquina

				decfsz		H'0C'				;decrementa yempo0 até que seja igual 0
				goto		aux1				;vai para a label aux1

												;3 ciclos de máquina
					
												;2500 x 200 = 500000

				return							;Retorna após a chamada de sub rotina

				end								;final		
