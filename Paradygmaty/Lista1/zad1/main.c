#include <stdio.h>
#include "framework_recursive.h"
// #include "framework_loop.h"

void testFactorial() {
    unsigned long long result;
    int n;
    printf("Dla jakiego n program ma policzyć silnię?\n");
    scanf("%d", &n);
    result = calcFactorial(n);
    printf("Factorial of %d is %lld\n", n, result);
}

void testGCD() {
    int a, b;
    printf("Podaj 2 liczby w celu obliczenia ich nwd.\n");
    scanf("%d", &a);
    scanf("%d", &b);
    int nwd = calcGcd(a, b);
    printf("NWD of %d and %d is %d\n", a, b, nwd);
}

void testDiofantic() {
    int a, b, c;
    printf("Podaj wspolczynniki a, b, c równania diofantycznego\n");
    scanf("%d", &a);
    scanf("%d", &b);
    scanf("%d", &c);
    struct DiofanticSolution* solution = solveDiofantic(a, b, c);
    if(solution != NULL) {
        printf("The solution to equation %dx + %dy = %d are x = %d and y = %d\n", a, b, c, solution->x, solution->y);
        free(solution);
    }
}

int main(int argc, char **argv) {
    testFactorial();
    // testGCD();
    // testDiofantic();
    return 0;
}