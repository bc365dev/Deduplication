/// <summary>
/// Provides utility functions for text manipulation and comparison, including Levenshtein distance calculation for deduplication purposes.
/// </summary>
codeunit 63000 "Text Utilities BC365D"
{
    /// <summary>
    /// Calculates the Levenshtein distance between two text strings.
    /// </summary>
    /// <param name="Text1">The first text string.</param>
    /// <param name="Text2">The second text string.</param>
    /// <returns>The number of edits required to transform Text1 into Text2.</returns>
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

    /// <summary>
    /// Returns the minimum of two integer values.
    /// </summary>
    /// <param name="A">The first integer.</param>
    /// <param name="B">The second integer.</param>
    /// <returns>The smaller of the two integers.</returns>
    procedure Min(A: Integer; B: Integer): Integer
    begin
        if A < B then
            exit(A)
        else
            exit(B);
    end;

    /// <summary>
    /// Returns the minimum of three integer values.
    /// </summary>
    /// <param name="A">The first integer.</param>
    /// <param name="B">The second integer.</param>
    /// <param name="C">The third integer.</param>
    /// <returns>The smallest of the three integers.</returns>
    local procedure MinimumInt3(A: Integer; B: Integer; C: Integer): Integer
    begin
        exit(Min(Min(A, B), C));
    end;

    /// <summary>
    /// Removes all special characters from the input text, with options to remove spaces and apply case conversion.
    /// </summary>
    /// <param name="InputText">The text to process.</param>
    /// <param name="RemoveSpaces">If true, spaces are also removed.</param>
    /// <param name="CaseOption">Option for case conversion: None, Upper, or Lower.</param>
    /// <returns>The processed text with special characters removed and case applied.</returns>
    procedure RemoveSpecialCharacters(InputText: Text; RemoveSpaces: Boolean; CaseOption: Option None,Upper,Lower): Text
    var
        Result: Text;
        i: Integer;
        Char: Char;
    begin
        for i := 1 to StrLen(InputText) do begin
            Char := InputText[i];
            if ((Char >= 65) and (Char <= 90)) or  // A-Z
               ((Char >= 97) and (Char <= 122)) or // a-z
               ((Char >= 48) and (Char <= 57)) or  // 0-9
               (not RemoveSpaces and (Char = 32)) then // space if not removing
                Result += Char;
        end;

        case CaseOption of
            CaseOption::Upper:
                Result := UpperCase(Result);
            CaseOption::Lower:
                Result := LowerCase(Result);
        end;

        exit(Result);
    end;

    /// <summary>
    /// Returns the specified segment of a text or code field based on the requested part.
    /// </summary>
    /// <param name="FieldVar">The field value provided as a Variant that must contain text or code data.</param>
    /// <param name="PartOfField">Specifies which portion of the field to return, such as All, First, Last, or custom via event subscribers.</param>
    /// <param name="Length">The number of characters to include when the part requires a length constraint.</param>
    /// <returns>The extracted field segment or an empty string when the Variant is not text or code.</returns>
    procedure GetPartOfFieldAsText(FieldVar: Variant; PartOfField: Enum "Part of Field BC365D"; Length: Integer): Text
    var
        FieldValue: Text;
    begin
        if (FieldVar.IsText() or FieldVar.IsCode()) then begin

            FieldValue := Format(FieldVar);

            case PartOfField of
                PartOfField::All:
                    exit(FieldValue);
                PartOfField::First:
                    begin
                        FieldValue := FieldValue.Substring(1, Length);
                        exit(FieldValue);
                    end;
                PartOfField::Last:
                    begin
                        FieldValue := FieldValue.Substring((StrLen(FieldValue) - Length) + 1, Length);
                        exit(FieldValue);
                    end;
                else begin
                    OnTextCustomPartOfFieldAsText(FieldValue, PartOfField, Length);
                    exit(FieldValue);
                end;
            end;
        end;

    end;

    [IntegrationEvent(false, false)]
    local procedure OnTextCustomPartOfFieldAsText(var FieldValue: Text; PartOfField: Enum "Part of Field BC365D"; Length: Integer)
    begin
    end;
}