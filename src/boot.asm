[org 0x7c00]

HELLO:
	db "Hello World!", 0

mov bx, HELLO
call print
call println

loop:
	jmp loop

%include "print.asm"

times 510 - ($-$$) db 0
dw 0xaa55