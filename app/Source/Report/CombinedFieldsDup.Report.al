report 63000 "Combined Fields Dup. BC365D"
{
    Caption = 'Combined Fields Duplication Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = CombinedFieldsDuplicationReport;


    dataset
    {
        dataitem(SourceData; "Source Data BC365D")
        {
            DataItemTableView = where("Match Count" = filter(> 0));

            column(tableId; SourceData."Table ID") { }
            column(combinedFieldData; SourceData."Combined Field Data") { }

            dataitem(SourceDataMatches; "Source Data Matches BC365D")
            {
                DataItemLinkReference = SourceData;
                DataItemLink = "Table ID" = field("Table ID"), "Record SystemId" = field("Record SystemId");
                column(sourceRecordId; Format(SourceDataMatches."Source Record Id")) { }
                column(relatedRecordId; Format(SourceDataMatches."Related Record Id")) { }

                dataitem(SourceDataRelated; "Source Data BC365D")
                {
                    DataItemLinkReference = SourceDataMatches;
                    DataItemLink = "Table ID" = field("Table ID"), "Record SystemId" = field("Related Record SystemId");
                    DataItemTableView = sorting("Table ID", "Record SystemId");

                    column(relatedRecordCombinedFieldData; SourceDataRelated."Combined Field Data") { }
                }
            }
        }
    }

    rendering
    {
        layout(CombinedFieldsDuplicationReport)
        {
            Type = Excel;
            LayoutFile = 'Source/Report/CombinedFieldsDuplicationReport.xlsx';
            Caption = 'Combined Fields Duplication Report Excel';
            Summary = 'Built in layout for Combined Fields Duplication Report.';
        }
    }
}