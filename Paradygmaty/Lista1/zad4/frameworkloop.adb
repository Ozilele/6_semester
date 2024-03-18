with Ada.Text_IO;
use Ada.Text_IO;
with System;
with Diofantic;
use Diofantic;

package body FrameworkLoop is
    
    function CalcFactorial(N : in Integer) return Integer is
        Fact : Integer := 1;
    begin
        Put_Line("Called from Ada module");
        if N < 0 then
            Put_Line("Error: Factorial of a negative number does not exist");
            return -1;
        elsif N = 0 then
            return 1;
        else 
            for I in 1 .. N loop
                Fact := Fact * I;
            end loop;
        end if;
        return Fact;
    end CalcFactorial;

    function CalcGcd(A, B : Integer) return Integer is
        Tmp : Integer;
        TmpA, TmpB : Integer;
    begin
        TmpA := A;
        TmpB := B;
        if A = 0 then
            return B;
        end if;
        while TmpB /= 0 loop
            Tmp := TmpA;
            TmpA := TmpB;
            TmpB := Tmp mod TmpB;
        end loop;
        return TmpA;
    end CalcGcd;

    function ExtendedGcd(A, B : Integer; X, Y : in out Integer) return Integer is 
        Y0, X1 : Integer := 0;
        X0, Y1 : Integer := 1;
        Tmp, Q, R : Integer;
        TmpA, TmpB : Integer;
    begin
        TmpA := A;
        TmpB := B;
        while TmpB /= 0 loop
            Q := TmpA / TmpB;
            R := TmpA mod TmpB;
            TmpA := TmpB;
            TmpB := R;
            Tmp := X1;
            X1 := X0 - Q * X1;
            X0 := Tmp;
            Tmp := Y1;
            Y1 := Y0 - Q * Y1;
            Y0 := Tmp;
        end loop;
        X := X0;
        Y := Y0;
        return TmpA;
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

end FrameworkLoop;
