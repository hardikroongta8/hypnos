#ifndef SCREEN_H
#define SCREEN_H

#define VGA_ADDRESS    0xb8000
#define MAX_ROWS       25
#define MAX_COLS       80
#define GREEN_ON_BLACK 0x02

#define VGA_CTRL_REGISTER 0x3d4
#define VGA_DATA_REGISTER 0x3d5

void kprint(char *msg);
void kprintln(char *msg);
void clear_screen();

#endif