/// <summary>
/// List page for viewing and managing source data matches identified during deduplication.
/// </summary>
page 63004 "Source Data Matches BC365D"
{
    PageType = List;
    UsageCategory = None;
    SourceTable = "Source Data Matches BC365D";
    Caption = 'Source Data Matches';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Table ID"; Rec."Table ID")
                {
                    ApplicationArea = All;
                    Visible = false;
                    editable = false;
                }
                field("Record SystemId"; Rec."Record SystemId")
                {
                    ApplicationArea = All;
                    Visible = false;
                    editable = false;
                }
                field("Source Record Id"; SourceRecIdText)
                {
                    ApplicationArea = All;
                    Caption = 'Source Record Id';
                    ToolTip = 'Record ID of the source record.';
                    editable = false;
                }
                field("Related Record SystemId"; Rec."Related Record SystemId")
                {
                    ApplicationArea = All;
                    Visible = false;
                    editable = false;
                }
                field("Related Record Id"; RelatedRecIdText)
                {
                    ApplicationArea = All;
                    Caption = 'Related Record Id';
                    ToolTip = 'Record ID of the related record.';
                    editable = false;
                }
                field("Comparison Length"; Rec."Comparison Length")
                {
                    ApplicationArea = All;
                    editable = false;
                }
                field("Distance"; Rec."Distance")
                {
                    ApplicationArea = All;
                    editable = false;
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(ShowSourceRecord)
            {
                Caption = 'Show Source Record';
                ApplicationArea = All;
                Image = View;
                ToolTip = 'View the original source record for the selected source data match.';

                /// <summary>
                /// Opens the page for the source record.
                /// </summary>
                trigger OnAction()
                begin
                    Rec.ShowSourceRecord();
                end;
            }

            action(ShowRelatedRecord)
            {
                Caption = 'Show Related Record';
                ApplicationArea = All;
                Image = View;
                ToolTip = 'View the related source record for the selected source data match.';

                /// <summary>
                /// Opens the page for the related record.
                /// </summary>
                trigger OnAction()
                begin
                    Rec.ShowRelatedRecord();
                end;
            }

            action(ShowDiff)
            {
                Caption = 'Show Differences';
                ApplicationArea = All;
                Image = View;
                ToolTip = 'View the differences between the source record and the related record.';

                /// <summary>
                /// Opens the diff control to show differences between the two records.
                /// </summary>
                trigger OnAction()
                var
                    DiffControlPage: Page "Diff Control BC365D";
                    DataObject: JsonObject;
                begin
                    Rec.GetSourceMatchData(DataObject);
                    DiffControlPage.SetDataObject(DataObject);
                    DiffControlPage.Run();
                end;
            }
        }

        area(Processing)
        {
            action(MergeDuplicate)
            {
                Caption = 'Merge Duplicate';
                ApplicationArea = All;
                Image = Copy;
                ToolTip = 'Merge the selected duplicate records in the source table.';

                /// <summary>
                /// Merges the selected duplicate records.
                /// </summary>
                trigger OnAction()
                begin
                    Rec.MergeDuplicate();
                end;
            }
        }
    }

    var
        SourceRecIdText: Text;
        RelatedRecIdText: Text;

    /// <summary>
    /// Triggered after getting a record to format the RecordId fields for display.
    /// </summary>
    trigger OnAfterGetRecord()
    begin
        SourceRecIdText := Format(Rec."Source Record Id");
        RelatedRecIdText := Format(Rec."Related Record Id");
    end;
}