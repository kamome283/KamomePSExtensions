function local:checkStatus {
    $unlocked = bw unlock --check *> $null && $true
    $logined = $unlocked -or (bw login --check *> $null && $true)
    return @{ logined = $logined; unlocked = $unlocked }
}

function Unlock-Bitwarden([pscredential] $cred) {
    $status = checkStatus
    if ($status.unlocked) { return }
    $logined = $status.logined
    $env:BW_SESSION = if ($logined -and $cred) {
        bw unlock (ConvertFrom-SecureString $cred.Password -AsPlainText) --raw 
    }
    elseif ($logined) { bw unlock --raw }
    elseif ($cred) {
        bw login $cred.UserName (ConvertFrom-SecureString $cred.Password -AsPlainText) --code $cred.OTP --raw
    }
    else { bw login --raw }
}

# 後々ほかのファイルに分離したい
function Get-CredentialWithOtp {
    Write-Host 'Enter your credentials and onetime password.'
    $user = Read-Host 'UserName'
    $password = Read-Host 'Password' -AsSecureString
    $cred = [pscredential]::new($user, $password)
    $otp = Read-Host 'Onetime Password'
    $cred | Add-Member OTP $otp -PassThru
}