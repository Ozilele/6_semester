import numpy as np
import matplotlib.pyplot as plt

def draw_curve(func, rng, special_points, title):
    x = np.linspace(-rng, rng, 100)
    y = np.linspace(-rng, rng, 100)

    X, Y = np.meshgrid(x, y)
    Z = func(X, Y)

    plt.figure(figsize=(4, 4))
    plt.contour(X, Y, Z, levels=[0], colors='green')

    for point in special_points:
        plt.scatter(point[0], point[1], color='red')

    plt.title(title)
    plt.show()

for k in [-4, -2, 0, 1, 2, 3]:
    draw_curve(lambda x, y: x**3 + x*y**2 - (1 + k)*x**2 - y**2, 5, [], f"z - x^3 - xy^2 + (1 + {k})x^2 + y^2 = 0")