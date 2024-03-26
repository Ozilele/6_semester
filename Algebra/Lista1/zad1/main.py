import gauss_module as gmodule

def test_div_remainder(x, y, z, k):
    q, r = gmodule.div_remainder(z, k)
    q_real = int(q.real)
    q_imag = int(q.imag)
    r_real = int(r.real)
    r_imag = int(r.imag)
    print(f'Quotient of division ({x} / {y}) is ({q_real} + {q_imag}i) and remainder is ({r_real} + {r_imag}i)')

def test_gcd(x, y, z, k):
    nwd = gmodule.gcd(z, k)
    if gmodule.norm(nwd) == 1:
        print(f'GCD of {x} and {y} are (1, -1, i, -i)')
    else:
        nwd_real = int(nwd.real)
        nwd_imag = int(nwd.imag)
        print(f'GCD of {x} and {y} is {nwd_real} + {nwd_imag}i')

def test_lcm(x, y, z, k):
    lcm = gmodule.lcm(z, k)
    lcm_real = int(lcm.real)
    lcm_imag = int(lcm.imag)
    print(f'LCM of {x} and {y} is {lcm_real} + {lcm_imag}i')

# (3 + 4i) ∩ (1 + 3i) = (d) - ideał, (a) ∩ (b) = (d) = d ∈ nww(a, b)
def calc_d():
    a = complex(3, 4)
    b = complex(1, 3)
    d = gmodule.lcm(a, b)
    d_real = int(d.real)
    d_imag = int(d.imag)
    print(f'Solution to equation (3 + 4i) ∩ (1 + 3i) = (d) is d = {d_real} + {d_imag}i')

# (3 + 4i, 1 + 3i) = (c), c ∈ nwd(a, b)
def calc_c():
    a = complex(3, 4)
    b = complex(1, 3)
    c = gmodule.gcd(a, b)
    c_real = int(c.real)
    c_imag = int(c.imag)
    print(f'Solution to equation (3 + 4i, 1 + 3i) = (c) is c = {c_real} + {c_imag}i')

def format_input(x):
    imag_positive = True
    real_positive = True
    if "+" in x:
        parts_x = x.lower().replace(" ", "").split("+")
    elif "-" in x:
        imag_positive = False
        if x[0] == '-':
            real_positive = False
            x = x[1:]
        parts_x = x.lower().replace(" ", "").split("-")
    if real_positive:
        a_x = int(parts_x[0])
    else:
        a_x = -1 * int(parts_x[0])
    if imag_positive:
        b_x = int(parts_x[1].replace("i", ""))
    else:
        b_x = -1 * int(parts_x[1].replace("i", ""))
    return complex(a_x, b_x)

# gcd - 6+2i, 15+5i; 18 - 1i, 11 + 7i
def test():
    # x = input()
    # y = input()
    # z = format_input(x)
    # k = format_input(y)
    # test_div_remainder(x, y, z, k)
    # test_gcd(x, y, z, k)
    # test_lcm(x, y, z, k)
    calc_c()
    # calc_d()

test()