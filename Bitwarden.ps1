function Unlock-Bitwarden([pscredential] $cred) {
    $unlocked = bw unlock --check *> $null && $true
    if ($unlocked) { return }
    $logined = bw login --check *> $null && $true
    $env:BW_SESSION = switch ($null) {
        { $logined -and $cred } { bw unlock (ConvertFrom-SecureString $cred.Password -AsPlainText) --raw }
        { $logined } { bw unlock --raw }
        { $cred } { 
            bw login $cred.UserName (ConvertFrom-SecureString $cred.Password -AsPlainText) --code $cred.OTP --raw
        }
        default { bw login --raw }
    }
}