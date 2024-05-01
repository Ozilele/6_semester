from GaloisField import GaloisField

ORDER = 1234577

def checkEQ(a, b):
    if(a != b):
        return False
    return True

def testArithmeticOperators():
    a = GaloisField(1, ORDER)
    b = GaloisField(2, ORDER)
    c = GaloisField(3, ORDER)
    return checkEQ(a + b, c) and checkEQ(b - a, a) and checkEQ(a * b, b) and checkEQ(b * c, GaloisField(6, ORDER)) and checkEQ(c / b, GaloisField(617290, ORDER)) and checkEQ(-a, GaloisField(1234576, ORDER)) and checkEQ(GaloisField(321, ORDER) * GaloisField(15676, ORDER), GaloisField(93688, ORDER))

def testComparisonOperators():
    a = GaloisField(20, ORDER)
    b = GaloisField(20, ORDER)
    c = GaloisField(25, ORDER)
    d = GaloisField(15, ORDER)
    e = GaloisField(21, ORDER)
    return a == b and a != c and d <= c and e >= d and e < c and b > d

def testAssignmentOperators():
    a = GaloisField(10, ORDER)
    b = GaloisField(2, ORDER)
    c = GaloisField(3, ORDER)
    d = GaloisField(4, ORDER)
    e = GaloisField(5, ORDER)
    a += b
    d -= b
    b *= c
    c /= d
    e = b
    return checkEQ(a, GaloisField(12, ORDER)) and checkEQ(d, GaloisField(2, ORDER)) and checkEQ(b, GaloisField(6, ORDER)) and checkEQ(c, GaloisField(617290, ORDER)) and checkEQ(e, GaloisField(6, ORDER))

def main():
    # response = testArithmeticOperators() and testComparisonOperators() and testAssignmentOperators()
    # if response is True:
    #     print("All the tests are passed.")
    # else:
    #     print("Failed to pass all the tests.")
    res_1 = testArithmeticOperators()
    res_2 = testComparisonOperators()
    res_3 = testAssignmentOperators()
    print(f'Test arithmetic operators is {res_1}')
    print(f'Test comparison operators is {res_2}')
    print(f'Test assignment operators is {res_3}')

main()
