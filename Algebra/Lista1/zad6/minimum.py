import matplotlib.pyplot as plt

def lt(a, b): # do sprawdzania współrzędnych punktów 
    for i in range(len(a)):
        if a[i] < b[i]:
            return False
    return True

def minimalElements(A):
    minimal_el = []
    for a in A:
        found = False
        for m in minimal_el:
            if lt(m, a):
                minimal_el.remove(m)
            elif lt(a, m): # case when a = (2, 9) and m = (2, 6)
                found = True
                break
        if not found: # case when a = (3,4) and m = (2,6), a = (4,3) itd
            minimal_el.append(a)
    return minimal_el

# punkty minimalne na czerwono
def draw(all_el, minimal_el):
    plt.figure(figsize=(4, 4))
    for a in all_el:
        plt.scatter(a[0], a[1], color = 'blue') 
    for m in minimal_el:
        plt.scatter(m[0], m[1], color='red')
    plt.show()
    
# Generowanie punktów w N^2 spełniających daną zalezność
grid1 = [(n, k) for n in range(0, 15) for k in range(0, 15) if n * k >= 11] 
print(grid1)
print("Minimals elements of set A = { (n, k) | n, k ∈ [0, 100) and n * k >= 11 } are:")
print(minimalElements(grid1))
draw(grid1, minimalElements(grid1))

grid2 = [(n, k) for n in range(0, 100) for k in range(0, 100) if (n - 10)**2 + (k - 10)**2 <= 25]
print(grid2)
print("Minimals elements of set B = { (n, k) | n, k ∈ [0, 100) and (n - 10)^2 + (k - 10)^2 <= 25 } are:")
print(minimalElements(grid2))
draw(grid2, minimalElements(grid2))