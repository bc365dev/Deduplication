/// <summary>
/// Provides utility functions for managing source data entries in the deduplication process.
/// </summary>
codeunit 63003 "Source Data Utilities BC365D"
{
    var
        NullGuidErr: Label 'The provided SystemId is a null GUID.';
        NullGuidRelatedErr: Label 'The provided Related SystemId is a null GUID.';

    procedure CreateSourceDataEntry(TableId: Integer; RecSysId: Guid; CombinedFieldData: Text): Boolean
    var
        SourceData: Record "Source Data BC365D";
    begin
        if IsNullGuid(RecSysId) then
            Error(NullGuidErr);

        SourceData.Init();
        SourceData."Table ID" := TableId;
        SourceData."Record SystemId" := RecSysId;
        SourceData."Combined Field Data" := CopyStr(CombinedFieldData, 1, 2048);
        exit(SourceData.Insert(true));
    end;

    procedure RecordsExist(TableId: Integer): Boolean
    var
        SourceData: Record "Source Data BC365D";
    begin
        SourceData.SetRange("Table ID", TableId);
        exit(not SourceData.IsEmpty());
    end;

    procedure DeleteExistingRecords(TableId: Integer)
    var
        SourceData: Record "Source Data BC365D";
    begin
        SourceData.SetRange("Table ID", TableId);
        SourceData.DeleteAll();
    end;

    procedure CreateSourceDataMatch(TableId: Integer; RecSysId: Guid; RelatedRecSysId: Guid; ComparisonLength: Integer; Distance: Integer): Boolean
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
        exit(SourceDataMatches.Insert(true));
    end;
}