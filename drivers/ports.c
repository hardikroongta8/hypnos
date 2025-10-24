unsigned char port_read_byte(unsigned short port) {
  unsigned char result;
  /**
   * Put 'port' in 'edx' register
   * Run the instruction
   * Put the output in the 'eax' register
   * Set 'result' to the value present in 'eax' register
   */
  __asm__ volatile("inb %1, %0" : "=a"(result) : "Nd"(port) : "memory");
  return result;
}

void port_write_byte(unsigned short port, unsigned char data) {
  /**
   * Put 'port' in 'edx' register
   * Put 'data' in 'eax' register
   * Run the instruction
   */
  __asm__ volatile("outb %1, %0" : : "Nd"(port), "a"(data) : "memory");
}

unsigned short port_read_word(unsigned short port) {
  unsigned short result;
  /**
   * Put 'port' in 'edx' register
   * Run the instruction
   * Put the output in the 'eax' register
   * Set 'result' to the value present in 'eax' register
   */
  __asm__ volatile("inw %1, %0" : "=a"(result) : "Nd"(port) : "memory");
  return result;
}

void port_write_word(unsigned short port, unsigned short data) {
  /**
   * Put 'port' in 'edx' register
   * Put 'data' in 'eax' register
   * Run the instruction
   */
  __asm__ volatile("outw %1, %0" : : "Nd"(port), "a"(data) : "memory");
}