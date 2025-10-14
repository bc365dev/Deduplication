/// <summary>
/// Stores the combined field data for records from source tables, used in the deduplication process to identify duplicates.
/// </summary>
table 63003 "Source Data BC365D"
{
    DataClassification = CustomerContent;
    Caption = 'Source Data';
    Description = 'Table to store source data entries used in deduplication, holding combined field data for records.';
    LookupPageId = "Source Data BC365D";
    DrillDownPageId = "Source Data BC365D";

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            ToolTip = 'ID of the table associated with this source data entry.';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = CONST(Table), "Object ID" = FIELD("Table ID"));
        }
        field(2; "Record SystemId"; Guid)
        {
            Caption = 'Record SystemId';
            ToolTip = 'SystemId of the record in the source table.';
        }
        field(3; "Combined Field Data"; Text[2048])
        {
            Caption = 'Combined Field Data';
            ToolTip = 'Combined data from multiple fields for deduplication purposes.';
        }
        field(4; "Record Id"; RecordId)
        {
            Caption = 'Record Id';
            ToolTip = 'Record ID of the record in the source table.';
        }
        field(5; "Match Count"; Integer)
        {
            Caption = 'Match Count';
            ToolTip = 'Number of matches found for this source data entry.';
            FieldClass = FlowField;
            CalcFormula = count("Source Data Matches BC365D" where("Table ID" = FIELD("Table ID"), "Record SystemId" = FIELD("Record SystemId")));
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Table ID", "Record SystemId")
        {
            Clustered = true;
        }
    }

    /// <summary>
    /// Triggered when a source data record is deleted.
    /// Cleans up related source data matches.
    /// </summary>
    trigger OnDelete()
    var
        SourceDataMatches: Record "Source Data Matches BC365D";
    begin
        SourceDataMatches.SetRange("Table ID", Rec."Table ID");
        if not SourceDataMatches.IsEmpty() then
            SourceDataMatches.DeleteAll();
    end;

    /// <summary>
    /// Opens the page for the source record using Page Management.
    /// </summary>
    procedure ShowSourceRecord()
    var
        PageManagement: Codeunit "Page Management";
        RecRef: RecordRef;
    begin
        RecRef.Open(Rec."Table ID");
        RecRef.GetBySystemId(Rec."Record SystemId");
        PageManagement.PageRun(RecRef);
        RecRef.Close();
    end;

    procedure ShowMatches()
    var
        SourceDataMatches: Record "Source Data Matches BC365D";
        PageManagement: Codeunit "Page Management";
    begin
        SourceDataMatches.SetRange("Table ID", Rec."Table ID");
        SourceDataMatches.SetRange("Record SystemId", Rec."Record SystemId");
        PageManagement.PageRun(SourceDataMatches);
    end;

    procedure CalculateDuplicates()
    var
        EngineFactory: Codeunit "Engine Intf. Factory BC365D";
        DeduplicationEngine: Interface "IEngine BC365D";
    begin
        DeduplicationEngine := EngineFactory.GetEngine(Rec."Table ID");
        DeduplicationEngine.CalculateDuplicationForRecord(Rec."Table ID", Rec."Record SystemId");
    end;
}