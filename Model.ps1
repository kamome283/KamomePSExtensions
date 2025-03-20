# Set-Model m [string]name buy [int],sell
function Set-Model() {
    param(
        [Parameter(Mandatory=$true)] [string] $ModelName,
        [Parameter(ValueFromRemainingArguments=$true)] [object[]] $Fields
    ) { }
}

function local:replace($s) { $s -match '\[(.+)\]\s*(\S+)' ? ($Matches.Item(1) -as [type]), $Matches.Item(2) :  @([object], $s) }
function local:normalize($p) { $p.Count -eq 1 ? (replace $p) : $p }