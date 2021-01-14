;or yanko
MODEL small
STACK 100h
DATA SEGMENT

    num dw 54321
    result dw ? 
    
DATA ENDS
CODE SEGMENT

ASSUME CS:CODE, DS:DATA

start:
    mov ax, DATA
    mov ds, ax
    
    push num
    call sum
    pop result ; (1)
    mov ax, 4c00h
    int 21h
    
sum:
    push bp
    mov bp, sp
    mov ax, [bp+4]
    mov word ptr [bp+4], 0
    mov bx, 10
    xor dx, dx
AG: 
    or ax, ax
    jz exit ; (2)
    div bx ; (3)
    add [bp+4], dx; (6)
    or ax, ax
    jz exit; (2)
    neg ax; (4)
    cwd
    idiv bx; (5)
    add [bp+4], dx; (6)
    neg ax
    cwd  
    jmp AG
    
exit:
    pop bp
    ret
    
CODE ENDS
END start