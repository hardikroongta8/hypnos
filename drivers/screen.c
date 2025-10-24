#include "screen.h"
#include "ports.h"

void print_char(char, int, char);
void set_cursor_offset(int);

int get_cursor_offset();
int get_offset(int, int);
int get_row_from_offset(int);
int get_col_from_offset(int);

void kprint(char *s) {
  int i      = 0;
  int offset = get_cursor_offset();
  while (s[i] != '\0') {
    print_char(s[i], offset, GREEN_ON_BLACK);
    offset += 2;
    i++;
  }
  set_cursor_offset(offset);
}

void kprintln(char *s) {
  kprint(s);
  int curr_offset = get_cursor_offset();
  int row         = get_row_from_offset(curr_offset);
  set_cursor_offset(get_offset(0, row + 1));
}

void clear_screen() {
  for (int offset = 0; offset < get_offset(MAX_COLS, MAX_ROWS); offset += 2) {
    print_char(' ', offset, GREEN_ON_BLACK);
  }
  set_cursor_offset(0);
}

void print_char(char c, int offset, char attribute) {
  volatile char *vga = (volatile char *)VGA_ADDRESS;
  vga[offset]        = c;
  vga[offset + 1]    = attribute;
}

__attribute__((noinline)) int get_cursor_offset() {
  /* Request for higher byte of the cursor position (14) */
  port_write_byte(VGA_CTRL_REGISTER, 14);
  int pos = port_read_byte(VGA_DATA_REGISTER) << 8;

  /* Request for lower byte of the cursor position (15) */
  port_write_byte(VGA_CTRL_REGISTER, 15);

  return 2 * (pos + port_read_byte(VGA_DATA_REGISTER));
}

__attribute__((noinline)) void set_cursor_offset(int offset) {
  offset /= 2;
  port_write_byte(VGA_CTRL_REGISTER, 15);
  port_write_byte(VGA_DATA_REGISTER, offset & 0xff);

  port_write_byte(VGA_CTRL_REGISTER, 14);
  port_write_byte(VGA_DATA_REGISTER, (offset >> 8) & 0xff);
}

int get_offset(int col, int row) { return 2 * (MAX_COLS * row + col); }
int get_row_from_offset(int offset) { return offset / (2 * MAX_COLS); }
int get_col_from_offset(int offset) { return (offset / 2) % MAX_COLS; }
