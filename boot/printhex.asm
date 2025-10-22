[bits 16]
printhex:
	pusha
	mov cx, 0

printhex_loop:
	cmp cx, 4
	je end

	mov ax, dx
	and ax, 0x000f
	add ax, 0x30
	cmp ax, 0x39
	jle putchar
	add ax, 0x07

putchar:
	mov bx, HEXOUT+5
	sub bx, cx
	mov [bx], al
	shr dx, 4

	add cx, 1
	jmp printhex_loop


end:
	mov bx, HEXOUT
	call print
	popa
	ret


HEXOUT:
	db '0x0000', 0