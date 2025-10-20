/// <summary>
/// Defines the contract for deduplication engines, providing methods to calculate duplications and load data from source tables or records.
/// </summary>
interface "IEngine BC365D"
{
    /// <summary>
    /// Calculates duplications for all records in the specified table.
    /// </summary>
    /// <param name="TableId">The ID of the table to process.</param>
    procedure CalculateDuplication(TableId: Integer);

    /// <summary>
    /// Calculates duplications for a specific record in the table.
    /// </summary>
    /// <param name="TableId">The ID of the table.</param>
    /// <param name="SysId">The SystemId of the record.</param>
    procedure CalculateDuplicationForRecord(TableId: Integer; SysId: Guid);

    /// <summary>
    /// Loads source data from all records in the specified table.
    /// </summary>
    /// <param name="TableId">The ID of the table to load data from.</param>
    /// <returns>True if data was loaded successfully.</returns>
    procedure LoadDataFromSource(TableId: Integer): Boolean;

    /// <summary>
    /// Loads source data from a specific record in the table.
    /// </summary>
    /// <param name="TableId">The ID of the table.</param>
    /// <param name="SysId">The SystemId of the record.</param>
    /// <returns>True if data was loaded successfully.</returns>
    procedure LoadDataFromSourceRecord(TableId: Integer; SysId: Guid): Boolean;

    procedure GetDuplicateReportId(): Integer;

    procedure RunDuplicatesReport(TableId: Integer);

    procedure GetSourceDataAsJson(SourceDataMatch: Record "Source Data Matches BC365D"; var DataObject: JsonObject);

    procedure ShowDiffControl(var DataObject: JsonObject);
}