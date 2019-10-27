// ------
// cyclop example, to test it, just add in FILE_TO_WATCH Array(in cyclop.sh) this command :
//
// ./cyclop.sh f '(["./tests/test.c"]="gcc ./tests/test.c && ./a.out")'
// ------

#include <stdio.h>
int main()
{
   // printf() displays the string inside quotation
   printf("[+] Hello, World on C !");
   printf("\n[+] Cyclop is just amazing right ?\n");
   return 0;
}