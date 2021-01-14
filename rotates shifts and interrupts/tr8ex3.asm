;or yanko
MODEL small
STACK 100h
DATA SEGMENT
; --------------------------
; Your variables here
	x dw 7
	n dw 6
	coefficient db 2,4,3,6,20,15
	result dw 0
; --------------------------
DATA ENDS
CODE SEGMENT
	ASSUME CS:CODE, DS:DATA
start:
	mov ax, DATA
	mov ds, ax
; --------------------------
; Your code here
	
	mov cx, n
	dec cx
	mov bx, offset coefficient
	mov dx, x
	
lop:
	mov dx, x
	xor ax, ax
	mov al, [bx]
	inc bx
	add ax, result
	mul dx
	mov result, ax
	loop lop
	
	xor ax, ax
	mov al, [bx]
	add result, ax
	
	xor dx, dx
	mov dx,result
	jmp exit
	
; --------------------------
	
exit:
	mov ax, 4c00h
	int 21h
CODE ENDS
END start 