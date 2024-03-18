with Ada.Text_IO;
use Ada.Text_IO;
with System;
with Diofantic;
use Diofantic;

package body FrameworkRecursive is

    function CalcFactorial(N : in Integer) return Integer is 
    begin
        if N = 0 then
            return 1;
        end if;
        return N * CalcFactorial(N - 1);
    end CalcFactorial;

    function CalcGcd(A, B : in Integer) return Integer is 
        Tmp, TmpA, TmpB : Integer;
    begin 
        TmpA := A;
        TmpB := B;
        if TmpB = 0 then
            return TmpA;
        end if;
        Tmp := TmpA;
        TmpA := TmpB;
        TmpB := Tmp mod TmpB;
        return CalcGcd(TmpA, TmpB);
    end CalcGcd;

    function ExtendedGcd(A, B : Integer; X, Y : in out Integer) return Integer is
        X1, Y1 : Integer;
        GCD : Integer; 
    begin
        if B = 0 then
            X1 := X;
            Y1 := Y;
            X := 1;
            Y := 0;
            return A;
        end if;
        GCD := ExtendedGcd(B, A mod B, X1, Y1);
        X := Y1;
        Y := X1 - (A / B) * Y1;
        return GCD;
    end ExtendedGcd;

    function SolveDiofantic(A, B, C : in Integer) return DiofanticSolution_A is 
        X, Y, GCD : Integer;
        Solution : DiofanticSolution_A := null;
    begin 
        if A = 0 and B = 0 then
            if C = 0 then 
                Put_Line("Infinite solution exists");
            else 
                Put_Line("No solutions exist");
            end if;
        else 
            GCD := ExtendedGcd(A, B, X, Y);
            if C mod GCD /= 0 then
                Put_Line("No solution exist");
            else 
                Solution := new DiofanticSolution'(X => X * (C / GCD), Y => Y * (C / GCD));
            end if;
        end if;
        return Solution;
    end SolveDiofantic;

end FrameworkRecursive;