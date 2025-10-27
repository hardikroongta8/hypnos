#include "../cpu/types.h"

uint8 inb(uint16 port) {
  unsigned char result;
  __asm__ volatile("inb %1, %0" : "=a"(result) : "Nd"(port) : "memory");
  return result;
}

void outb(uint16 port, uint8 data) {
  __asm__ volatile("outb %1, %0" : : "Nd"(port), "a"(data) : "memory");
}

uint16 inw(uint16 port) {
  unsigned short result;
  __asm__ volatile("inw %1, %0" : "=a"(result) : "Nd"(port) : "memory");
  return result;
}

void outw(uint16 port, uint16 data) {
  __asm__ volatile("outw %1, %0" : : "Nd"(port), "a"(data) : "memory");
}