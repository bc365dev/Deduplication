codeunit 63000 "Text Utilities BC365D"
{
    procedure TextDistance(Text1: Text; Text2: Text): Integer
    var
        Array1: List of [Integer];
        Array2: List of [Integer];
        i: Integer;
        j: Integer;
        Cost: Integer;
    begin
        // Returns the number of edits to get from Text1 to Text2
        // Reference: https://en.wikipedia.org/wiki/Levenshtein_distance
        if Text1 = Text2 then
            exit(0);
        if Text1 = '' then
            exit(StrLen(Text2));
        if Text2 = '' then
            exit(StrLen(Text1));

        // Initialize Array1 (previous row) with distances from empty string to Text2
        Array1.Add(0);
        for i := 1 to StrLen(Text2) do
            Array1.Add(i);

        for i := 1 to StrLen(Text1) do begin
            // Clear Array2 and initialize first element
            Clear(Array2);
            Array2.Add(i); // Distance for Text1[1..i] to empty Text2

            for j := 1 to StrLen(Text2) do begin
                if CopyStr(Text1, i, 1) = CopyStr(Text2, j, 1) then
                    Cost := 0
                else
                    Cost := 1;
                Array2.Add(MinimumInt3(Array2.Get(j) + 1, Array1.Get(j + 1) + 1, Array1.Get(j) + Cost));
            end;

            // Copy Array2 to Array1 for next iteration
            Clear(Array1);
            for j := 1 to Array2.Count do
                Array1.Add(Array2.Get(j));
        end;
        exit(Array1.Get(StrLen(Text2) + 1));
    end;

    procedure Min(A: Integer; B: Integer): Integer
    begin
        if A < B then
            exit(A)
        else
            exit(B);
    end;

    local procedure MinimumInt3(A: Integer; B: Integer; C: Integer): Integer
    begin
        exit(Min(Min(A, B), C));
    end;


}