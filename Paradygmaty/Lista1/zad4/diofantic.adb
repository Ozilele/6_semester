

package body Diofantic is 
    function CreateDiofanticSolution(X : Integer; Y : Integer) return DiofanticSolution is
        New_Solution : DiofanticSolution;
    begin
        New_Solution.X := X;
        New_Solution.Y := Y;
        return New_Solution;
    end CreateDiofanticSolution;
end Diofantic;