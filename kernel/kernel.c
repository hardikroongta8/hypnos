#include "../drivers/ports.h"

int main() {
  /* Request for higher byte of the cursor position (14) */
  port_write_byte(0x3d4, 14);
  int pos = port_read_byte(0x3d5);
  pos = pos << 8;

  /* Request for lower byte of the cursor position (15) */
  port_write_byte(0x3d4, 15);
  pos += port_read_byte(0x3d5);

  /**
   * Every cell contains 2 bytes:
   * 1 character byte
   * 1 control byte storing the colour information
   */
  int offset_from_vga = 2 * pos;

  char *vga = (char *)0xb8000;
  vga[offset_from_vga] = 'X';
  vga[offset_from_vga + 1] = 0x02;
}