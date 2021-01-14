;or yanko
MODEL small
STACK 100h
DATA SEGMENT
; --------------------------
; Your variables here
	msg db 'The polinom is to big to continue calculate, more than 16 bit$'
	resulrStr db '0000$'
	x dw 4
	n dw 5
	coefficient db 8,6,3,11,26
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
	cmp dx, 0
	jne printError
	mov result, ax
	mov si, result
	loop lop
	
	xor ax, ax
	mov al, [bx]
	add result, ax
	
	xor dx, dx
	mov dx,result
	jmp printResult
	
	
	
printError:
	
	mov dx,offset msg
	mov ah, 9h
	int 21h
	jmp exit
	
printResult:
	;print result
	mov cx, result
	shr cx, 12
	add cx, '0'
	cmp cx, ':'
	jb	notletter0
	add cx, 39
notletter0:
	mov resulrStr[0], cl
	
	mov cx, result
	shl cx, 4
	shr cx, 12
	add cx, '0'
	cmp cx, ':'
	jb	notletter1
	add cx, 39
notletter1:
	mov resulrStr[1], cl
	
	mov cx, result
	shl cx, 8
	shr cx, 12
	add cx, '0'
		cmp cx, ':'
	jb	notletter2
	add cx, 39
notletter2:
	mov resulrStr[2], cl
	
	mov cx, result
	shl cx, 12
	shr cx, 12
	add cx, '0'
	cmp cx, ':'
	jb	notletter3
	add cx, 39
notletter3:
	mov resulrStr[3], cl
	
	mov dx,offset resulrStr
	mov ah, 9h
	int 21h
	jmp exit


	
; --------------------------
	
exit:
	mov ax, 4c00h
	int 21h
CODE ENDS
END start 