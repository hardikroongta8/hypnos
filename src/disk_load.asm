disk_load: ; set the starting sector to read in the cl register
	pusha

	push dx    ; push the values in the stack so the register can be used
	mov al, dh ; number of sectors to read (comes from params)

	mov ah, 0x02 ; set ah = 0x02 for calling the interrupt
	mov ch, 0x00 ; cylinder number
	mov dh, 0x00 ; head number

	int 0x13 ; interrupt for mass storage access (disk, floppy, CDROM)
	jc disk_error
	
	pop dx
	cmp al, dh ; al contains the number of sectors read
	jne sector_error
	
	popa
	ret

disk_error:
	mov bx, DISK_ERROR
	call print
	call println
	mov dh, ah ; return status 
	call printhex
	jmp disk_loop

sector_error:
	mov bx, SECTOR_ERROR
	call print
	call println

disk_loop:
	jmp $


DISK_ERROR: db "disk read error", 0
SECTOR_ERROR: db "sector read error", 0