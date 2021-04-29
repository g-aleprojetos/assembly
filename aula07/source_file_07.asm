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

				movlw		D'10'				;Move a constante D'10' no registrador W
				addlw		d'35'				;W = W + 35d, W = 10 + 35 = 45

				movlw		H'AC'				;Move a constante H'AC' para W
				movwf		regist1				;regist1 = H'AC'

				addwf		regist1,w			;w = regist1 + w

				movlw		D'35'				;Move a constante D'35' no registrador W
				sublw		D'10' 				;W = W - 10d, W = 35 - 10 = 35

				movlw		H'AC'				;Move a constante H'AC' para W
				movlw		regist2				;regist2 = H'AC'

				subwf		regist2,w			;w = regist2 - w
			

				goto		loop				;Volta para label loop


				end								;final	

; --- Instruções ---
; ----------------------------------------------
;
; ADDLW			k
;
; Operação: w = W + k
;
; ----------------------------------------------
;
; ADDWE			f,d
;
; Operação: d = W + f
;
; d = 0 (W)	ou d = 1 (f)
;
; -----------------------------------------------
;
; RLF			f,d
;
; Operação: d = f << 1 (rotaciona o registrador f um bit para esquerda 'multiplica')
;
; d = 0 (W) ou d = 1(f)
;
; -----------------------------------------------
;
; RRF			f,d
;
; Operação: d = f >> 1 (rotaciona o registrador f um bit para direita 'divide')
;
; d = 0 (W) ou d = 1 (f)
;
; ------------------------------------------------
;
;SUBLW			k
;
; Operação: W = k - W
;
; ------------------------------------------------
;
; SUBWF			f,d
;
; Operação: d = f - W
;
; d = 0 (W) ou d = 1 (f)
;
; ------------------------------------------------