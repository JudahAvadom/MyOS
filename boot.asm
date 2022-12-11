; boot.asm
;
; A simple bootloader that prints "Hello, World!" to the screen and then
; enters an infinite loop.
;

; Use the 16-bit real-mode segmentation model.
bits 16

; The bootloader begins execution at the label "start".
start:
    ; Set up the segment registers.
    mov ax, 0x07C0
    mov ds, ax
    mov es, ax

    ; Set up the stack pointer.
    mov ax, 0x0000
    mov ss, ax
    mov sp, 0x7C00

    ; Print "Hello, World!" to the screen.
    mov si, msg
    call print_string

    ; Enter an infinite loop.
    jmp $

; Prints the null-terminated string pointed to by the SI register to the
; screen.
print_string:
    lodsb
    or al, al
    jz .done
    mov ah, 0x0E
    int 0x10
    jmp print_string
.done:
    ret

; The message to print to the screen.
msg db "Hello, World!", 0

; The bootloader must be less than or equal to 512 bytes in size. The
; following padding is added to ensure that the bootloader is exactly
; 512 bytes in size.
times 510-($-$$) db 0

; The boot signature is used by the BIOS to identify the end of the
; bootloader.
dw 0xAA55
