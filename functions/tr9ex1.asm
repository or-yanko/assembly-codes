;or yanko
MODEL small
STACK 100h
DATA SEGMENT
; --------------------------
; Your variables here
	a dw 12h
	b dw 0Adh
; --------------------------
DATA ENDS
CODE SEGMENT
	ASSUME CS:CODE, DS:DATA
start:
	mov ax, DATA
	mov ds, ax
; --------------------------
; Your code here
	mov ax, offset a
	push ax
	mov ax, offset b
	push ax
	call swapByRef


; --------------------------
	
exit:
	mov ax, 4c00h
	int 21h
	
	swapByRef PROC
		mov bp, sp
		mov di, [bp+2]
		mov bx, [bp+4]
		mov ax, [bx]
		mov cx, [di]
		
		mov [bx], cx
		mov [di], ax
		ret 4
	swapByRef ENDP
CODE ENDS
END start 