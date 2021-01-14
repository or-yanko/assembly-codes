;or yanko
MODEL small
STACK 100h
DATA SEGMENT
; --------------------------
; Your variables here
emp1 db 01000001b
emp2 db 00001100b
; --------------------------
DATA ENDS
CODE SEGMENT
	ASSUME CS:CODE, DS:DATA
start:
	mov ax, DATA
	mov ds, ax
; --------------------------
; Your code here
	mov ah, emp1
	mov al, emp2
	or ah, al
	and ah, 01001101b
	cmp ah,01001101b
	jne notequal
	mov bl,1
	jmp fin
notequal:
	mov bl,0
fin:
; --------------------------
	
exit:
	mov ax, 4c00h
	int 21h
CODE ENDS
END start


