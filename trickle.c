/* trickle.c is like cat but slow byte-by-byte copy */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char **argv)
{
  int wait = 10000; /* 10000 micro seconds = 10 ms */
  int size = 1; /* 1 byte per flush */
  int k = 0;
  if (argc > 1)
  {
    wait = atoi(argv[1]);
    if (argc > 2)
      size = atoi(argv[2]);
  }
  while (1)
  {
    int c = getchar();
    if (c == EOF)
      break;
    putchar(c);
    if (k++ % size == 0)
    {
      fflush(stdout);
      usleep(wait);
    }
  }
}
