[org 0x7c00]

mov bp, 0x8000
mov sp, bp

mov bx, 0xf000 ; Buffer pointer for storing the data (used as [ES:0xf000])
mov cl, 0x02   ; starting sector number
mov dh, 3      ; Number of sectors to read

call disk_load

mov dx, [0xf000]
call printhex
call println

mov dx, [0xf000 + 512]
call printhex
call println

mov dx, [0xf000 + 1024]
call printhex

jmp $

%include "print.asm"
%include "printhex.asm"
%include "disk_load.asm"

times 510 - ($-$$) db 0
dw 0xaa55

times 256 dw 0xdada
times 256 dw 0xface
times 256 dw 0xbaba