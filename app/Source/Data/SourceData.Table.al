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
    }

    keys
    {
        key(Key1; "Table ID", "Record SystemId")
        {
            Clustered = true;
        }
    }

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