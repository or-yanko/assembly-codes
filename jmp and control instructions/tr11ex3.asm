;or yanko
;100d*90d=5Ah*64h=2328h
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
;fill with vars
	
	mov cl,0AAh
	mov [ds:20h], cl
	inc cl
	mov [ds:21h], cl
	inc cl
	mov [ds:22h], cl
	inc cl
	mov [ds:23h], cl
	inc cl
	mov [ds:24h], cl
	inc cl
	mov [ds:25h], cl

;code
	mov bx, 26h
	mov cx, 6h
	
	
moveRight:
	mov ax, [bx-1]
	mov [bx], ax
	dec bx
	
	loop moveRight
	
	mov bx, 20h
	xor al, al
	mov [bx], al
; --------------------------
	
exit:
	mov ax, 4c00h
	int 21h
CODE ENDS
END start


