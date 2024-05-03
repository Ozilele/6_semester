from typing import List, TypeVar, Generic, Callable
from numpy import random
import math

T = TypeVar('T')

class DHSetup(Generic[T]):

    def __init__(self, field: T, field_creator: Callable[[int, int], T]):
        self.field = field
        self.P = field.order
        self.field_creator = field_creator
        print(self.P)
        primes = self.findPrimesDividingP(self.P - 1)
        for elem in primes:
            print(f'{elem}')
        gen: T = None
        while gen is None:
            element = self.generateRandom(1, self.P - 1)
            if self.isGenerator(element, primes):
                print(f'Gen is {element}')
                gen = field_creator(element, self.P)
                break
        self.generator = gen

    def findPrimesDividingP(self, n: int) -> list[int]:
        result = []
        marked = []
        for i in range(0, n + 1):
            marked.append(True)
        for i in range(2, int(math.sqrt(n)) + 1):
            if marked[i] == True:
                j = i * i
                while j <= n:
                    marked[j] = False
                    j = j + i
        for j in range(2, n + 1):
            if marked[j] == True: # if j is prime number
                if n % j == 0:
                    result.append(j)
        return result

    def isGenerator(self, a: int, primes) -> bool:
        for prime in primes:
            factor = (self.P - 1) / prime
            elem = a * factor
            if elem == 1:
                return False
        return True

    def generateRandom(self, min: int, max: int):
        return random.randint(min, max + 1)

    def decomposeIntoPowersOfTwo(self, num) -> List[int]:
        powers = []
        bitPosition = 0
        while num > 0:
            if num & 1:
                powers.append(1 << bitPosition)
            num >>= 1
            bitPosition += 1
        return powers
    
    def getGenerator(self) -> T:
        return self.generator
    
    def power(self, a: T, b: int) -> T:
        a_val = a.value
        powers = self.decomposeIntoPowersOfTwo(b)
        modulus = []
        values = []
        j = 0
        i = 1
        while i <= powers[-1]:
            modulo = None
            if i == 1:
                modulo = a_val % self.P
            else:
                modulo = (modulus[-1] * modulus[-1]) % self.P
            modulus.append(modulo)
            if powers[j] == i:
                j += 1
                values.append(modulo) 
            i *= 2
        multiply = 1
        for value in values:
            multiply = (multiply * value) % self.P
        print(f'Wynik {multiply}')
        # return T(multiply, self.P)
        return self.field_creator(multiply, self.P)
    

