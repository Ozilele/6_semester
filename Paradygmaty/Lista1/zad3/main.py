import framework_loop as floop
import framework_recursive as frecursive

def test_factorial():
    print("Dla jakiego n program ma policzyć silnię?")
    n = int(input())
    # result = floop.calc_factorial(n)
    result = frecursive.calc_factorial(n)
    print(f'Factorial of {n} is {result}')

def test_gcd():
    print("Podaj 2 liczby w celu obliczenia ich nwd.")
    a = int(input())
    b = int(input())
    # result = floop.calc_gcd(a, b)
    result = frecursive.calc_gcd(a, b)
    print(f'GCD of {a} and {b} is {result}')

def test_diofantic():
    print("Podaj wspolczynniki a, b, c równania diofantycznego")
    a = int(input())
    b = int(input())
    c = int(input())
    # info, solution = floop.solve_diofantic(a, b, c)
    info, solution = frecursive.solve_diofantic(a, b, c)
    if solution == None:
        print(info)
    else:
        print(f'Solution to equation {a}x + {b}y = {c} are x = {solution[0]} and y = {solution[1]}') 

def main():
    test_factorial()
    # test_gcd()
    # test_diofantic()

main()
