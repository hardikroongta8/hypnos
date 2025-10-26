#include "../drivers/ports.h"
#include "../drivers/screen.h"
#include "util.h"

int main() {
  clear_screen();

  for (int i = 0; i < 1000; i++) {
    kprint("Hello, ");
    char str[255];
    int_to_ascii(i, str);
    kprintln(str);
  }
}