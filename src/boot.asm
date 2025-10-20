[org 0x7c00]

mov bp, 0x9000
mov sp, bp

mov bx, MSG_REAL_MODE
call print
call println

call switch_to_pm
jmp $

%include "switch_32bit.asm"
%include "gdt.asm"
%include "print_pm.asm"
%include "print.asm"

[bits 32]
BEGIN_PM:
	mov ebx, MSG_PROT_MODE
	call print_pm
	jmp $

MSG_REAL_MODE db "Started in 16-bit real mode", 0
MSG_PROT_MODE db "Loaded 32-bit protected mode", 0

times 510 - ($-$$) db 0
dw 0xaa55