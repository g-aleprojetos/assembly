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

		end												;Final do programa