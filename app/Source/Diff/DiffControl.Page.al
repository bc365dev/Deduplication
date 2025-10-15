page 63006 "Diff Control BC365D"
{
    PageType = UserControlHost;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            usercontrol(HighlightDifferences; "HighlightDifferences BC365D")
            {
                ApplicationArea = All;

                trigger ControlReady()
                begin
                    CurrPage.HighlightDifferences.generateDiff('ADATUMCORPORATIONSTATIONROAD21CB12FB', 'ADATUMCORPORATIONLTDSTATIONROAD22CB12FB');
                end;

            }
        }
    }
}