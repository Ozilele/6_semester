

package Diofantic is

    type DiofanticSolution is record 
        X : Integer;
        Y : Integer;
    end record;
    function CreateDiofanticSolution(X : Integer; Y : Integer) return DiofanticSolution;
end Diofantic;