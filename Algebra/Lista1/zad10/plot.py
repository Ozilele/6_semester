import numpy as np
import matplotlib.pyplot as plt

u = np.linspace(-1, 1, 100)
v = np.linspace(-1, 1, 100)
U, V = np.meshgrid(u, v)

X_w = U
Y_w = U * V
Z_w = V**2

fig = plt.figure()
ax = fig.add_subplot(121, projection='3d')
ax.plot_surface(X_w, Y_w, Z_w, cmap='viridis', edgecolor='r')

ax.set_xlabel('X')
ax.set_ylabel('Y')
ax.set_zlabel('Z')
ax.set_title(r'Whitney Umbrella(x^2 - y^2z = 0)')

# Rozmaitość
x = np.linspace(-2, 2, 200)
y = np.linspace(-2, 2, 200)
X_v, Y_v = np.meshgrid(x, y)

Z_v = np.zeros_like(X_v)
mask = np.abs(Y_v) > 1e-6
Z_v[mask] = X_v[mask]**2 / Y_v[mask]**2 # Z = X^2 / Y^2

ax2 = fig.add_subplot(122, projection='3d')
ax2.plot_surface(X_v, Y_v, Z_v, cmap='viridis', edgecolor='b')
ax2.set_xlabel('X')
ax2.set_ylabel('Y')
ax2.set_zlabel('Z')
ax2.set_title(r'Rozmaitość $x^2 - y^2z = 0$')
plt.show()