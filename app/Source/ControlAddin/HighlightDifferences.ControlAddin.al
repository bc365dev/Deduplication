controladdin "HighlightDifferences BC365D"
{
    RequestedHeight = 200;
    VerticalStretch = true;
    HorizontalStretch = true;

    Scripts =
        '.\Source\ControlAddin\JavaScript\difflib-browser.js',
        '.\Source\ControlAddin\JavaScript\diffview.js';

    StartupScript = '.\Source\ControlAddin\JavaScript\startup.js';

    event ControlAddInReady();

    procedure ShowSourceData(DataObject: JsonObject);
}