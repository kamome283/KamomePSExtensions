# Currently, I do not take into account missing values ​​in records.
function local:getValue($function, $record) {
    $command = Get-Command $function
    $params = $command.Parameters.Values # Assume parameters ​values ​are ordered by the script block argument order
    $values = $params | ForEach-Object { $record[$_.Name] }
    
    $command.ScriptBlock.Invoke($values)
}

function Get-Value($function) {
    foreach ($record in $input) {
        getValue $function $record
    }
}

# function myAdd([int]$left, [int]$right) { $left + $right }
# $records = @{left = 10; right = 15 }, @{left = 20; right = 32 } 
# $records | Get-Value myAdd
# 25, 52
