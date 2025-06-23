BITS 16

; Set up segment registers
mov ax, cs
mov ds, ax
mov es, ax

; Set up the stack
mov ax, 0x0000
mov ss, ax
mov sp, 0xFFFF

; === KERNEL ENTRY POINT ===
start:
    call clear_screen
    mov si, welcome_msg_1
    call print_string
    call print_newline
    mov si, welcome_msg_2
    call print_string
    call print_newline
    call print_newline
    mov si, help_intro
    call print_string
    call print_newline
    call do_help
    call print_newline


; === MAIN OS LOOP ===
main_loop:
    mov si, prompt
    call print_string
    mov di, input_buffer
    call read_string
    call print_newline

    mov si, input_buffer
    mov di, cmd_help
    call string_compare
    je .run_help

    mov si, input_buffer
    mov di, cmd_info
    call string_compare
    je .run_info

    mov si, input_buffer
    mov di, cmd_clear
    call string_compare
    je .run_clear

    mov si, input_buffer
    mov di, cmd_about
    call string_compare
    je .run_about

    mov si, input_buffer
    mov di, cmd_date
    call string_compare
    je .run_date

    mov si, input_buffer
    mov di, cmd_time
    call string_compare
    je .run_time

    mov si, unknown_cmd_msg
    call print_string
    call print_newline
    jmp main_loop

; --- Command Execution ---
.run_help:
    call do_help
    jmp main_loop
.run_info:
    call do_info
    jmp main_loop
.run_clear:
    call clear_screen
    jmp main_loop
.run_about:
    call do_about
    jmp main_loop
.run_date:
    call do_date
    jmp main_loop
.run_time:
    call do_time
    jmp main_loop


; === COMMAND FUNCTIONS ===
do_help:
    mov si, help_msg
    call print_string
    ret

do_info:
    mov si, mem_msg
    call print_string
    int 0x12
    mov dx, ax
    call print_decimal
    mov si, kb_msg
    call print_string
    call print_newline
    ret

do_about:
    mov si, about_msg_1
    call print_string
    call print_newline
    mov si, about_msg_2
    call print_string
    call print_newline
    ret

do_date:
    mov si, date_prefix
    call print_string
    mov ah, 0x04
    int 0x1a
    mov al, ch
    call print_bcd
    mov al, cl
    call print_bcd
    mov si, separator
    call print_string
    mov al, dh
    call print_bcd
    mov si, separator
    call print_string
    mov al, dl
    call print_bcd
    call print_newline
    ret

do_time:
    mov si, time_prefix
    call print_string
    mov ah, 0x02
    int 0x1a
    mov al, ch
    call print_bcd
    mov si, separator_time
    call print_string
    mov al, cl
    call print_bcd
    mov si, separator_time
    call print_string
    mov al, dh
    call print_bcd
    call print_newline
    ret

clear_screen:
    mov ah, 0x06
    mov al, 0
    mov bh, 0x07
    mov cx, 0
    mov dh, 24
    mov dl, 79
    int 0x10
    mov ah, 0x02
    mov bh, 0
    mov dx, 0
    int 0x10
    ret

; === CORE SUBROUTINES ===
print_bcd:
    pusha
    mov ah, al
    shr ah, 4
    add ah, '0'
    mov al, ah
    mov ah, 0x0e
    int 0x10
    mov ah, al
    and al, 0x0f
    add al, '0'
    mov ah, 0x0e
    int 0x10
    popa
    ret

read_string:
    pusha
.loop:
    mov ah, 0
    int 0x16
    cmp al, 0x0d
    je .done
    cmp al, 0x08
    je .backspace
    mov ah, 0x0e
    int 0x10
    mov [di], al
    inc di
    jmp .loop
.backspace:
    cmp di, input_buffer
    je .loop
    dec di
    mov ah, 0x0e
    mov al, 0x08
    int 0x10
    mov al, ' '
    int 0x10
    mov al, 0x08
    int 0x10
    jmp .loop
.done:
    mov byte [di], 0
    popa
    ret

string_compare:
    pusha
.loop:
    mov al, [si]
    mov bl, [di]
    cmp al, bl
    jne .notequal
    cmp al, 0
    je .equal
    inc si
    inc di
    jmp .loop
.notequal:
    popa
    ret
.equal:
    popa
    cmp ax, ax
    ret

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

print_newline:
    pusha
    mov ah, 0x0e
    mov al, 0x0d
    int 0x10
    mov al, 0x0a
    int 0x10
    popa
    ret

print_decimal:
    pusha
    mov ax, dx
    mov bx, 10
    xor cx, cx
.div_loop:
    xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne .div_loop
.print_loop:
    pop dx
    add dl, '0'
    mov ah, 0x0e
    mov al, dl
    int 0x10
    loop .print_loop
    popa
    ret

; === DATA ===
welcome_msg_1: db 'Welcome to Chathura OS :)', 0
welcome_msg_2: db 'Developed for the Computer Architecture and Operating System course module.', 0
help_intro:    db 'Type one of the following commands and press Enter:', 0
prompt:        db 'ChathuraOS >> ', 0
unknown_cmd_msg: db 'Command not found.', 0
help_msg:      db '  about - Display information about this OS', 0x0d, 0x0a,
               db '  date  - Display the current system date', 0x0d, 0x0a,
               db '  time  - Display the current system time', 0x0d, 0x0a,
               db '  help  - Display this message', 0x0d, 0x0a,
               db '  info  - Display system hardware information', 0x0d, 0x0a,
               db '  clear - Clear the screen', 0

cmd_about:     db 'about', 0
cmd_help:      db 'help', 0
cmd_info:      db 'info', 0
cmd_clear:     db 'clear', 0
cmd_date:      db 'date', 0
cmd_time:      db 'time', 0

mem_msg:       db '  System Memory: ', 0
kb_msg:        db ' KB', 0
about_msg_1:   db '  ChathuraOS Version 1.0', 0
about_msg_2:   db '  Copyright (C) 2025 by Chathura.', 0

date_prefix:   db '  Current Date: ', 0
time_prefix:   db '  Current Time: ', 0
separator:     db '-', 0
separator_time: db ':', 0

input_buffer:  resb 64