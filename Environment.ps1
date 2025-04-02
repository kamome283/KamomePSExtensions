. (Join-Path $PSScriptRoot Bitwarden.ps1)

$local:ENV_NOT_SET = 'xxx'

function local:checkUserEnvironmentVariable([string] $key) {
    $value = [System.Environment]::GetEnvironmentVariable($key, [System.EnvironmentVariableTarget]::User)
    $value -and ($value -notin '', $ENV_NOT_SET)
}

# Set a user environment variable using Bitwarden CLI
function local:setUserEnvironmentVariable([string] $key, [string] $note = $null) {
    Unlock-Bitwarden
    $value = bw get notes ($note ?? $key)
    [System.Environment]::SetEnvironmentVariable($key, $value, [System.EnvironmentVariableTarget]::User)
}

function checkAndSetUserEnvironmentVariable([string] $key, [string] $note = $null) {
    if (-not (checkUserEnvironmentVariable $key)) {
        setUserEnvironmentVariable $key $note
    }
}