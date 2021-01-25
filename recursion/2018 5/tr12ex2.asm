;or yanko
MODEL small
STACK 100h
DATA SEGMENT
; --------------------------
; Your variables here

	arr db 8 dup(0)
	len equ $-arr
	flag db 0
	enter_msg db 'enter 8 digits: $'
; --------------------------
DATA ENDS
CODE SEGMENT
	ASSUME CS:CODE, DS:DATA
start:
	mov ax, DATA
	mov ds, ax
; --------------------------
; Your code here

	;scaning
	mov cx, len
	mov bx, offset arr
scanloop:
	mov ah, 1
	int 21h
	mov ah, 0
	sub al, 48
	mov [bx], ax
	inc bx
	loop scanloop
	
	;sorting
	push len
	push offset arr
	call bublesort
	
	;new line
	mov ah, 02h
	mov dl, 13
    int 21h
    mov dl, 10
    int 21h
	;printing
	mov cx, len
	mov bx, offset arr
printloop:
	mov ah, 2
	mov dl, [bx]
	add dl, '0'
	int 21h
	mov dl, ' '
	int 21h
	inc bx
	loop printloop
; --------------------------
	
exit:
	mov ax, 4c00h
	int 21h
	
bublesort proc
	mov bp, sp

	
loop1:
	mov bx, [bp+2]
	mov cx, [bp+4]
	dec cx
	mov flag, 0
loop2:
	
	mov dl, [bx]
	cmp dl, [bx+1]
	jb dontswap
	je dontswap
	
	;swaping
	xchg dl, [bx+1] 
	mov [bx], dl
	mov flag, 1
	
dontswap:
	inc bx
	loop loop2
	
	inc bx
	cmp flag, 0
	jne loop1
	ret 4
bublesort endp

	
	
CODE ENDS
END start 