;or yanko
MODEL small
STACK 100h
DATA SEGMENT
; --------------------------
; Your variables here
	x dw 11h
	n dw 5
	coefficient db 99h,100,3,11,26
	result dw 0
	msg db 'The polinom is to big to continue calculate, more than 16 bit$'
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
	cmp dx, 0
	jne print
	mov result, ax
	mov si, result
	loop lop
	
	xor ax, ax
	mov al, [bx]
	add result, ax
	
	xor dx, dx
	mov dx,result
	jmp exit
	
print:
	
	mov dx,offset msg
	mov ah, 9h
	int 21h
; --------------------------
	
exit:
	mov ax, 4c00h
	int 21h
CODE ENDS
END start 