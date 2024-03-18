with Diofantic;
use Diofantic;

package FrameworkRecursive is

    type DiofanticSolution_A is access all DiofanticSolution;

    function CalcFactorial(N : in Integer) return Integer;
    pragma Export(C, CalcFactorial, "calcFactorial");

    function CalcGcd(A, B : in Integer) return Integer;
    pragma Export(C, CalcGcd, "calcGcd");

    function ExtendedGcd(A, B : Integer; X, Y : in out Integer) return Integer;
    pragma Export(C, ExtendedGcd, "extendedGcd");

    function SolveDiofantic(A, B, C : in Integer) return DiofanticSolution_A;
    pragma Export(C, SolveDiofantic, "solveDiofantic");

end FrameworkRecursive;