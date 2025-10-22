gdt_start: ; null entry (8 bytes)
	dd 0x0
	dd 0x0

gdt_code: ; entry #1 (8 bytes)
	; segment limit = 0x000fffff
	; segment base  = 0x00000000
	; Flags       (0xC): G = 1, DB = 1, L = 0 (Flag = 0xC)
	; Access Byte (0x9A): P = 1, DPL = 00, S = 1, E = 1, DC = 0, RW = 1, A = 0
	dw 0xffff    ; segment limit (bits 0-15)
	dw 0x0			 ; segment base (bits 0-15)
	db 0x0       ; segment base (bits 16-23)
	db 10011010b ; access byte (bits 0-7)
	db 11001111b ; flags (bits 0-3) + segment limit (bits 16-19)
	db 0x0       ; segment base (bits 24-31)

gdt_data: ; entry #2 (8 bytes)
	; segment limit = 0x000fffff
	; segment base  = 0x00000000
	; Flags       (0xC): G = 1, DB = 1, L = 0
	; Access Byte (0x92): P = 1, DPL = 00, S = 1, E = 0, DC = 0, RW = 1, A = 0
	dw 0xffff    ; segment limit (bits 0-15)
	dw 0x0			 ; segment base (bits 0-15)
	db 0x0       ; segment base (bits 16-23)
	db 10010010b ; access byte (bits 0-7)
	db 11001111b ; flags (bits 0-3) + segment limit (bits 16-19)
	db 0x0       ; segment base (bits 24-31)

gdt_end:

gdt_descriptor:
	dw gdt_end - gdt_start - 1 ; size - 1
	dd gdt_start               ; start address

; Constants
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start