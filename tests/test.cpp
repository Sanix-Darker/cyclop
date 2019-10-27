// ------
// cyclop example, to test it, just add in FILE_TO_WATCH Array(in cyclop.sh) this command :
//
// ./cyclop.sh f '(["./tests/test.cpp"]="g++ ./tests/test.cpp && ./a.out")'
// ------

#include<iostream>
using namespace std;

int main()
{
    // prints hello world
    cout<<"[+] Hello World on CPP";
    cout<<"\n[+] Cyclop is just AMAZING !!!\n";
    return 0;
}