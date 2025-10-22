unsigned char port_read_byte(unsigned short port) {
  unsigned char result;
  /**
   * Put 'port' in 'edx' register
   * Run the instruction
   * Put the output in the 'eax' register
   * Set 'result' to the value present in 'eax' register
   */
  __asm__("in %%dx, %%al" : "=a"(result) : "d"(port));
  return result;
}

void port_write_byte(unsigned short port, unsigned char data) {
  /**
   * Put 'port' in 'edx' register
   * Put 'data' in 'eax' register
   * Run the instruction
   */
  __asm__("out %%al, %%dx" : : "d"(port), "a"(data));
}

unsigned short port_read_word(unsigned short port) {
  unsigned short result;
  /**
   * Put 'port' in 'edx' register
   * Run the instruction
   * Put the output in the 'eax' register
   * Set 'result' to the value present in 'eax' register
   */
  __asm__("in %%dx, %%ax" : "=a"(result) : "d"(port));
  return result;
}

void port_write_word(unsigned short port, unsigned short data) {
  /**
   * Put 'port' in 'edx' register
   * Put 'data' in 'eax' register
   * Run the instruction
   */
  __asm__("out %%ax, %%dx" : : "d"(port), "a"(data));
}