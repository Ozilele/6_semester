

def module_square(num):
    return num.real ** 2 + num.imag ** 2

def multiply(x, y):
    return complex(x.real * y.real - x.imag * y.imag, x.real * y.imag + y.real * x.imag)

def conjugate(x):
    new_x_imag = -1 * x.imag
    return complex(x.real, new_x_imag)

def norm(x):
    return x.real ** 2 + x.imag ** 2

# Gaussian Euclidean Algorithm
def gcd(a, b):
    while b != 0:
        q, r = div_remainder(a, b)
        a, b = b, r
    return a

# algorytm dzielenia z resztą w pierścieniu liczb Gaussa Z[i], iloraz i reszta nie sa unikalne, reszta moze byc ujemna, gaussian division algorithm
def div_remainder(x, y):
    if y.real == 0 and y.imag == 0:
        raise ValueError("Division by zero is not possible.")
    module_y = module_square(y)
    if module_y == 1:
        return x, complex(0, 0) # q, r
    numerator = multiply(x, conjugate(y))
    q = complex(round(numerator.real / module_y), round(numerator.imag / module_y)) # round to ensure that q is a gaussian integer
    r = x - (q * y)
    while norm(r) >= module_y:
        r.real -= y.real
        q.real += 1
    return q, r

# least common multiple shared by x and y(Tw. Bezout)
def lcm(x, y):
    return (x * y) / gcd(x, y)