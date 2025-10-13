permissionset 63003 "Dedupe. Edit BC365D"
{
    Caption = 'Deduplication Edit BC365D';
    Assignable = true;
    IncludedPermissionSets = "Dedupe. Read BC365D";
    Permissions = tabledata "Dedupe Engine Entry BC365D" = IMD,
        tabledata "Deduplication Setup BC365D" = IMD,
        tabledata "Engine Entry Field BC365D" = IMD,
        tabledata "Source Data BC365D" = IMD,
        tabledata "Source Data Matches BC365D" = IMD;
}