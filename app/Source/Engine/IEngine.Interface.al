/// <summary>
/// Defines the contract for deduplication engines, providing methods to calculate duplications and load data from source tables or records.
/// </summary>
interface "IEngine BC365D"
{
    procedure CalculateDuplication(TableId: Integer);
    procedure CalculateDuplicationForRecord(TableId: Integer; SysId: Guid);

    procedure LoadDataFromSource(TableId: Integer): Boolean;

    procedure LoadDataFromSourceRecord(TableId: Integer; SysId: Guid): Boolean;
}