import math

def calc_factorial(n):
    fact = 1
    if n < 0:
        print("Error: Factorial of a negative number does not exist")
    elif n == 0:
        return 1
    else:
        for i in range(1, n + 1, 1):
            fact = fact * i
    return fact

def calc_gcd(a, b):
    if a == 0:
        return b
    while b != 0:
        tmp = a
        a = b
        b = tmp % b
    return a

def gcd_extended(a, b):
    x0 = 1 
    y0 = 0
    x1 = 0
    y1 = 1
    while b != 0:
        q = math.floor(a / b)
        r = a % b
        a = b
        b = r
        temp = x1
        x1 = x0 - q * x1
        x0 = temp
        temp = y1
        y1 = y0 - q * y1
        y0 = temp
    x = x0
    y = y0
    return a, x, y

def solve_diofantic(a, b, c):
    if a == 0 and b == 0:
        if c == 0:
            return "Infinite solution exists", None
        else:
            return "No solution exists", None
    else:
        gcd, x, y = gcd_extended(a, b)
        if c % gcd != 0:
            return "No solution exists", None
        else:
            result_x = int(x * (c / gcd))
            result_y = int(y * (c / gcd))
            return "One solution exists", (result_x, result_y)


    
