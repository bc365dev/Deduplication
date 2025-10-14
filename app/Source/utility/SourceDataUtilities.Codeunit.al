/// <summary>
/// Provides utility functions for managing source data entries in the deduplication process.
/// </summary>
codeunit 63003 "Source Data Utilities BC365D"
{
    var
        NullGuidErr: Label 'The provided SystemId is a null GUID.';
        NullGuidRelatedErr: Label 'The provided Related SystemId is a null GUID.';

    /// <summary>
    /// Creates a new source data entry for the specified table and record.
    /// </summary>
    /// <param name="TableId">The ID of the table.</param>
    /// <param name="RecSysId">The SystemId of the record.</param>
    /// <param name="CombinedFieldData">The combined field data text.</param>
    /// <returns>True if the entry was inserted successfully.</returns>
    /// <summary>
    /// Creates a new source data entry for the specified table and record.
    /// </summary>
    /// <param name="TableId">The ID of the table.</param>
    /// <param name="RecSysId">The SystemId of the record.</param>
    /// <param name="CombinedFieldData">The combined field data as text.</param>
    /// <returns>True if the entry was created successfully.</returns>
    procedure CreateSourceDataEntry(TableId: Integer; RecSysId: Guid; CombinedFieldData: Text; RecId: RecordId): Boolean
    var
        SourceData: Record "Source Data BC365D";
    begin
        if IsNullGuid(RecSysId) then
            Error(NullGuidErr);

        SourceData.Init();
        SourceData."Table ID" := TableId;
        SourceData."Record SystemId" := RecSysId;
        SourceData."Combined Field Data" := CopyStr(CombinedFieldData, 1, 2048);
        SourceData."Record Id" := RecId;

        OnBeforeCreateSourceDataEntry(SourceData);

        exit(SourceData.Insert(true));
    end;

    /// <summary>
    /// Checks if any source data entries exist for the specified table.
    /// </summary>
    /// <param name="TableId">The ID of the table to check.</param>
    /// <returns>True if records exist, false otherwise.</returns>
    procedure RecordsExist(TableId: Integer): Boolean
    var
        SourceData: Record "Source Data BC365D";
    begin
        SourceData.SetRange("Table ID", TableId);
        exit(not SourceData.IsEmpty());
    end;

    /// <summary>
    /// Deletes all existing source data records for the specified table.
    /// </summary>
    /// <param name="TableId">The ID of the table.</param>
    procedure DeleteExistingRecords(TableId: Integer)
    var
        SourceData: Record "Source Data BC365D";
    begin
        SourceData.SetRange("Table ID", TableId);

        OnBeforeDeleteExistingRecords(SourceData);

        SourceData.DeleteAll(true);
    end;

    /// <summary>
    /// Creates a new source data match entry linking two similar records.
    /// </summary>
    /// <param name="TableId">The ID of the table.</param>
    /// <param name="RecSysId">The SystemId of the source record.</param>
    /// <param name="RelatedRecSysId">The SystemId of the related record.</param>
    /// <param name="ComparisonLength">The length of the comparison data.</param>
    /// <param name="Distance">The calculated distance metric.</param>
    /// <param name="SourceRecId">The RecordId of the source record.</param>
    /// <param name="RelatedRecId">The RecordId of the related record.</param>
    /// <returns>True if the match was created successfully.</returns>
    procedure CreateSourceDataMatch(TableId: Integer; RecSysId: Guid; RelatedRecSysId: Guid; ComparisonLength: Integer; Distance: Integer; SourceRecId: RecordId; RelatedRecId: RecordId): Boolean
    var
        SourceDataMatches: Record "Source Data Matches BC365D";
    begin
        if IsNullGuid(RecSysId) then
            Error(NullGuidErr);

        if IsNullGuid(RelatedRecSysId) then
            Error(NullGuidRelatedErr);

        SourceDataMatches.Init();
        SourceDataMatches."Table ID" := TableId;
        SourceDataMatches."Record SystemId" := RecSysId;
        SourceDataMatches."Related Record SystemId" := RelatedRecSysId;
        SourceDataMatches."Comparison Length" := ComparisonLength;
        SourceDataMatches."Distance" := Distance;
        SourceDataMatches."Source Record Id" := SourceRecId;
        SourceDataMatches."Related Record Id" := RelatedRecId;

        OnBeforeCreateSourceDataMatch(SourceDataMatches);

        exit(SourceDataMatches.Insert(true));
    end;

    /// <summary>
    /// Integration event raised before creating a source data match.
    /// </summary>
    /// <param name="SourceDataMatches">The source data matches record being created.</param>
    [IntegrationEvent(false, false)]
    local procedure OnBeforeCreateSourceDataMatch(var SourceDataMatches: Record "Source Data Matches BC365D")
    begin
    end;

    /// <summary>
    /// Integration event raised before deleting existing records.
    /// </summary>
    /// <param name="SourceData">The source data record being deleted.</param>
    [IntegrationEvent(false, false)]
    local procedure OnBeforeDeleteExistingRecords(var SourceData: Record "Source Data BC365D")
    begin
    end;

    /// <summary>
    /// Integration event raised before creating a source data entry.
    /// </summary>
    /// <param name="SourceData">The source data record being created.</param>
    [IntegrationEvent(false, false)]
    local procedure OnBeforeCreateSourceDataEntry(var SourceData: Record "Source Data BC365D")
    begin
    end;
}