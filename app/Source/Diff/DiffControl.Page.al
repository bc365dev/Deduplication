page 63006 "Diff Control BC365D"
{
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
                var
                    DataText: Text;
                begin
                    // Message('ControlAddInReady event fired!');
                    // CurrPage.HighlightDifferences.ShowSourceData(DataObject);
                    // DataObject.WriteTo(DataText);
                    // Message('%1', DataText);
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