#include "../drivers/ports.h"
#include "../drivers/screen.h"

int main() {
  clear_screen();
  kprintln("Hello World!");
}