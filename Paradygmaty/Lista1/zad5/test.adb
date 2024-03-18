with Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Text_IO;
use Ada.Integer_Text_IO;
with Interfaces.C;
with Wrapper;
use Wrapper;
-- Kompilacja:
-- /Users/bartiq/dev/IDE/GNAT/bin/gcc -c call.c
--  gnatmake test.adb -largs call.o // -largs defines linker switches, will be passed on to all link steps 

procedure Test is
    N_long : Interfaces.C.unsigned_long_long;
    A, B, C, N, GCD : Integer;
    Result : Interfaces.C.unsigned_long_long;
    Solution_Ptr : Wrapper.DiofanticSolution_A;
    Solution : Wrapper.DiofanticSolution;

    procedure Test_Solve_Diofantic is
    begin
        Put_Line("Podaj wspolczynniki a, b, c równania diofantycznego");
        Get(A);
        Get(B);
        Get(C);
        Solution_Ptr := Wrapper.Solve_Diofantic(A, B, C);
        if Solution_Ptr /= null then
            Solution := Solution_Ptr.all;
            Put_Line("Solution to equation" & Integer'Image(A) & "X +" & Integer'Image(B) & "Y =" & Integer'Image(C) & " are X = " & Interfaces.C.int'Image(Solution.X) & " and Y =" & Interfaces.C.int'Image(Solution.Y));
        end if;
    end Test_Solve_Diofantic;
    
    procedure Test_Calc_Factorial is 
    begin
        Put_Line("Dla jakiego n program ma policzyć silnię?");
        Get(N);
        N_long := Interfaces.C.unsigned_long_long(N);
        Result := Wrapper.Calc_Factorial(N);
        Put_Line("Factorial of" & Interfaces.C.unsigned_long_long'Image(N_long) & " is" & Interfaces.C.unsigned_long_long'Image(Result));
    end Test_Calc_Factorial;

    procedure Test_Calc_GCD is
    begin
        Put_Line("Podaj 2 liczby w celu obliczenia ich nwd.");
        Get(A);
        Get(B);
        GCD := Wrapper.Calc_Gcd(A, B);
        Put_Line("GCD of" & Integer'Image(A) & " and" & Integer'Image(B) & " is" & Integer'Image(GCD));
    end Test_Calc_GCD;

begin
    Test_Solve_Diofantic;
    --  Test_Calc_Factorial;
    --  Test_Calc_GCD;
end Test;