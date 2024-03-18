#include <stdio.h>
#include <stdlib.h>
#include "f.h"
// Compilation steps of wrapper(Needs to link object files with libraries and other object files which contains extern functions)
// /Users/bartiq/dev/IDE/GNAT/bin/gcc -c wrapper.c - generates object file(machine code but without extern functions)
// gnatmake -c frameworkloop.adb --GCC=/Users/bartiq/dev/IDE/GNAT/bin/gcc (produce a set of object files and ali files)
// gnatbind -n diofantic.ali frameworkloop.ali(-n specifies a foreign main program)
// gnatlink frameworkloop.ali wrapper.o -o program --GCC=/Users/bartiq/dev/IDE/GNAT/bin/gcc (Linking ada program, ada objects and C objects)
void testFactorial() {
    int n, result;
    printf("Dla jakiego n program ma policzyć silnię?\n");
    scanf("%d", &n);
    result = calcFactorial(n);
    printf("Factorial of %d is %d\n", n, result);
}

void testGcd() {
    int a, b;
    printf("Podaj 2 liczby w celu obliczenia ich nwd.\n");
    scanf("%d", &a);
    scanf("%d", &b);
    int gcd = calcGcd(a, b);
    printf("GCD of %d and %d is %d\n", a, b, gcd);
}

void testDiofantic() {
    int a, b, c;
    printf("Podaj wspolczynniki a, b, c równania diofantycznego\n");
    scanf("%d", &a);
    scanf("%d", &b);
    scanf("%d", &c);
    struct DiofanticSolution *result = solveDiofantic(a, b, c);
    if(result != NULL) {
        printf("The solution to equation %dx + %dy = %d are x = %d and y = %d\n", a, b, c, result->X, result->Y);    
        free(result);
    }
}

int main(int argc, char **argv) {
    adainit();
    int a, b, c, n, result;
    // testFactorial();
    // testGcd();
    testDiofantic();
    adafinal();
    return 0;
}