# Currently, I do not take into account missing values ​​in records.
function Get-Value($f) {
    foreach ($r in $input) {
        $command = Get-Command $f
        $params = $command.Parameters.Values # Assume parameters ​values ​are ordered by the script block argument order
        $values = $params | ForEach-Object { $r[$_.Name] }
        
        $command.ScriptBlock.Invoke($values)
    }
}

# function myAdd([int]$left, [int]$right) { $left + $right }
# $records = @{left = 10; right = 15 }, @{left = 20; right = 32 } 
# $records | Get-Value myAdd
# 25, 52
