;or yanko
MODEL small
STACK 100h
DATA SEGMENT
; --------------------------
; Your variables here
var1 db 100
var2 db 90
sum dw 0
; --------------------------
DATA ENDS
CODE SEGMENT
	ASSUME CS:CODE, DS:DATA
start:
	mov ax, DATA
	mov ds, ax
; --------------------------
; Your code here
	mov ax, 0
	mov cl, var1
	
power:
	
	add al, var2
	adc ah, 0
	loop power
	
	mov sum, ax
; --------------------------
	
exit:
	mov ax, 4c00h
	int 21h
CODE ENDS
END start


