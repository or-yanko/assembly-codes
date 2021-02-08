;or yanko
MODEL small
STACK 100h
DATA SEGMENT
; --------------------------
; Your variables here
	
	node struc
		info db ?
		next dw ?
	node ends
		
	start1 node <'a',$+2>, <'b',$+2>,<'g',$+2>, <'l',0>
	start2 node <'c',$+2>, <'d',$+2>,<'f',$+2>,<'l',$+2>, <'z',0>
	list_1 dw start1
	list_2 dw start2
	head dw ?
	
; --------------------------
DATA ENDS
CODE SEGMENT
	ASSUME CS:CODE, DS:DATA
start:
	mov ax, DATA
	mov ds, ax
; --------------------------
; Your code here
	
	;merging the two lists
	push list_1
	push list_2
	push offset head
	call mergeLists
	
	;printing the list
	push head
	call printList
	
	
; --------------------------
	
exit:
	mov ax, 4c00h
	int 21h

;--------------------------------------------------------------------------------------------------------------------------------------------
;-------function that get the the adresses of the three listsand merge the 2 first lists into the third without allocating memory------------
mergeLists proc
	push bp
	mov bp, sp
	mov bx, [bp+4];head=bx
	mov si, [bp+6];list2=si
	mov di, [bp+8];list1=di
	
	
	;---check which head is bigger and make it the head of the mergedlist---
	mov dl, [di].info 	
	mov dh, [si].info 	
	cmp dh, dl
	jb head2IsSmaller
	
;if head1 is smaller
head1IsSmaller:	
	mov [bx], di
	mov bx, di
	mov di, [di].next
	jmp mergeingLoop
	
;if head2 is smaller
head2IsSmaller:	
	mov [bx], si
	mov bx, si
	mov si, [si].next
	

	;---start merging the rest of the list
mergeingLoop:
	;check if we in the end of one of the lists and if we are fill with the rest
	test di, di
	jz addRestOf2
	test si, si
	jz addRestOf1

	;if its mot the end of both lists
	mov dl, [di].info 	
	mov dh, [si].info 	
	cmp dl, dh			
	jb addIf1Bigger
	
	
	;if l2 is bigger
addIf2Bigger:
	mov [bx].next, si
	mov bx, [bx].next
	mov si, [si].next
	jmp mergeingLoop
	
	;if l1 is bigger
addIf1Bigger:
	mov [bx].next, di
	mov bx, [bx].next
	mov di, [di].next
	jmp mergeingLoop
	
	
	

;adding the rest of list1
addRestOf1:
	mov [bx].next, di
	jmp exitFromMerge
	
;adding the rest of list2	
addRestOf2:
	mov [bx].next, si
	jmp exitFromMerge

exitFromMerge:
	pop bp
	ret 6
mergeLists endp

;----------------------------------------------------------------------------------------------
;-------function that get the the adress of the bigining of list and print the list------------
printList proc
	push bp
	mov bp, sp
	mov bx, [bp+4]
printInfo:
	cmp word ptr[bx].next, 0
	jz printLatInfo
	mov dl, [bx].info
	mov ah, 2
	int 21h
	mov bx, [bx].next
	mov ah, 2
	mov dl, '-'
	int 21h
	mov dl, '>'
	int 21h
	jmp printInfo
	
printLatInfo:
	mov dl, [bx].info
	mov ah, 2
	int 21h
	
	pop bp
	ret 2
printList endp
	
CODE ENDS
END start 