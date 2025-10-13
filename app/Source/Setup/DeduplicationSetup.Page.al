/// <summary>
/// Page Deduplication Setup (ID 63000).
/// Card page for configuring deduplication settings.
/// </summary>
page 63000 "Deduplication Setup BC365D"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Deduplication Setup BC365D";
    Caption = 'Deduplication Setup';
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Primary Key"; Rec."Primary Key")
                {
                    Visible = false;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.GetSetup();
    end;
}