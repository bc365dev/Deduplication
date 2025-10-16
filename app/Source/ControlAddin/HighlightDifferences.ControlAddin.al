controladdin "HighlightDifferences BC365D"
{
    RequestedHeight = 200;
    VerticalStretch = true;
    HorizontalStretch = true;

    StartupScript = '.\Source\ControlAddin\JavaScript\HighlightDifferences.js';
    StyleSheets = '.\Source\ControlAddin\css\styles.css';

    event ControlAddInReady();

    /// <summary>
    /// Displays the source data using the control add-in with diff highlighting.
    /// </summary>
    /// <param name="DataObject">The JSON object containing source and related data.</param>
    procedure ShowSourceData(DataObject: JsonObject);
}