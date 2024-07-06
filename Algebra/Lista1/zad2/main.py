import polynomial as pol

def format_polynomial(f):
    f_pol = ""
    for i in range(len(f)):
        if f[i] != 0:
            if i != 0:
                f_pol += " + "
                f_pol += f'{f[i]}x^{i}'
            else:
                f_pol += f'{f[i]}'
    return f_pol

def test_div_remainder(f, g):
    quotient, remainder = pol.div_remainder(f, g)
    f_pol = format_polynomial(f)
    g_pol = format_polynomial(g)
    q_pol = format_polynomial(quotient)
    rem_pol = format_polynomial(remainder)
    if rem_pol == "":
        rem_pol = 0.0
    print(f'Division of ({f_pol}) / ({g_pol}) = ({q_pol}) and remainder is = {rem_pol}')

def test_gcd(f, g):
    f_pol = format_polynomial(f)
    g_pol = format_polynomial(g)
    gcd = pol.gcd(f, g)
    gcd_pol = format_polynomial(gcd)
    print(f'GCD({f_pol}, {g_pol}) = {gcd_pol}')

def test_lcm(f, g):
    f_pol = format_polynomial(f)
    g_pol = format_polynomial(g)
    q, rem = pol.lcm(f, g)
    for i in range(len(rem)):
        q[i] += rem[i]
    lcm_pol = format_polynomial(q)
    print(f'LCM({f_pol}, {g_pol}) = {lcm_pol}')

def test_c():
    f = [1.0, 0.0, 1.0]
    g = [1.0, 2.0, 1.0]
    gcd = pol.gcd(f, g)
    gcd_pol = format_polynomial(gcd)
    print(f'Solution to equation (1 + x^2, 1 + 2x + x^2) = (c) is c = {gcd_pol}')

def test_d():
    f = [1.0, 0.0, 1.0]
    g = [1.0, 2.0, 1.0]
    q, rem = pol.lcm(f, g)
    for i in range(len(rem)):
        q[i] += rem[i]
    lcm_pol = format_polynomial(q)
    print(f'Solution to equation (1 + x^2) ∩ (1 + 2x + x^2) = (d) is d = {lcm_pol}')

def test_extended_gcd(f, g):
    f_pol = format_polynomial(f)
    g_pol = format_polynomial(g)
    gcd, A, B = pol.extended_gcd(f, g)
    gcd_pol = format_polynomial(gcd)
    print(f'GCD(f, g) = {gcd_pol}')
    print(f'Wielomian A to {A}')
    print(f'Wielomian B to {B}')

def main():
    pol1_coefficients = input() # a0, a1, ..., an - first polynomial
    pol2_coefficients = input() # a0, a1, ..., an - second polynomial
    coefficients_pol1_list = [float(x) for x in pol1_coefficients.replace(" ", "").split(",")]
    coefficients_pol2_list = [float(x) for x in pol2_coefficients.replace(" ", "").split(",")]
    print(coefficients_pol1_list)
    print(coefficients_pol2_list)
    # test_div_remainder(coefficients_pol1_list, coefficients_pol2_list)
    # test_gcd(coefficients_pol1_list, coefficients_pol2_list)
    # test_lcm(coefficients_pol1_list, coefficients_pol2_list)
    test_extended_gcd(coefficients_pol1_list, coefficients_pol2_list)
    # test_c()
    # test_d()

main()