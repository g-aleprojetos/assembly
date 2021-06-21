;
; Curso de Assembly para PIC Aula 010
;
; FUSE Bits do PIC16F628A
;
; Deseja-se configurar os FUSE Bits do PIC16F628A para as seguintes caracter�sticas:
;
; - Cristal oscilador externo 4MHz
; - Watch Dog Timer desabilitado
; - Power Up Timer habilitado
; - Master Clear habilitado
; - Brown Out desabilitado
; - Sem programa��o em baixa tens�o
; - Sem prote��o da mem�ria de dados
; - Sem prote��o de c�digo
;  
;
; MCU: PIC16F628A   Clock: 4MHz
;
;


	list	p=16f628a						;listagem do processador utilizado
	
	
	#include <p16f628a.inc>					;inclus�o do arquivo com os registradores do PIC16F628A
	
	
; --- FUSE Bits ---

	__config _XT_OSC & _WDT_OFF & _PWRTE_ON & _MCLRE_ON & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF