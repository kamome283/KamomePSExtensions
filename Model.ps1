# Set-Model m [string]name buy [int]sell
function Set-Model(
    [Parameter(Mandatory = $true)] [string] $ModelName, 
    [Parameter(ValueFromRemainingArguments = $true)] [object[]] $Fields) {
    try {
        [pscustomobject]@{
            ModelName = $ModelName
            Fields    = 
            $Fields 
            | assoc
            | assert
        }
    } catch [System.ArgumentException] {
        # 改善の余地あり
        Write-Error -Category InvalidArgument $_
    }
}
Set-Alias model Set-Model
model simple [string]name
model complex [string]name buy [int]sell
model invalid [fsdfd]name
model complex2 [string]name buy [int]sell

filter local:assoc { 
    $_ -match '\[(.+)\]\s*(\S+)' ? 
    [pscustomobject]@{type = $Matches.Item(1) -as [type]; name = $Matches.Item(2) } :
    [pscustomobject]@{type = [object]; name = $_ } 
}
'[string]name' | assoc
'buy' | assoc

filter local:assert {
    $type, $name = $_.type, $_.name
    if ($type -isnot [type]) { throw [System.ArgumentException] "invalid field type specification: $_" }
    if ($name -isnot [string]) { throw [System.ArgumentException] "invalid field name specification: $_" }
    $_
}
'[string]name' | assoc | assert
'buy' | assoc | assert
'[string]1' | assoc |assert
'[fsdfsd]name' | assoc | assert
