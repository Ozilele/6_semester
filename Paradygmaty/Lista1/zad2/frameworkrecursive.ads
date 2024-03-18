with Diofantic;
use Diofantic;

package FrameworkRecursive is
    function CalcFactorial(N : in Integer) return Integer;
    function CalcGcd(A, B : in out Integer) return Integer;
    function ExtendedGcd(A, B : Integer; X, Y : in out Integer) return Integer;
    function SolveDiofantic(A, B, C : in Integer) return DiofanticSolution_A;
end FrameworkRecursive;