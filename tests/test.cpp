// ------
// Cyclope example, to test it, just add in FILE_TO_WATCH Array(in cyclope.sh) this command :
//
// ["./tests/test.cpp"]="g++ ./tests/test.cpp && ./a.out"
// So it will look like this : declare -A FILE_TO_WATCH=( ["./tests/test.cpp"]="g++ ./tests/test.c && ./a.out" )
// ------

#include<iostream>
using namespace std;

int main()
{
    // prints hello world
    cout<<"Hello World on CPP";
    return 0;
}