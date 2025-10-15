controladdin "HighlightDifferences BC365D"
{
    RequestedHeight = 300;
    MinimumHeight = 300;
    MaximumHeight = 300;
    RequestedWidth = 700;
    MinimumWidth = 700;
    MaximumWidth = 700;
    VerticalStretch = true;
    VerticalShrink = true;
    HorizontalStretch = true;
    HorizontalShrink = true;
    Scripts =
        'JavaScript/difflib-browser.js',
        'JavaScript/main.js';
    StartupScript = 'JavaScript/startup.js';


    event ControlReady()

    procedure generateDiff(OldText: Text; NewText: Text);
}