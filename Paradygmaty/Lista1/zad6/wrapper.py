
import ctypes as ct
# Compilation steps:
# 1) gcc -c clib.c // -shared produce a shared object which can be linked with other objects
# 2) make
# 3) python3 plik.py

class DiofanticSolution(ct.Structure):
    _fields_ = [
        ('x', ct.c_int),
        ('y', ct.c_int)
    ]

C_library = ct.CDLL("clib.so") # getting shared C object

calc_factorial = C_library.calc_factorial
calc_gcd = C_library.calc_gcd
gcd_extended = C_library.gcd_extended
solve_diofantic = C_library.solve_diofantic

calc_factorial.argtypes = [ct.c_int]
calc_gcd.argtypes = [ct.c_int, ct.c_int]
gcd_extended.argtypes = [ct.c_int, ct.c_int, ct.POINTER(ct.c_int), ct.POINTER(ct.c_int)]
solve_diofantic.argtypes = [ct.c_int, ct.c_int, ct.c_int]

calc_factorial.restype = ct.c_ulonglong
calc_gcd.restype = ct.c_int
gcd_extended.restype = ct.c_int
solve_diofantic.restype = ct.POINTER(DiofanticSolution)

def solve_diofantic_wrapper():
    print("Podaj wspolczynniki a, b, c równania diofantycznego")
    a = int(input())
    b = int(input())
    c = int(input())
    result_ptr = solve_diofantic(a, b, c)
    if bool(result_ptr) == False:
        return None
    else:
        result = result_ptr.contents
        print(f'Solution to equation {a}x + {b}y = {c} are x = {result.x} and y = {result.y}')

def calc_gcd_wrapper():
    print("Podaj 2 liczby w celu obliczenia ich nwd.")
    a = int(input())
    b = int(input())
    result = calc_gcd(a, b)
    print(f'GCD of {a} and {b} is {result}')

def calc_factorial_wrapper():
    print("Dla jakiego n program ma policzyć silnię?")
    n = int(input())
    result = calc_factorial(n)
    print(f'Factorial of {n} is {result}')

def main():
    calc_factorial_wrapper()
    # calc_gcd_wrapper()
    # solve_diofantic_wrapper()

main()
