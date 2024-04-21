#include <iostream>
#include "GaloisField.hpp"
using namespace std;

using GF1234577 = GaloisField<1234577>;
using GF = GF1234577;

template<typename T>
bool checkEQ(const T& a, const T& b) {
    if(a != b) {
        // cerr << "CheckEQ: " << a.getCharacteristics() << " != " << b.getCharacteristics() << endl;
        return false;
    }
    return true;
}

bool testArithmeticOperators() {
    GF a(1);
    GF b(2);
    GF c(3);
    return checkEQ(a + b, c) && checkEQ(b - a, a) && checkEQ(a * b, b) && checkEQ(b * c, GF(6)) && checkEQ(c / b, GF(617290)) && checkEQ(-a, GF(1234576)) && checkEQ(GF(321) * GF(15676), GF(93688)) ? EXIT_SUCCESS : EXIT_FAILURE;
}

bool testComparisonOperators() {
    GF a(20);
    GF b(20);
    GF c(25);
    GF d(15);
    GF e(21);
    return a == b && a != c && d <= c && e >= d && e < c && b > d ? EXIT_SUCCESS : EXIT_FAILURE;
}

bool testAssignmentOperators() {
    GF a(10);
    GF b(2);
    GF c(3);
    GF d(4);
    GF e(5);
    a += b;
    d -= b;
    b *= c;
    c /= d;
    e = b;
    return checkEQ(a, GF(12)) && checkEQ(d, GF(2)) && checkEQ(b, GF(6)) && checkEQ(c, GF(617290)) && checkEQ(e, GF(6)) ? EXIT_SUCCESS : EXIT_FAILURE;
}

int main(int argc, char **argv) {
    bool cond = !testArithmeticOperators() && !testComparisonOperators() && !testAssignmentOperators();
    if(cond == 1) {
        cout << "All the tests passed" << endl;
    } else {
        cout << "Error: Not all tests passed" << endl;
    }
}