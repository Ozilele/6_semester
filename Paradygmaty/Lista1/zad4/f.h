#include <stdio.h>

struct DiofanticSolution {
    int X;
    int Y;
};

extern void adainit(void);
extern void adafinal(void);
extern int calcFactorial(int n);
extern int calcGcd(int a, int b);
extern int extendedGcd(int a, int b, int *x, int *y);
extern struct DiofanticSolution* solveDiofantic(int a, int b, int c);
