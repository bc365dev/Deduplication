/// <summary>
/// Configures the deduplication engine type for each table, linking tables to their assigned deduplication engines.
/// </summary>
table 63001 "Dedupe Engine Entry BC365D"
{
    Caption = 'Deduplication Engine Entry';
    Description = 'Table for Deduplication Engine Entry, holds the configuration for engine is associated with which table.';
    DataClassification = CustomerContent;
    LookupPageId = "Dedupe Engine Entry BC365D";
    DrillDownPageId = "Dedupe Engine Entry BC365D";

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            ToolTip = 'ID of the table associated with this deduplication engine entry.';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = CONST(Table), "Object ID" = FIELD("Table ID"));
        }
        field(2; "Engine Type"; Enum "Engine Type BC365D")
        {
            Caption = 'Engine Type';
            ToolTip = 'Type of deduplication engine associated with the table.';
        }
        field(3; "Table Caption"; Text[249])
        {
            Caption = 'Table Caption';
            ToolTip = 'Caption of the table associated with this deduplication engine entry.';
            FieldClass = FlowField;
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = CONST(Table), "Object ID" = FIELD("Table ID")));
            Editable = false;
        }
        field(4; "Loaded Source Records"; Integer)
        {
            Caption = 'No. of Loaded Source Records';
            ToolTip = 'Number of source records loaded for deduplication in this table.';
            FieldClass = FlowField;
            CalcFormula = count("Source Data BC365D" where("Table ID" = FIELD("Table ID")));
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Table ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    procedure LoadSourceData(): Boolean
    var
        EngineFactory: Codeunit "Engine Intf. Factory BC365D";
        DeduplicationEngine: Interface "IEngine BC365D";
    begin
        DeduplicationEngine := EngineFactory.GetEngine(Rec."Table ID");
        exit(DeduplicationEngine.LoadDataFromSource(Rec."Table ID"));
    end;
}