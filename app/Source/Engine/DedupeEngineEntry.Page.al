/// <summary>
/// List page for managing deduplication engine entries configuration.
/// </summary>
page 63001 "Dedupe Engine Entry BC365D"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Dedupe Engine Entry BC365D";
    Caption = 'Deduplication Engine Entry';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Table ID"; Rec."Table ID")
                {
                    Visible = false;
                }
                field("Table Caption"; Rec."Table Caption") { }
                field("Engine Type"; Rec."Engine Type") { }
                field("Loaded Source Records"; Rec."Loaded Source Records") { }
            }
        }

        area(factboxes)
        {
            part("EngineFields"; "Engine Field ListPart BC365D")
            {
                ApplicationArea = All;
                SubPageLink = "Table ID" = FIELD("Table ID");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(LoadSourceData)
            {
                Caption = 'Load Source Data';
                ApplicationArea = All;
                Image = Import;
                ToolTip = 'Load source data for the selected table using its deduplication engine.';
                Enabled = Rec."Table ID" <> 0;

                /// <summary>
                /// Loads source data for the selected table using its deduplication engine.
                /// </summary>
                trigger OnAction()
                begin
                    if Rec.LoadSourceData() then
                        Message('Source data loaded for table ID %1 using engine type %2.', Rec."Table ID", Rec."Engine Type");
                end;
            }
        }

        area(navigation)
        {
            action(GoToEngineEntryFields)
            {
                Caption = 'Engine Entry Fields';
                ApplicationArea = All;
                Image = RelatedInformation;
                ToolTip = 'Navigate to the Engine Entry Fields page to manage fields used in deduplication.';

                /// <summary>
                /// Opens the Engine Entry Fields page filtered to the current table.
                /// </summary>
                trigger OnAction()
                var
                    EngineEntryField: Record "Engine Entry Field BC365D";
                    EngineEntryFieldPage: Page "Engine Entry Field BC365D";
                begin
                    EngineEntryField.FilterGroup(2);
                    EngineEntryField.SetRange("Table ID", Rec."Table ID");
                    EngineEntryField.FilterGroup(0);

                    EngineEntryFieldPage.SetTableView(EngineEntryField);
                    EngineEntryFieldPage.Run();
                end;
            }

            action(GoToSourceData)
            {
                Caption = 'Source Data';
                ApplicationArea = All;
                Image = View;
                ToolTip = 'Navigate to the Source Data page to view deduplication source data entries.';

                /// <summary>
                /// Opens the Source Data page filtered to the current table.
                /// </summary>
                trigger OnAction()
                var
                    SourceData: Record "Source Data BC365D";
                    SourceDataPage: Page "Source Data BC365D";
                begin
                    SourceData.FilterGroup(2);
                    SourceData.SetRange("Table ID", Rec."Table ID");
                    SourceData.FilterGroup(0);

                    SourceDataPage.SetTableView(SourceData);
                    SourceDataPage.Run();
                end;
            }
        }
    }
}