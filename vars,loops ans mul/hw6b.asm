;or yanko
MODEL small
STACK 100h
DATA SEGMENT
; --------------------------
; Your variables here
arr1 db 17 dup(?)
arr2 dw 7999h, 8000h, 8001h, 8002h
x dw 0h
; --------------------------
DATA ENDS
CODE SEGMENT
	ASSUME CS:CODE, DS:DATA
start:
	mov ax, DATA
	mov ds, ax
; --------------------------
; Your code here
mov ax ,0
mov bx ,0
mov dx ,0
mov cx ,17


loop1:;loop ex a
	mov bx, OFFSET Arr1
	add bx,x
	inc x
	mov ax,x
	mov [bx],ax
loop loop1

mov cx,4
mov x,0
loop2:; loop ex b
	mov bx, OFFSET Arr2
	add bx,x
	mov ax,[bx]
	neg ax
	mov [bx],ax
	inc x
loop loop2


; --------------------------
	
exit:
	mov ax, 4c00h
	int 21h
CODE ENDS
END start


