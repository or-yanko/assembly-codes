;or yanko
MODEL small
STACK 100h
DATA SEGMENT
; --------------------------
; Your variables here
; --------------------------
DATA ENDS
CODE SEGMENT
	ASSUME CS:CODE, DS:DATA
start:
	mov ax, DATA
	mov ds, ax
; --------------------------
; Your code here
	mov bl, 1h
	mov [ds:05h], bl
	mov [ds:06h], bl
	
	mov bx, 7h
	mov cx, 50
	
fibo:
	mov ah, [bx-1]
	mov al, [bx-2]
	add al, ah
	
	cmp al,50
	ja finish
	
	mov [bx], al
	inc bx
	loop fibo
	
finish:
; --------------------------
	
exit:
	mov ax, 4c00h
	int 21h
CODE ENDS
END start


