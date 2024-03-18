#include <stdlib.h>

struct DiofanticSolution {
    int x;
    int y;
};

unsigned long long calcFactorial(int n) {
    unsigned long long fact = 1;
    if(n < 0) {
        printf("Error: Factorial of a negative number does not exist");
    } else if(n == 0) {
        return 1;
    } else {
        for(int i = 1; i <= n; i++) {
            fact *= i;
        }
    }
    return fact;
}

int calcGcd(int a, int b) {
    if(a == 0) {
        return b;
    }
    while(b != 0) {
        int tmp = a;
        a = b;
        b = tmp % b;
    }
    return a;
}

int gcdExtended(int a, int b, int *x, int *y) {
    int x0 = 1, y0 = 0, x1 = 0, y1 = 1, temp;
    while(b != 0) {
        int q = a / b;
        int r = a % b;
        a = b;
        b = r;
        temp = x1;
        x1 = x0 - q * x1;
        x0 = temp;
        temp = y1;
        y1 = y0 - q * y1;
        y0 = temp;
    }
    *x = x0;
    *y = y0;
    return a;
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
            return result;
        }
    }
    return NULL;
}

