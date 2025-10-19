SRC_DIR = src
BIN_DIR = bin
SRC = $(SRC_DIR)/boot.asm
BIN = $(BIN_DIR)/boot.bin

INCLUDES = $(wildcard $(SRC_DIR)/*.asm)

ASM = nasm
ASM_FLAGS = -f bin -I $(SRC_DIR)

QEMU = qemu-system-x86_64

all: $(BIN)

$(BIN_DIR): 
	mkdir -p $(BIN_DIR)

$(BIN): $(SRC) $(INCLUDES) | $(BIN_DIR)
	$(ASM) $(ASM_FLAGS) $< -o $@

run: $(BIN)
	$(QEMU) -drive format=raw,file=$(BIN)

clean:
	rm -rf $(BIN_DIR)