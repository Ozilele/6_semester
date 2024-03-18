#include <stdio.h>
#include "f.h"
// #include "../zad1/framework_loop.h"
#include "../zad1/framework_recursive.h"

unsigned long long calc_factorial(int n) {
    return calcFactorial(n);
}

int calc_gcd(int a, int b) {
    return calcGcd(a, b);
}

int extended_gcd(int a, int b, int *x, int *y) {
    return gcdExtended(a, b, x, y);
}

struct DiofanticSolution* solve_diofantic(int a, int b, int c) {
    return solveDiofantic(a, b, c);
}