from typing import List, TypeVar, Generic
from numpy import random

T = TypeVar('T')

class User(Generic[T]):

    def __init__(self, dh: T):
        self.dh = dh
        self.secret = self.generateRandom(1, dh.P - 1)
        print(f'Secret key is {self.secret}')

    def generateRandom(self, min: int, max: int):
        return random.randint(min, max + 1)
    
    def getPublicKey(self) -> T:
        gen: T = self.dh.getGenerator()
        return self.dh.power(gen, self.secret)
    
    def setKey(self, a: T):
        self.encryption_key = self.dh.power(a, self.secret)

    def encrypt(self, m: T) -> T:
        return m * self.encryption_key

    def decrypt(self, c: T) -> T:
        return c / self.encryption_key
