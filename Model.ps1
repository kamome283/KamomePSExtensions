# set-model m string,name left right
# function m([string] $name, $left, $right) { @{name = $name; left = $left; right = $right }}
function local:test() { $args | % { echo "$($_.GetType())"} }
test [string]name buy [int]sell
test [string],name buy [int],sell
test [string],'name' [object],'buy' [int],'sell'

function local:replace($s) { $s -match '\[(.+)\]\s*(\S+)' ? ($Matches.Item(1) -as [type]), $Matches.Item(2) :  @([object], $s) }
function local:normalize($p) { $p.Count -eq 1 ? (replace $p) : $p }