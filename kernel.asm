BITS 16

; Set up segment registers
mov ax, cs
mov ds, ax
mov es, ax

mov si, kernel_msg
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

kernel_msg: db '--- KERNEL HAS TAKEN CONTROL ---', 0