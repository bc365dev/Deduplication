/// <summary>
/// List part page for displaying engine entry fields, suitable for use as a factbox in other pages.
/// </summary>
page 63005 "Engine Field ListPart BC365D"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "Engine Entry Field BC365D";
    Caption = 'Engine Entry Fields';

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
                }
                field("Table Caption"; Rec."Table Caption")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Field ID"; Rec."Field ID")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Field Caption"; Rec."Field Caption")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}