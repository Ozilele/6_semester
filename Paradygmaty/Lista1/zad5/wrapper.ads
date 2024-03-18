with Interfaces.C;

package Wrapper is
    type DiofanticSolution is record
        X : Interfaces.C.int;
        Y : Interfaces.C.int;
    end record;
    pragma Convention(C, DiofanticSolution);
    type DiofanticSolution_A is access all DiofanticSolution;

    function Calc_Factorial(N : Integer) return Interfaces.C.unsigned_long_long;
    pragma Import(C, Calc_Factorial, "calc_factorial");

    function Calc_Gcd(A, B : Integer) return Integer;
    pragma Import(C, Calc_Gcd, "calc_gcd");

    function Extended_Gcd(A, B : Integer; X, Y : in out Integer) return Integer;
    pragma Import(C, Extended_Gcd, "extended_gcd");

    function Solve_Diofantic(A, B, C : Integer) return DiofanticSolution_A;
    pragma Import(C, Solve_Diofantic, "solve_diofantic");
end Wrapper;