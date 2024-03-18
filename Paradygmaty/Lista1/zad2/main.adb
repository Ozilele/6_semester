with Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Text_IO;
use Ada.Integer_Text_IO;
--  with FrameworkRecursive;
--  use FrameworkRecursive;
with FrameworkLoop;
use FrameworkLoop;
with System;
with Diofantic;
use Diofantic;

procedure Main is
    N : Integer;
    A, B, C : Integer;
    Result : Integer;
    Solution : DiofanticSolution;

    procedure TestDiofantic is
        Solution_Ptr : DiofanticSolution_A;
    begin
        Put_Line("Podaj wspolczynniki a, b, c równania diofantycznego");
        Get(A);
        Get(B);
        Get(C);
        Solution_Ptr := SolveDiofantic(A, B, C);
        if Solution_Ptr /= null then
            Solution := Solution_Ptr.all;
            Put_Line("Solution to equation" & Integer'Image(A) & "X +" & Integer'Image(B) & "Y =" & Integer'Image(C) & " are X = " & Integer'Image(Solution.X) & " and Y =" & Integer'Image(Solution.Y));
        end if;
    end TestDiofantic;

    procedure TestFactorial is
    begin
        Put_Line("Dla jakiego n program ma policzyć silnię?");
        Get(N);
        Result := CalcFactorial(N);
        Put_Line("Factorial of" & Integer'Image(N) & " is" & Integer'Image(Result));
    end TestFactorial;

    procedure TestGCD is 
        A1, B1 : Integer;
    begin 
        Put_Line("Podaj 2 liczby w celu obliczenia ich nwd.");
        Get(A);
        Get(B);
        A1 := A;
        B1 := B;
        Result := CalcGcd(A, B);
        Put_Line("GCD of" & Integer'Image(A1) & " and" & Integer'Image(B1) & " is" & Integer'Image(Result));
    end TestGCD;

begin
    --  TestDiofantic;
    --  TestFactorial;
    TestGCD;
end Main;