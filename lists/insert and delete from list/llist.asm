;or yanko

MODEL small
head = 1
DATA SEGMENT
	S STRUC
		num 	db 0
		next  	dw 0
	S ENDS
	ORG 5
	S1 S <5,S2>
	ORG 10h
	S2 S <3,S3>
	ORG 20h
	S3 S <4,S4>
	ORG 30h
	S4 S <2>
	list dw S1
	size_s = (size s)
	new1 S <0AAh,>
	new2 S <0BBh,>
	new3 S <0CCh,>
	n_node_place dw ?

	msg3 db 10,13,'There is no such index in the list, insert tail',10,13,'$'

DATA ENDS
SSEG SEGMENT STACK
	db 100h DUP (?)
SSEG ENDS

; --------------------------
; Your variables here
; --------------------------
CODE SEGMENT
	ASSUME CS:CODE, DS:DATA, SS:SSEG
start:
	mov ax, data
	mov ds, ax
; --------------------------
; Your code here
; --------------------------

; --------insert at head--------	
	push list
	mov n_node_place, 1
	push offset new1
	push n_node_place

	call insert_node
	pop list
; --------insert at mid--------	
	push list
	mov n_node_place, 3
	push offset new2
	push n_node_place

	call insert_node
	pop list
; --------insert at tail--------		
	push list
	mov n_node_place, 10
	push offset new3
	push n_node_place

	call insert_node
	pop list
	
exit:
	mov ax, 4c00h
	int 21h

insert_node proc
	push bp
	mov bp,sp
	
	mov bx, [bp+8]	; bx points to list	 
	mov di, [bp+6]	; offset of the new node 
	mov dx, [bp+4]	; dx the place to insert the new node
	xor cx, cx		; will count the place to insert
	inc cx
	cmp dx, word ptr head
	jne scan_mid
insert_head:
	mov [di].next, bx
	mov [bp+8], di
	jmp finish	
scan_mid:	
;-------------complete--------------
	dec dx 
	here:
	inc cx
	cmp [bx].next,0
	je insert_tail 
	mov bx, [bx].next
	cmp dx, cx
	je insert_mid
	jmp here
;-----------------------------------

	 
	
insert_tail: 
	mov dx, offset msg3
	mov ah, 9
	int 21h
	
insert_mid:
;-------------complete--------------
	mov si,[bx].next
	mov [bx].next,di 
	mov [di].next, si
;-----------------------------------

finish:
	pop bp
	ret 4
	
	
insert_node endp
CODE ENDS
END start