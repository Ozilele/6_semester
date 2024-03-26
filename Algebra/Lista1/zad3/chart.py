import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# Funkcja V(z - x^2 - y^2) z := x^2 + y^2
def func1(x, y):
    return x**2 + y**2

# Funkcja V(z^2 - x^2 - y^2) z := sqrt(x^2 + y^2)
def func2(x, y):
    return np.sqrt(x**2 + y**2)

def func3(x, y):
    return x**2 - y**2

def func4(x, y):
    return x * y


x = np.linspace(-5, 5, 100)
y = np.linspace(-5, 5, 100)
x, y = np.meshgrid(x, y) # dwuwymiarowa siatka 
z1 = func1(x, y)
z2 = func2(x, y)
z3 = func3(x, y)
z4 = func4(x, y)

fig = plt.figure(figsize=(10, 6))

# ax1 = fig.add_subplot(121, projection='3d')
# ax1.plot_surface(x, y, z1, cmap='viridis')
# ax1.set_xlabel('X')
# ax1.set_ylabel('Y')
# ax1.set_zlabel('Z')
# ax1.set_title(r'$V(z - x^2 - y^2)$')

# ax2 = fig.add_subplot(122, projection='3d')
# ax2.plot_surface(x, y, z2)
# ax2.set_xlabel('X')
# ax2.set_ylabel('Y')
# ax2.set_zlabel('Z')
# ax2.set_title(r'$V(z^2 - x^2 - y^2)$')
ax3 = fig.add_subplot(121, projection='3d')
ax3.plot_surface(x, y, z3, cmap='viridis')
ax3.set_xlabel('X')
ax3.set_ylabel('Y')
ax3.set_zlabel('Z')
ax3.set_title(r'$V(z - x^2 + y^2)$')

ax4 = fig.add_subplot(122, projection='3d')
ax4.plot_surface(x, y, z4, cmap='viridis')
ax4.set_xlabel('X')
ax4.set_ylabel('Y')
ax4.set_zlabel('Z')
ax4.set_title(r'$V(xz, yz)$')

plt.show()