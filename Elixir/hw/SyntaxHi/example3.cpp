#include <iostream>

/* This is a multi-line comment box
   It tests if our program handles big comments */
int main() {
    int count = 0;
    int hexValue = 0x2A; // Special number literal

    while (count < 10) {
        if (count % 2 == 0) {
            std::cout << "Even number!" << std::endl;
        }
        count += 1;
    }
    return 0;
}