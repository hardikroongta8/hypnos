[org 0x7c00]

HELLO:
	db "Hello World!", 0

mov bx, HELLO
call print
call println

mov dx, 0x69AF
call printhex
call println

jmp $

%include "print.asm"
%include "printhex.asm"

times 510 - ($-$$) db 0
dw 0xaa55