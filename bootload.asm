BITS 16
org 0x7c00
mov si, welcome_msg
call print_string
jmp $
print_string:
    mov ah, 0x0e
.loop:
    lodsb
    cmp al, 0
    je .done
    int 0x10
    jmp .loop
.done:
    ret
welcome_msg: db 'Hello, OS World!', 0
times 510 - ($ - $$) db 0
dw 0xaa55