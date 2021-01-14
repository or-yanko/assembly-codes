;or yanko
MODEL small
STACK 100h
DATA SEGMENT
; --------------------------
; Your variables here
; --------------------------
	num dw 0ffffh
DATA ENDS
CODE SEGMENT
	ASSUME CS:CODE, DS:DATA
start:
	mov ax, DATA
	mov ds, ax
; --------------------------
; Your code here
; --------------------------
	mov ax, num
	mov bx, 10
	xor cx, cx
	
sum:
	xor dx, dx
	div bx
	add cx, dx
	cmp ax, 0
	
	jnz sum
	
exit:
	mov ax, 4c00h
	int 21h
CODE ENDS
END start
