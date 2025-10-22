BOOT_DIR     = boot
BOOT_ENTRY   = $(BOOT_DIR)/boot.asm
KERNEL_ENTRY = $(BOOT_DIR)/kernel_entry.asm

BIN_DIR      = bin
BOOT_BIN     = $(BIN_DIR)/boot.bin
KERNEL_BIN   = $(BIN_DIR)/kernel.bin
OS_IMAGE_BIN = $(BIN_DIR)/os-image.bin

C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS   = $(wildcard kernel/*h drivers/*.h)
OBJ       = $(C_SOURCES:.c=.o)

CC  = i386-elf-gcc
GDB = i386-elf-gdb
LD  = i386-elf-ld
CFLAGS = -g -ffreestanding -O2 -Wall -Wextra

INCLUDES = $(wildcard $(BOOT_DIR)/*.asm)

ASM       = nasm
ASM_FLAGS = -f bin -I $(BOOT_DIR)
QEMU      = qemu-system-i386

all: $(OS_IMAGE_BIN)

run: $(OS_IMAGE_BIN)
	$(QEMU) -drive format=raw,file=$<,if=floppy

$(OS_IMAGE_BIN): $(BOOT_BIN) $(KERNEL_BIN)
	cat $^ > $@

$(BIN_DIR): 
	mkdir -p $(BIN_DIR)

$(BOOT_BIN): $(BOOT_ENTRY) $(INCLUDES) | $(BIN_DIR)
	$(ASM) $(ASM_FLAGS) $< -o $@

$(KERNEL_BIN): $(BOOT_DIR)/kernel_entry.o $(OBJ)
	$(LD) -o $@ -Ttext 0x1000 $^ --oformat binary

%.o: %.c ${HEADERS}
	${CC} ${CFLAGS} -ffreestanding -c $< -o $@

%.o: %.asm
	$(ASM) $< -f elf -o $@

clean:
	rm -rf $(BIN_DIR)
	rm -f $(BOOT_DIR)/*.o $(OBJ)