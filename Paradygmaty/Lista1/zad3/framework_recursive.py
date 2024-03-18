import math 

def calc_factorial(n):
    if n == 0:
        return 1
    return n * calc_factorial(n - 1)

def calc_gcd(a, b):
    if b == 0:
        return a
    tmp = a
    a = b
    b = tmp % b
    return calc_gcd(a, b)

def gcd_extended(a, b):
    if b == 0:
        x = 1
        y = 0
        return a, x, y
    gcd, x1, y1 = gcd_extended(b, a % b)
    x = y1
    y = x1 - math.floor(a / b) * y1
    return gcd, x, y

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

