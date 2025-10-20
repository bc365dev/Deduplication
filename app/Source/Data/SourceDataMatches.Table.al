table 63004 "Source Data Matches BC365D"
{
    Caption = 'Source Data Matches';
    Description = 'Table to store matches found during the deduplication process, linking source data entries that are considered duplicates.';
    DataClassification = CustomerContent;
    LookupPageId = "Source Data Matches BC365D";
    DrillDownPageId = "Source Data Matches BC365D";

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
            ToolTip = 'SystemId of the record in the table identified by the table ID.';
        }
        field(3; "Related Record SystemId"; Guid)
        {
            Caption = 'Related Record SystemId';
            ToolTip = 'SystemId of the related record in the table identified by the table ID.';
        }
        field(4; "Comparison Length"; Integer)
        {
            Caption = 'Comparison Length';
            ToolTip = 'Length of the comparison used to determine the match.';
        }
        field(5; "Distance"; Integer)
        {
            Caption = 'Distance';
            ToolTip = 'Calculated distance metric indicating how similar the records are.';
        }
        field(6; "Source Record Id"; RecordId)
        {
            Caption = 'Source Record Id';
            ToolTip = 'Record ID of the source record in the table identified by the table ID.';
        }
        field(7; "Related Record Id"; RecordId)
        {
            Caption = 'Related Record Id';
            ToolTip = 'Record ID of the related record in the table identified by the table ID.';
        }
    }

    keys
    {
        key(Key1; "Table ID", "Record SystemId", "Related Record SystemId")
        {
            Clustered = true;
        }
    }

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

    /// <summary>
    /// Opens the page for the related record using Page Management.
    /// </summary>
    procedure ShowRelatedRecord()
    var
        PageManagement: Codeunit "Page Management";
        RecRef: RecordRef;
    begin
        RecRef.Open(Rec."Table ID");
        RecRef.GetBySystemId(Rec."Related Record SystemId");
        PageManagement.PageRun(RecRef);
        RecRef.Close();
    end;

    /// <summary>
    /// Merges the duplicate records using the source data utilities.
    /// </summary>
    procedure MergeDuplicate()
    var
        SourceDataUtilities: Codeunit "Source Data Utilities BC365D";
    begin
        SourceDataUtilities.MergeDuplicate(Rec."Table ID", Rec."Source Record Id", Rec."Related Record Id");
    end;

    procedure GetSourceMatchData(var DataObject: JsonObject)
    var
        EngineFactory: Codeunit "Engine Intf. Factory BC365D";
        DeduplicationEngine: Interface "IEngine BC365D";
    begin
        DeduplicationEngine := EngineFactory.GetEngine(Rec."Table ID");
        DeduplicationEngine.GetSourceDataAsJson(Rec, DataObject);
    end;

    procedure ShowDiffControl(var DataObject: JsonObject)
    var
        EngineFactory: Codeunit "Engine Intf. Factory BC365D";
        DeduplicationEngine: Interface "IEngine BC365D";
    begin
        DeduplicationEngine := EngineFactory.GetEngine(Rec."Table ID");
        DeduplicationEngine.ShowDiffControl(DataObject);
    end;
}