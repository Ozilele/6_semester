import numpy as np
import matplotlib.pyplot as plt

# Funkcja promienia
def r(theta):
    return np.sin(2 * theta)

# Zakres kąta theta
theta_values = np.linspace(0, 2 * np.pi, 1000)
# Wartości krzywej czterolistnej
r_values = r(theta_values) # promień krzywej czterolistnej w ukladzie biegunowym

# Przejście od układu biegunowego do kartezjańskiego
x_values = r_values * np.cos(theta_values)
y_values = r_values * np.sin(theta_values)

def w(x, y):
    return np.sin(2 * np.arctan2(y, x))

x_test = np.array([1.0, 1.5, 3.0, 0.15, 25, 22, -50.0])
y_test = np.array([2.0, 2.0, 100, -1000.0, 15, 80, 70.0])

for i in range(len(x_test)):
    print(f'Wartość r dla x = {x_test[i]} i y = {y_test[i]} wynosi {w(x_test[i], y_test[i])}')

x = np.linspace(-5, 5, 100)
# y = np.linspace(-5, 5, 100)
w_val = w(x, 0.0)

plt.figure(figsize=(8, 8))
plt.plot(x_values, y_values, label = 'Krzywa czterolistna')
# plt.plot(x, w_val, label = 'xx')
# plt.title('Wykres krzywej czterolistnej')s
plt.xlabel('x')
plt.ylabel('y')

# plt.xlim(-1.0, 1.0)
# plt.ylim(-1.0, 1.0)
# plt.grid(True)
plt.legend()
plt.show()
# w(x, y) = 1.0 if abs(x) = abs(y) and sign(x) = sign(y)
#          -1.0 if abs(x) = abs(y) and sign(x) != sign(y)
#               
#