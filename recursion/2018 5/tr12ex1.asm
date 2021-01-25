;or yanko
MODEL small
STACK 100h
DATA SEGMENT
; --------------------------
; Your variables here
	msg db 'Please enter number: $'
	ten db 10d
	three dw 3
	two dw 2
	arr dw 100 DUP(?)

; --------------------------
DATA ENDS
CODE SEGMENT
	ASSUME CS:CODE, DS:DATA
start:
	mov ax, DATA
	mov ds, ax
; --------------------------
; Your code here

	; printing msg
	mov dx, offset msg
	mov ah,9h
	int 21h 
	
	;scan first digit
	mov ah, 01h
	int 21h 
	mov ah, 0
	sub al, 48
	mul ten
	mov dl, al
	
	;scan second digit
	mov ah, 01h
	int 21h 
	mov ah, 0
	sub al, 48
	add dl, al
	
	;call to func
	push dx
	mov bx, offset arr

	
	;new line
	mov ah, 02h
	mov dl, 13
    int 21h
    mov dl, 10
    int 21h
	
	call calc

	
exit:
	mov ax, 4c00h
	int 21h
	
;func that fill the array and print as told in the instructions
calc proc
	push bp
	mov bp, sp
	mov ax, [bp+4]
	cmp ax, 1
	je one
	xor dx, dx
	test al, 1
	jnz notzugi
	
zugi:;if num zugi
	div two
	jmp recCall

notzugi:;if num not zugi
	mul three
	add ax, 1

recCall: 
	;call to the func
	push ax
	call calc
	;fill
	mov ax, [bp+4]
	mov [bx], ax
	add bx, 1
	jmp endd
	
one:
	mov cx ,1
	mov [bx], cx
	add bx, 1	
	
endd:
	push bx
	call printDecimalNum
	pop bx
	pop bp
	ret 2
endp calc

;func that print the number in ax
printDecimalNum PROC
    mov bx, 10
    xor cx, cx
hexToDecLoop:
    ; push digits to stack
    inc cx
    xor dx, dx
    div bx
    add dx, '0'
    push dx
    test ax, ax
    jnz hexToDecLoop
    mov ah, 2h
	
	;;;printing
printloop:
    ; print the digits after poping it from stack
    pop dx
    int 21h
    loop printloop
	; print space
    mov dl, ' '
    int 21h
    ret
	
printDecimalNum ENDP

CODE ENDS
END start 