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
                field(Threshold; Rec.Threshold)
                {
                    Caption = 'Threshold';
                    ToolTip = 'Specifies the threshold for deduplication matching.';
                }
            }
        }
    }

    /// <summary>
    /// Triggered when the page is opened, ensures the setup record exists.
    /// </summary>
    trigger OnOpenPage()
    begin
        Rec.GetSetup();
    end;
}