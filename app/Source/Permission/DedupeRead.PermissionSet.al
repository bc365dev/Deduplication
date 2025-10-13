permissionset 63002 "Dedupe. Read BC365D"
{
    Caption = 'Deduplication Read BC365D';
    Assignable = true;
    IncludedPermissionSets = "Dedupe. Obj BC365D";
    Permissions = tabledata "Dedupe Engine Entry BC365D" = R,
        tabledata "Deduplication Setup BC365D" = R,
        tabledata "Engine Entry Field BC365D" = R,
        tabledata "Source Data BC365D" = R,
        tabledata "Source Data Matches BC365D" = R;
}