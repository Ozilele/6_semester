import math
import numpy as np

def leading_term(f):
    max_term = (0.0, 0)
    for i in range(0, len(f)):
        if f[i] != 0:
            max_term = (f[i], int(i))
    return max_term

def poly_multiply(f, g):
    new_len = leading_term(f)[1] + leading_term(g)[1] + 1
    new_list = [0.0] * new_len
    for i in range(0, len(f)):
        if f[i] != 0.0:
            for j in range(0, len(g)):
                if g[j] != 0.0:
                    new_list[i + j] += f[i] * g[j]
    return new_list

def poly_subtract(f, g):
    if len(g) > len(f):
        newf = [0.0] * len(g)
        for i in range(len(f)):
            newf[i] = f[i]
    else:
        newf = f
    result = [0.0] * len(newf)
    indexes = []
    for i in range(0, len(newf)):
        if newf[i] != 0.0:
            indexes.append(i)
            result[i] = newf[i] - g[i]
    # for rest g indexes apply
    for j in range(len(g)):
        if j not in indexes:
            result[j] = -1.0 * g[j]
    return result

# a(x) = q_0(x)b(x) + r(x) and deg(r(x)) < deg(b(x))
def div_remainder(f, g): 
    len_f = len(f)
    len_g = len(g)
    q = [0.0] * (len_f - len_g + 1)
    if len_g > 1:
        r = [0.0] * (len_g - 1)
    else: # g is a polynomial of degree 0 like 9/4 itp, so nwd of (f, g) is 1
        return (f, [0.0])
    p = f.copy()
    while leading_term(g)[1] <= leading_term(p)[1]:
        q_index = leading_term(p)[1] - leading_term(g)[1]
        q[q_index] = leading_term(p)[0] / leading_term(g)[0]
        temp = [0.0] * (len_f - len_g + 1)
        temp[q_index] = leading_term(p)[0] / leading_term(g)[0]
        p = poly_subtract(p, poly_multiply(temp, g)) 
    if len_g > 1:
        for i in range(len(r)):
            if p[i] != 0.0:
                r[i] = p[i]
    return (q, r)

def is_zero_polynomial(f):
    for i in range(len(f)):
        if f[i] != 0:
            return False
    return True

def deg(f):
    return leading_term(f)[1]

# Gaussian Euclidean Algorithm
def gcd(f, g):
    while is_zero_polynomial(g) is False and deg(g) <= deg(f):
        q, r = div_remainder(f, g)
        f, g = g, r
    if deg(f) == 0:
        return [1.0]
    return f

# least common multiple shared by x and y(Tw. Bezout)
def lcm(f, g):
    product = poly_multiply(f, g)
    return div_remainder(product, gcd(f, g))

def extended_gcd(f, g):
    if is_zero_polynomial(g) is True:
        A = np.array([1])
        B = np.array([0])
        # A = [1.0] * len(f)
        # B = [0.0] * len(f)
        return f, A, B
    q, r = div_remainder(f, g)
    gcd, A1, B1 = extended_gcd(g, r)
    A = B1
    B = poly_subtract(A1, poly_multiply(q, B1))
    return gcd, A, B