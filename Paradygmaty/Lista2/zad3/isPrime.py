
def isPrime(order):
    if order <= 1:
        return False
    for i in range(2, int(order**0.5) + 1):
        if order % i == 0:
            return False
    return True
