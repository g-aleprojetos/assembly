;
;Curso de Assembly para PIC 
;
;
;Banco de mem�ria de PIC 16F628A
;
;Clock: 4MHz		Ciclo de m�quina = 1us
;
;Data: junho de 2021
;
;


; --- Listagem do Processador Utlilizado ---
		list		p=16F628A						;Utilizado PIC 16F628A

; --- Arquivo Inclusos no Projetos
		#include <p16F628a.inc>						;inclui o arquivo do PIC 16F628A

; -- Fuse Bits ---
; - Cristal de 4MHz
; - Desabilitamos o Watch Dog Timer
; - Habilitamos o Power up Timer
; - Brown Out desabilitado
; - Sem programa��o em bauxa tens�o
; - Sem prote��o de c�digo
; - Sem prote��o da mem�ria
		__config _XT_OSC & _WDT_OFF & _PWRTE_ON & _BOREN_OFF & _LVP_OFF & _CP_OFF & _CPD_OFF & _MCLRE_ON

; --- Pagina��o de Mem�ria ---
		#define		bank0		bcf STATUS,RP0			;Cria um mnem�nico para selecionar o bank0 de mem�ria
		#define		bank1		bsf STATUS,RP0			;Cria um mnem�nico para selecionar o bank1 de mem�ria

; --- Sa�das ---
		#define		led1		PORTA,3					;LED1 onboard ligado ao pino RA3 (modo current sourcing) 0 - desliga 1 - liga
		#define		led2		PORTA,2					;LED2 onboard ligado ao pino RA2 (modo current sourcing) 0 - desliga 1 - liga

; --- Entrada ---
		#define		s1			PORTB,0					;Bot�o s1 ligado em RB0

; --- Vetor de Reset ---
		org			H'0000'								;Origem no endere�o 00h de mem�ria
		goto		inicio								;Desvia para a label In�cio

; --- Vetor de interrup��o ---
		org			H'0004'								;As interrup��es deste processador apontam para esse endere�o
		retfie											;Retorna da interrup��o

inicio:
	bank0												;Seleciona o banco 0 na mem�ria
	movlw			H'07'								;w = 7h
	movwf			CMCON								;CMCON	= 7h (apenas I/Os digitais)desabilita os comparadores internos
	bank1												;Seleciona o banco 1 na mem�ria
	
	movlw			H'13'								;w = 3h
	movwf			TRISA								;Configura sa�das para os leds onboard			
	movlw			H'FF'								;w = FFh
	movwf			TRISB								;Configura todo o PORTB como entrada digital
	bank0												;Seleciona o banco 0 na mem�ria

	bcf				led1								;LED1 inicia desligado	
	bcf				led2								;LED2 inicia desligado


loop:

	goto 			loop								;loop infinito


	end													;Final do programa