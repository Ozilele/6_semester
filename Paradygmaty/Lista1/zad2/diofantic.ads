

package Diofantic is
    type DiofanticSolution is record 
        X : Integer;
        Y : Integer;
    end record;
    type DiofanticSolution_A is access all DiofanticSolution;
    function CreateDiofanticSolution(X : Integer; Y : Integer) return DiofanticSolution;
    --  procedure DisplayDiofanticSolution(Solution : DiofanticSolution);
end Diofantic;