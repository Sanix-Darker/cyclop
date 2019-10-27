// ------
// cyclop example, to test it, just add in FILE_TO_WATCH Array(in cyclop.sh) this command :
//
// ["./tests/test.c"]="gcc ./tests/test.c && ./a.out"
// So it will look like this : declare -A FILE_TO_WATCH=( ["./tests/test.c"]="gcc ./tests/test.c && ./a.out" )
// ------

#include <stdio.h>
int main()
{
   // printf() displays the string inside quotation
   printf("Hello, World on C !");
   return 0;
}