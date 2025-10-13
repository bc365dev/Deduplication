/// <summary>
/// Enumerates the types of deduplication engines available, each implementing the IEngine interface with specific engine implementations.
/// </summary>
enum 63000 "Engine Type BC365D" implements "IEngine BC365D"
{
    Caption = 'Engine Type';
    Extensible = true;

    value(0; "Combined Fields")
    {
        Caption = 'Combined Fields';
        Implementation = "IEngine BC365D" = "Combined Fields Engine BC365D";
    }
}