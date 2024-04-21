import math

class GaloisField:
    def __init__(self, value, order):
        self.value = value
        self.order = order
    def __str__(self):
        return f"{self.value} in Galois Field {self.order}"

    # Assignment Operators
    def __iadd__(self, other): # +=
        return GaloisField((self.value + other.value) % self.order, self.order)
    def __isub__(self, other): # -=
        other_inverse = -other
        return GaloisField((self.value + other_inverse.value) % self.order, self.order)
    def __imul__(self, other): # *=
        return GaloisField((self.value * other.value) % self.order, self.order)
    def __idiv__(self, other): # /=
        other_inv = ~other
        return GaloisField((self.value * other_inv.value) % self.order, self.order)
    
    # Arithmetic operators
    def __add__(self, other):
        new_value = (self.value + other.value) % self.order
        return GaloisField(new_value, self.order)
    
    def __sub__(self, other):
        inverse = -other
        return self + inverse

    def __mul__(self, other):
        new_val = (self.value * other.value) % self.order
        return GaloisField(new_val, self.order)
    
    def __truediv__(self, other):
        other_inverse = ~other
        return self * other_inverse
    
    def __neg__(self):
        return GaloisField(self.order - self.value, self.order)

    def __invert__(self):
        return GaloisField(self.solve_diofantic(self.value, self.order, 1), self.order)
    
    # Comparison operators
    def __eq__(self, other): # equal
        if self.value == other.value:
            return True
        else:
            return False
    def __ne__(self, other): # not equal
        if self.value != other.value:
            return True
        else:
            return False
    def __le__(self, other): # less equal
        if self.value <= other.value:
            return True
        else:
            return False
    def __lt__(self, other): # less than
        if self.value < other.value:
            return True
        else:
            return False
    def __ge__(self, other): # greater equal
        if self.value >= other.value:
            return True
        else:
            return False
    def __gt__(self, other): # greater than
        if self.value > other.value:
            return True
        else:
            return False
        
    def gcd_extended(self, a, b):
        if b == 0:
            x = 1
            y = 0
            return a, x, y
        gcd, x1, y1 = self.gcd_extended(b, a % b)
        x = y1
        y = x1 - math.floor(a / b) * y1
        return gcd, x, y
    
    def solve_diofantic(self, a, b, c):
        gcd, x, y = self.gcd_extended(a, b)
        if x < 0:
            return self.order + x
        else:
            return x
    
    