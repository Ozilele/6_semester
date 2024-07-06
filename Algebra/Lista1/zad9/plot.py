import numpy as np
import math
import matplotlib.pyplot as plt

def F1(x, y):
    return (x**2 + y**2 + 4*y)**2 - 16*(x**2 + y**2)

def F2(x, y):
    return 2*(x**2 + 9)*(y**2 - 16) + (x**2 - 9)**2 + (y**2 - 16)**2

def F3(x, y):
    return (350*(x**2)*(y**2) - 15**2 *(x**2 + y**2) + 144*(pow(x, 4) + pow(y, 4)) + 81)

def draw_func(func, title, points, rng):
    x = np.linspace(-rng, rng, 100)
    y = np.linspace(-rng, rng, 100)
    X, Y = np.meshgrid(x, y)
    Z = func(X, Y)

    plt.figure(figsize=(5, 5))
    plt.contour(X, Y, Z, levels=[0], colors='blue')

    for point in points:
        plt.scatter(point[0], point[1], color = 'red')
    plt.title(title)
    plt.show()

draw_func(F1, '$(x^2 + y^2 + 4y)^2 - 16(x^2 + y^2) = 0$', [[0,0]], 10)
draw_func(F2, '$2(x^2 + 9)(y^2 - 16) + (x^2 - 9)^2 + (y^2 - 16)^2 = 0$', [(0, math.sqrt(7)), (0, -math.sqrt(7))], 10)
draw_func(F3, '$350x^2y^2 - 15^2(x^2 + y^2) + 12^2(x^4 + y^4) + 81 = 0$', [], 2)

