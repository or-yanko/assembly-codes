;or yanko
MODEL small
STACK 100h
DATA SEGMENT
; --------------------------
; Your variables here
	num dw 0faa6h
	dec_digit_arr db 5 dup(0)
	string db 7 dup(0)
	divider dw 10
; --------------------------
DATA ENDS
CODE SEGMENT
	ASSUME CS:CODE, DS:DATA
start:
	mov ax, DATA
	mov ds, ax
; --------------------------
; Your code here
	xor ax, ax
	mov ax, num
	mov bx, offset dec_digit_arr
	add bx, 4


lop:
	xor dx, dx
	div divider
	cmp dx, 0
	je endd
	mov [bx], dl
	
	dec bx
	cmp dx, 0
	jne lop
	
endd:
	mov bx, offset dec_digit_arr
	xor ax, ax
	xor di,di
	
	mov cx, 5
lop2:
	
	mov al, [bx]
	add al, '0'
	inc bx
	mov string[di], al
	inc di
	loop lop2
	
	
	mov string[di], 'd'
	mov string[di+1], '$'
	
	;printing
	mov dx, offset string
	mov ah, 9h
	int 21h
	

	
	
	
; --------------------------
	
exit:
	mov ax, 4c00h
	int 21h
CODE ENDS
END start 