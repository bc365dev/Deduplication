codeunit 63002 "Combined Fields Engine BC365D" implements "IEngine BC365D"
{
    var
        DeduplicationSetup: Record "Deduplication Setup BC365D";
        HaveSetup: Boolean;
        DataAlreadyExistsQst: Label 'Source data already exists for this table. Do you want to reload it? This will overwrite existing data.';
        MissingRecRefErr: Label 'Record with SystemId %1 not found in table %2.', Comment = '%1: SystemId, %2: Table ID';
        MissingSourceDataErr: Label 'Source data does not exist for record with SystemId %1 in table %2.', Comment = '%1: SystemId, %2: Table ID';

    procedure CalculateDuplication(TableId: Integer)
    var
        RecRef: RecordRef;
    begin
        RecRef.Open(TableId);
        RecRef.SetLoadFields(RecRef.SystemIdNo());
        if RecRef.FindSet() then
            repeat
                CalculateDuplicationForRecord(TableId, RecRef.Field(RecRef.SystemIdNo()).Value);
            until RecRef.Next() = 0;
        RecRef.Close();
    end;

    procedure CalculateDuplicationForRecord(TableId: Integer; SysId: Guid)
    var
        SourceData: Record "Source Data BC365D";
        SourceDataComparison: Record "Source Data BC365D";
        SourceDataUtilities: Codeunit "Source Data Utilities BC365D";
        TextUtilities: Codeunit "Text Utilities BC365D";
        RecRef: RecordRef;
        ComparisonLength: Integer;
        Threshold: Integer;
        Distance: Integer;
    begin
        GetDeduplicationSetup();

        Clear(RecRef);
        RecRef.Open(TableId);
        RecRef.SetLoadFields(RecRef.SystemIdNo());
        if not RecRef.GetBySystemId(SysId) then
            Error(MissingRecRefErr, SysId, TableId);
        RecRef.Close();

        if not SourceData.Get(TableId, SysId) then
            Error(MissingSourceDataErr, SysId, TableId);

        ComparisonLength := StrLen(SourceData."Combined Field Data");
        Threshold := ComparisonLength DIV DeduplicationSetup.Threshold;

        SourceDataComparison.SetRange("Table ID", TableId);
        SourceDataComparison.SetFilter("Record SystemId", '<>%1', SysId);
        if SourceDataComparison.FindSet() then
            repeat
                Distance := TextUtilities.TextDistance(SourceData."Combined Field Data", SourceDataComparison."Combined Field Data");
                if Distance <= Threshold then
                    SourceDataUtilities.CreateSourceDataMatch(TableId, SysId, SourceDataComparison."Record SystemId", ComparisonLength, Distance);
            until SourceDataComparison.Next() = 0;

    end;

    procedure LoadDataFromSource(TableId: Integer): Boolean
    var
        EngineEntryField: Record "Engine Entry Field BC365D";
        SourceDataUtilities: Codeunit "Source Data Utilities BC365D";
        ConfirmManagement: Codeunit "Confirm Management";
        TextUtilities: Codeunit "Text Utilities BC365D";
        RecRef: RecordRef;
        FldRef: FieldRef;
        CombinedFieldData: TextBuilder;
        FieldIds: List of [Integer];
        FldId: Integer;
        CaseOption: Option None,Upper,Lower;
        FldVar: Variant;
    begin
        if SourceDataUtilities.RecordsExist(TableId) then
            if not ConfirmManagement.GetResponseOrDefault(DataAlreadyExistsQst, true) then
                exit
            else
                SourceDataUtilities.DeleteExistingRecords(TableId);

        EngineEntryField.SetRange("Table ID", TableId);
        if not EngineEntryField.FindSet() then
            exit;

        RecRef.Open(TableId);

        repeat
            FieldIds.Add(EngineEntryField."Field ID");
            RecRef.AddLoadFields(EngineEntryField."Field ID");
        until EngineEntryField.Next() = 0;

        repeat
            CombinedFieldData.Clear();
            foreach FldId in FieldIds do begin
                FldRef := RecRef.Field(FldId);
                FldVar := FldRef.Value;
                Case FldRef.Type of
                    FldRef.Type::Text, FldRef.Type::Code:
                        CombinedFieldData.Append(Format(FldVar));
                end;
            end;

            if not IsNullGuid(RecRef.Field(RecRef.SystemIdNo()).Value) then
                SourceDataUtilities.CreateSourceDataEntry(TableId,
                    RecRef.Field(RecRef.SystemIdNo()).Value,
                    TextUtilities.RemoveSpecialCharacters(CombinedFieldData.ToText(), true, CaseOption::Upper));

        until RecRef.Next() = 0;

        RecRef.Close();

        exit(true);
    end;

    procedure LoadDataFromSourceRecord(TableId: Integer; SysId: Guid): Boolean
    begin
        // Implementation to load data for a specific record based on its SystemId
        exit(true);
    end;

    local procedure GetDeduplicationSetup()
    begin
        if not HaveSetup then begin
            DeduplicationSetup.GetSetup();
            HaveSetup := true;
        end;
    end;
}