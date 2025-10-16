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

    /// <summary>
    /// Sets the data object for the diff control.
    /// </summary>
    /// <param name="NewDataObject">The new JSON object to set.</param>
    procedure SetDataObject(NewDataObject: JsonObject)
    begin
        DataObject := NewDataObject;
    end;
}