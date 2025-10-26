void memory_copy(char *source, char *dest, int nbytes) {
  for (int i = 0; i < nbytes; i++) {
    *(dest + i) = *(source + i);
  }
}

void int_to_ascii(int n, char str[]) {
  int sign = 1, i = 0;
  if (n < 0) {
    sign = -1;
    n    = -n;
  }

  do {
    str[i] = '0' + (n % 10);
    n /= 10;
    i++;
  } while (n);

  if (sign < 0) {
    str[i++] = '-';
  }
  str[i] = 0;

  int len = i;
  for (i = 0; i < len / 2; i++) {
    char c           = str[i];
    str[i]           = str[len - i - 1];
    str[len - i - 1] = c;
  }
}