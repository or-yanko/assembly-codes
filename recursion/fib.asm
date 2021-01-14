;or yanko
MODEL small
STACK 100h
DATA SEGMENT
; --------------------------
; Your variables here
	msg db 'please enter num between 3-9$'
	string db '000d$'
	string2 db ' fib[0]= $'
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
	call scanNum
	add string2[5], al
	push ax
	call fib
	
	push ax
	mov dx, offset string2
	mov ah, 9
	int 21h
	
	call printDec
; --------------------------
	
exit:
	mov ax, 4c00h
	int 21h
;func that get num and print hexa byte in decimal
printDec proc
	mov bp, sp
	mov ax, [bp+2]
	mov bx, offset string
	add bx, 2
	
	mov cx, 3
lop:
	xor dx, dx
	div divider
	add [bx],dl
	dec bx
	loop lop
	
	;printing
	mov dx, offset string
	mov ah, 9h
	int 21h
	
	ret 2
printDec endp

;help func for fibonachi
fibHelp proc
	mov bp, sp
	mov cx, [bp+2]
	
	add dl, dh
	xchg dl, dh
	
	cmp cx, 1
	je ifEnd
	
	dec cx
	push cx
	call fibHelp
	ret 2
ifEnd:
	xor ax,ax
	mov al, dh
	ret 2
fibHelp endp
;func get a number and from stuck and return in ax num in numbers place in fibonachi
fib proc
	mov bp, sp
	mov ax, [bp+2]
	cmp ax, 0
	je oneOrTwo
	cmp ax, 1
	je oneOrTwo
	
	dec	ax
	push ax
	mov dl, 1
	mov dh, 1
	call fibHelp
	
	ret 2
oneOrTwo:
	mov ax, 1
	ret 2
fib endp
;func that return in ax inputed char	
scanNum proc
	mov dx, offset msg
	mov ah, 9h
	int 21h
	mov ah, 7
	int 21h
	xor ah, ah
	sub al, '0'
	ret
scanNum endp
	
CODE ENDS
END start 