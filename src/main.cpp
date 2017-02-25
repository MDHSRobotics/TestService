#include <iostream>
#include <unistd.h>

using namespace std;

int main() {
    unsigned int microseconds = 1000*800;
    cout << "Ready...set...GO!" << endl;
    cout << "------------------" << endl;
    while(true){
        cout << "You're too slow!" << endl;
        usleep(microseconds);
        cout << "Come on! Step it up!" << endl;
        usleep(microseconds);
    }
    return 0;
    
}