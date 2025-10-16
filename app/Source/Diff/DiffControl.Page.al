page 63006 "Diff Control BC365D"
{
    Caption = 'Data Differences';
    PageType = UserControlHost;
    ApplicationArea = All;
    UsageCategory = Administration;
    Editable = false;

    layout
    {
        area(content)
        {
            usercontrol(HighlightDifferences; "HighlightDifferences BC365D")
            {
                ApplicationArea = All;

                trigger ControlAddInReady()
                begin
                    CurrPage.HighlightDifferences.ShowSourceData(DataObject);
                end;

            }
        }
    }

    var
        DataObject: JsonObject;

    procedure SetDataObject(NewDataObject: JsonObject)
    begin
        DataObject := NewDataObject;
    end;
}