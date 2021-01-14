;or yanko
MODEL small
STACK 100h
DATA SEGMENT
; --------------------------
; Your variables here
	arr db 81h,0a9h,0c3h,97h,0f1h
	len dw $-arr
; --------------------------
DATA ENDS
CODE SEGMENT
	ASSUME CS:CODE, DS:DATA
start:
	mov ax, DATA
	mov ds, ax
; --------------------------
; Your code here
	
	mov ax, offset arr
	push ax
	push len
	call changeToNumOfOnes
	
	mov cx, len 
	mov bx, offset arr
printloop:
	;chage to ascii code
	xor ax, ax
	mov al, [bx]
	push ax
	call numToASCIIChar
	;print
	mov ah, 2
	int 21h
	inc bx
	loop printloop
; --------------------------
	
exit:
	mov ax, 4c00h
	int 21h
	
	
	;func that gets num in hexa and put in dx his ASCII code
	numToASCIIChar proc 
		mov bp, sp
		mov ax, [bp+2]
		
		add ax, '0'
		cmp ax, ':'
		jb	notletter0
		add ax, 39
	notletter0:
		mov dx, ax
		
		ret 4
	numToASCIIChar ENDP
	
	;func that gets an array's adress and its size and changes its values ​​to the number of instances it has
	changeToNumOfOnes PROC
		mov bp, sp
		mov cx, [bp+2]
		mov bx, [bp+4]
		
		
	lopChange:;check and change all the vars in array
		xor ax, ax
		mov al, [bx]
		
		xor dx, dx
		
	lop:;check one var in the array
		mov di, ax
		and di, 1
		shr ax, 1
		cmp di, 0
		je ifzero
		inc dx
	ifzero:
		cmp ax, 0
		jne lop
	;stop checking
	
	;change the array
		mov [bx], dl
		inc bx
		loop lopChange;stop checking and changing all vars in array
		
		ret 4
	changeToNumOfOnes ENDP
	
	;func that get a number and put in dx how many 1s there is in that number
	funcHowMany1 PROC
		
		mov bp, sp
		mov ax, [bp+2]
		
		
		ret
	funcHowMany1 ENDP
CODE ENDS
END start 