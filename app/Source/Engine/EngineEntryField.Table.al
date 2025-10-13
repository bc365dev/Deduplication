/// <summary>
/// Stores the configuration of fields for each table that are used in the deduplication engine, linking tables to their relevant fields.
/// </summary>
table 63002 "Engine Entry Field BC365D"
{
    Caption = 'Engine Entry Field';
    DataClassification = CustomerContent;
    LookupPageId = "Engine Entry Field BC365D";
    DrillDownPageId = "Engine Entry Field BC365D";

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            ToolTip = 'ID of the table associated with this engine entry.';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = CONST(Table), "Object ID" = FIELD("Table ID"));
        }
        field(2; "Table Caption"; Text[249])
        {
            Caption = 'Table Caption';
            ToolTip = 'Caption of the table associated with this engine entry.';
            FieldClass = FlowField;
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = CONST(Table), "Object ID" = FIELD("Table ID")));
            Editable = false;
        }
        field(3; "Field ID"; Integer)
        {
            Caption = 'Field ID';
            TableRelation = Field."No." where("TableNo" = FIELD("Table ID"));
            ToolTip = 'ID of the field associated with this engine entry.';

            trigger OnLookup()
            var
                SelectedField: Record Field;
                FieldSelection: Codeunit "Field Selection";
            begin
                SelectedField.SetRange(TableNo, Rec."Table ID");
                if FieldSelection.Open(SelectedField) then begin
                    "Field ID" := SelectedField."No.";
                    Rec.Modify();
                end;
            end;
        }
        field(4; "Field Caption"; Text[249])
        {
            Caption = 'Field Caption';
            ToolTip = 'Caption of the field associated with this engine entry.';
            FieldClass = FlowField;
            CalcFormula = lookup(Field."Field Caption" where("No." = FIELD("Field ID"), TableNo = FIELD("Table ID")));
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Table ID", "Field ID")
        {
            Clustered = true;
        }
    }
}