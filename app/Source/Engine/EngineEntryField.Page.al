/// <summary>
/// List page for managing engine entry fields configuration.
/// </summary>
page 63002 "Engine Entry Field BC365D"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Engine Entry Field BC365D";
    Caption = 'Engine Entry Field';
    DelayedInsert = true;
    PopulateAllFields = true;

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
                field("Table Caption"; Rec."Table Caption")
                {
                    ApplicationArea = All;
                }
                field("Field ID"; Rec."Field ID")
                {
                    ApplicationArea = All;
                }
                field("Field Caption"; Rec."Field Caption")
                {
                    ApplicationArea = All;
                }
            }
        }

    }
}