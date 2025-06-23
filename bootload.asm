BITS 16
org 0x7c00

; Main code
mov si, msg_starting
call print_string

; Load kernel
mov ax, 0x2000
mov es, ax
mov bx, 0
mov ah, 2
mov al, 10
mov ch, 0
mov cl, 2
mov dh, 0
mov dl, 0x00
int 0x13
jc disk_error

; Verify load
mov si, msg_verify
call print_string
mov ax, 0x2000
mov es, ax
mov al, [es:0]
cmp al, 0
je load_failed

; Jump to kernel
mov si, msg_success
call print_string
jmp 0x2000:0x0000

disk_error:
    mov si, msg_error
    call print_string
    jmp $
load_failed:
    mov si, msg_failed
    call print_string
    jmp $

print_string:
    mov ah, 0x0E
.loop:
    lodsb
    cmp al, 0
    je .done
    int 0x10
    jmp .loop
.done:
    ret

; Data
msg_starting: db 'Bootloader: Attempting to load kernel...', 0x0d, 0x0a, 0
msg_verify:   db 'Bootloader: Verifying load...', 0x0d, 0x0a, 0
msg_success:  db 'Bootloader: Kernel found! Jumping...', 0x0d, 0x0a, 0
msg_error:    db 'BOOTLOADER: DISK READ ERROR!', 0
msg_failed:   db 'BOOTLOADER: VERIFY FAILED!', 0

; Boot Signature
times 510-($-$$) db 0
dw 0xaa55