/// <summary>
/// Table that holds the setup configuration for customer deduplication functionality.
/// </summary>
table 63000 "Deduplication Setup BC365D"
{
    Caption = 'Deduplication Setup';
    Description = 'Table for Deduplication Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            ToolTip = 'Primary Key for the Deduplication Setup table.';
        }
        field(2; "Threshold"; Integer)
        {
            Caption = 'Threshold';
            ToolTip = 'Threshold value for deduplication matching.';
            InitValue = 5;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    /// <summary>
    /// Gets the support setup record, creating it if it doesn't exist.
    /// </summary>
    procedure GetSetup()
    begin
        if not Get() then begin
            Init();
            "Primary Key" := '';
            Insert();
        end;
    end;
}