;or yanko
MODEL small
STACK 100h
DATA SEGMENT
; --------------------------
; Your variables here
arr1 db 10h,8d,4d,5d
arr2 db 80h,0A2h,94h,0C8h
sum dw 0h
isum dw 0h
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

mov cx ,4d

arrSum:;loop
	;ex a

	;arr1[i]*arr2[i]=ax
	mov al, arr1[dx]
	mul arr2,[dx]

	add sum, ax;add to sum

	;ex b
	;arr1[i]*arr2[i]=ax
	imov al, arr1[dx]
	mul arr2,[dx]

	add isum, ax;add to sum
	inc dx
loop arrSum
;show sums in ax and bx
mov ax, sum
mov bx, isum
; --------------------------
	
exit:
	mov ax, 4c00h
	int 21h
CODE ENDS
END start


