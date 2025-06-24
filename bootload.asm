BITS 16
org 0x7c00

; --- Main code ---
; The print call that was here has been removed.

; Attempt to load the kernel from disk
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

; --- Verification Code ---
; The print call that was here has been removed.
    mov ax, 0x2000
    mov es, ax
    mov al, [es:0]
    cmp al, 0
    je load_failed

; The print call that was here has been removed.
; Now we just jump directly to the kernel.
    jmp 0x2000:0x0000

; --- Failure Paths (These messages will still appear if something goes wrong) ---
disk_error:
    mov si, msg_error
    call print_string
    jmp $

load_failed:
    mov si, msg_failed
    call print_string
    jmp $

; --- Subroutines ---
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

; --- Data ---
; The old status messages have been removed to save space.
msg_error:    db 'BOOTLOADER: DISK READ ERROR!', 0
msg_failed:   db 'BOOTLOADER: VERIFY FAILED!', 0

; --- Boot Signature ---
times 510-($-$$) db 0
dw 0xaa55