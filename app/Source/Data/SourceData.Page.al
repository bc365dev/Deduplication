/// <summary>
/// List page for viewing source data entries used in deduplication.
/// </summary>
page 63003 "Source Data BC365D"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Source Data BC365D";
    Caption = 'Source Data';
    Editable = false;

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
                field("Combined Field Data"; Rec."Combined Field Data")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(CalculateDuplicates)
            {
                Caption = 'Calculate Duplicates';
                ApplicationArea = All;
                Image = Refresh;
                ToolTip = 'Calculate duplicates for the selected source data entry using the associated deduplication engine.';

                /// <summary>
                /// Calculates duplicates for the selected source data entry.
                /// </summary>
                trigger OnAction()
                begin
                    Rec.CalculateDuplicates();
                end;
            }
        }
        area(Navigation)
        {
            action(ShowSourceRecord)
            {
                Caption = 'Show Source Record';
                ApplicationArea = All;
                Image = View;
                ToolTip = 'View the original source record for the selected source data entry.';

                /// <summary>
                /// Opens the page for the source record.
                /// </summary>
                trigger OnAction()
                begin
                    Rec.ShowSourceRecord();
                end;
            }
            action(ShowMatches)
            {
                Caption = 'Show Matches';
                ApplicationArea = All;
                Image = View;
                ToolTip = 'View matches for the selected source data entry.';

                /// <summary>
                /// Opens the page showing matches for the selected source data entry.
                /// </summary>
                trigger OnAction()
                begin
                    Rec.ShowMatches();
                end;
            }
        }
    }
}