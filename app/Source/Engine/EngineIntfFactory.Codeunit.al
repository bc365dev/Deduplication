/// <summary>
/// Factory codeunit for creating deduplication engine instances based on table configuration, returning the appropriate engine interface implementation.
/// </summary>
codeunit 63001 "Engine Intf. Factory BC365D"
{
    /// <summary>
    /// Retrieves the deduplication engine interface for the specified table.
    /// </summary>
    /// <param name="TableId">The ID of the table.</param>
    /// <returns>The engine interface implementation.</returns>
    procedure GetEngine(TableId: Integer): Interface "IEngine BC365D"
    var
        DeduplicationEngineEntry: Record "Dedupe Engine Entry BC365D";
    begin
        DeduplicationEngineEntry.SetRange("Table ID", TableId);
        if DeduplicationEngineEntry.FindFirst() then
            exit(DeduplicationEngineEntry."Engine Type");
    end;
}