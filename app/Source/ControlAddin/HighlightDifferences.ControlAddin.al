controladdin "HighlightDifferences BC365D"
{
    RequestedHeight = 200;
    VerticalStretch = true;
    HorizontalStretch = true;

    StartupScript = '.\Source\ControlAddin\JavaScript\HighlightDifferences.js';
    StyleSheets = '.\Source\ControlAddin\css\styles.css';

    event ControlAddInReady();

    procedure ShowSourceData(DataObject: JsonObject);
}