# Set-Model m [string]name buy [int],sell
function Set-Model() {
    param(
        [Parameter(Mandatory=$true)] [string] $ModelName,
        [Parameter(ValueFromRemainingArguments=$true)] [object[]] $Fields
    ) { }
}

function local:normalize([Parameter(ValueFromPipeline)] $field) { process { $field.Count -eq 1 ? (replace $field) : $field } }
function local:replace([Parameter(ValueFromPipeline)] [string] $field) { process { $field -match '\[(.+)\]\s*(\S+)' ? @(($Matches.Item(1) -as [type]), $Matches.Item(2)) :  @([object], $field) } }