with Ada.Text_IO; use Ada.Text_IO;
with Ada.Real_Time; use Ada.Real_Time;
with Ada.Numerics.Float_Random; use Ada.Numerics.Float_Random;
with Ada.Containers.Indefinite_Hashed_Maps;

procedure Dining_Philosophers is

    --  An entry can be viewed as a special kind of subprogram, which is called by another task using a similar syntax, as we will see later.
    numPhilosophers : constant := 6;
    maxDinings : Integer := 5;

    protected type MyMutex is
        --  procedure Lock;
        entry Lock;
        procedure Unlock;
    private 
        Channel : Boolean := True;
    end MyMutex;

    protected body MyMutex is
        --  procedure Lock is 
        --  begin
        --      Channel := False;
        --  end Lock;
        entry Lock when Channel is
        begin 
            Channel := False;
        end Lock;

        procedure Unlock is
        begin
            Channel := True;
        end Unlock;
    end MyMutex;

    protected type Semaphore is
        procedure Wait(Result : in out Integer);
        --  entry Wait;
        procedure Signal;
        procedure Init(Val : in Integer);
    private
        Value : Integer;
        Mutex : MyMutex;
    end Semaphore;

    protected body Semaphore is
        procedure Wait(Result : in out Integer) is
        begin
            Mutex.Lock;
            if Value <= 0 then
                Mutex.Unlock;
                Result := -1;
            else
                Value := Value - 1;
                Mutex.Unlock;
                Result := 1;
            end if;
        end Wait;

        procedure Signal is
        begin
            Mutex.Lock;
            Value := Value + 1;
            Mutex.Unlock;
        end Signal;

        procedure Init(Val : in Integer) is
        begin
            Value := Val;
        end Init;
    end Semaphore;
    
    Forks : array(1..numPhilosophers) of Semaphore;
    type Eating_Array is array(1..numPhilosophers) of Boolean;
    type Meals_Array is array(1..numPhilosophers) of Integer;

    protected type DiningTable is
        procedure PickUpFirstFork(ID : Integer; Success : out Boolean);
        procedure PickUpSecondFork(ID : Integer; Success : out Boolean);
        procedure ReleaseFork(ID : Integer);
        procedure PutDownForks(ID : Integer);
        procedure UpdateEatingList;
        procedure Lock;
        procedure Unlock;
        procedure UpdateEating(ID : Integer);
        procedure UpdateMealsEaten(ID : Integer);
        function GetMealsEaten(ID : Integer) return Integer;
    private
        Eating : Eating_Array := (others => False);
        MealsEaten : Meals_Array := (others => 0);
        Mutex : MyMutex;
    end DiningTable;

    protected body DiningTable is

        procedure PickUpFirstFork(ID : Integer; Success : out Boolean) is
            Result : Integer := 0;
        begin
            if(ID = numPhilosophers) then -- last philosopher picks right fork first to avoid the situation of deadlock
                Forks((ID mod numPhilosophers) + 1).Wait(Result);
                Success := (Result = 1);
            else
                Forks(ID).Wait(Result);
                Success := (Result = 1);
            end if;
        end PickUpFirstFork;

        procedure PickUpSecondFork(ID : Integer; Success : out Boolean) is
            Result : Integer := 0;
        begin
            if(ID = numPhilosophers) then
                Forks(ID).Wait(Result);
                Success := (Result = 1);
            else
                Forks(ID + 1).Wait(Result);
                Success := (Result = 1);
            end if;
        end PickUpSecondFork;
        
        procedure ReleaseFork(ID : Integer) is
        begin
            if(ID = numPhilosophers) then
                Forks((ID mod numPhilosophers) + 1).Signal;
            else
                Forks(ID).Signal;
            end if;
        end ReleaseFork;

        procedure PutDownForks(ID : Integer) is
        begin
            Put_Line("Philosopher of id"&Integer'Image(ID) & " put down its forks");
            Mutex.Lock;
            Eating(ID) := False;
            UpdateEatingList;
            Mutex.Unlock;

            Forks(ID).Signal;
            Forks((ID mod numPhilosophers) + 1).Signal;
        end PutDownForks;

        procedure UpdateEatingList is
            RightForkInd : Integer := 0;
        begin
            Put("Eating List: [");
            for Phil_ID in 1..numPhilosophers loop
                if Eating(Phil_ID) then
                    RightForkInd := (Phil_ID + 1) mod (numPhilosophers + 1);
                    Put("Phil" & Phil_ID'Image & " with forks ("& Phil_ID'Image & "," & RightForkInd'Image & "), ");
                end if;
            end loop;
            Put("]");
            Put_Line("");
        end UpdateEatingList;

        procedure Lock is
        begin
            Mutex.Lock;
        end Lock;

        procedure Unlock is
        begin
            Mutex.Unlock;
        end Unlock;

        procedure UpdateEating(ID : Integer) is
        begin
            Eating(ID) := True;
        end UpdateEating;

        procedure UpdateMealsEaten(ID : Integer) is
        begin
            MealsEaten(ID) := MealsEaten(ID) + 1;
        end UpdateMealsEaten;

        function GetMealsEaten(ID : Integer) return Integer is
        begin
            return MealsEaten(ID);
        end GetMealsEaten;

    end DiningTable;

    Table : DiningTable;

    task type Philosopher is
        entry Start(ID_Param : in out Integer);
    end Philosopher;

    task body Philosopher is
        G : Ada.Numerics.Float_Random.Generator;
        Success : Boolean;
        Success_Sec : Boolean;
        ID : Integer;
    begin
        accept Start(ID_Param : in out Integer) do
            ID := ID_Param;
        end Start;
        Ada.Numerics.Float_Random.Reset(G);
        Put_Line("Philosopher " & Character'Val(ID + Character'Pos('0')) & " is thinking.");
        --  loop
        while Table.GetMealsEaten(ID) < maxDinings loop 
            -- Thinking
            delay until Ada.Real_Time.Clock + Ada.Real_Time.Milliseconds(Integer(Ada.Numerics.Float_Random.Random(G) * 300.0));
            -- Pick up forks to eat
            Table.PickUpFirstFork(ID, Success);
            if Success /= False then
                Table.PickUpSecondFork(ID, Success_Sec);
                if Success_Sec = False then
                    Table.ReleaseFork(ID);    
                else
                    -- Eating
                    Table.Lock;
                    Table.UpdateMealsEaten(ID);
                    Put_Line("Philosopher"& Integer'Image(ID) & " is eating his meal" &Integer'Image(Table.GetMealsEaten(ID)));
                    Table.UpdateEating(ID);
                    Table.UpdateEatingList;
                    Table.Unlock;
                    delay until Ada.Real_Time.Clock + Ada.Real_Time.Milliseconds(Integer(Ada.Numerics.Float_Random.Random(G) * 500.0));
                    -- Put down forks after eating
                    Table.PutDownForks(ID);
                end if;
            end if;
        end loop;
    end Philosopher;    

    Philosophers : array(1..numPhilosophers) of Philosopher;
    Val : Integer := 1;
    CurrIndex : Integer;

begin
    for I in 1..numPhilosophers loop
        CurrIndex := I;
        Forks(I).Init(Val);
        Philosophers(I).Start(CurrIndex);
    end loop;
    null;
end Dining_Philosophers;