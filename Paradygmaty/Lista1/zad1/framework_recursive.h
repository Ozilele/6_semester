#include <stdio.h>
#include <stdlib.h>

struct DiofanticSolution {
    int x;
    int y;
};

unsigned long long calcFactorial(int n) {
    if(n == 0) {
        return 1;
    }
    return n * calcFactorial(n - 1);
}

int calcGcd(int a, int b) {
    if(b == 0) {
        return a;
    }
    int tmp = a;
    a = b;
    b = tmp % b;
    return calcGcd(a, b);
}

// Function returns gcd(a, b) and ax + by = gcd(a, b)
int gcdExtended(int a, int b, int *x, int *y) {
    if(b == 0) {
        *x = 1;
        *y = 0;
        return a;
    }
    int x1, y1;
    int gcd = gcdExtended(b, a%b, &x1, &y1);
    *x = y1;
    *y = x1 - (a / b) * y1;
    return gcd;
}

struct DiofanticSolution* solveDiofantic(int a, int b, int c) {
    int x, y;
    struct DiofanticSolution* result = NULL;
    if(a == 0 && b == 0) {
        if(c == 0) {
            printf("Infinite solution exists\n");
        } else {
            printf("No solutions exist\n");
        }
    } else {
        int gcd = gcdExtended(a, b, &x, &y);
        if(c % gcd != 0) {
            printf("No solutions exist\n");
        } else {
            result = (struct DiofanticSolution*)malloc(sizeof(struct DiofanticSolution));
            result->x = x * (c / gcd); 
            result->y = y * (c / gcd);
        }
    }
    return result;
}

