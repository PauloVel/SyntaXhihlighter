#include <iostream>

// This is a simple math function to find factorials
int calculateFactorial(int n) {
    if (n == 0) {
        return 1;
    } else {
        return n * calculateFactorial(n - 1);
    }
}

int main() {
    int result = calculateFactorial(5);
    std::cout << "The answer is: " << result << std::endl;
    return 0;
}