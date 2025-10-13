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
                }
                field("Record SystemId"; Rec."Record SystemId")
                {
                    ApplicationArea = All;
                }
                field("Related Record SystemId"; Rec."Related Record SystemId")
                {
                    ApplicationArea = All;
                }
                field("Comparison Length"; Rec."Comparison Length")
                {
                    ApplicationArea = All;
                }
                field("Distance"; Rec."Distance")
                {
                    ApplicationArea = All;
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
        }
    }
}