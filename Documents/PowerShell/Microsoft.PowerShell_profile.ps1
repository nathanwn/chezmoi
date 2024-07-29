# if (Get-Command "oh-my-posh" -errorAction SilentlyContinue) {
#     # oh-my-posh init pwsh --config "$HOME\AppData\Local\Programs\oh-my-posh\themes\pure.omp.json" | Invoke-Expression
#     oh-my-posh init pwsh --config "$HOME\.config\oh-my-posh\config.yaml" | Invoke-Expression
#     oh-my-posh disable notice
# } else {
#     echo "oh-my-posh is not installed"
# }

function prompt {"$PWD`n> "}

function which($name) {
    Get-Command $name | Select-Object -ExpandProperty Definition
}

# Override cd
# cd is aliased to Set-Location by default
if (Get-Alias -name cd -errorAction SilentlyContinue) {
    Remove-Alias cd
}

function cd($name) {
    Set-Location $name
    if (Test-Path ".envrc.ps1") {
        echo "Detected .envrc.ps1. Executing it now..."
        .\.envrc.ps1
    }
}

function tail($filename) {
    Get-Content $filename -Wait -Tail 30
}

$env:EDITOR="nvim"
$env:XDG_CONFIG_HOME = "${HOME}\.config"
$env:XDG_DATA_HOME = "${HOME}\.local\share"
$env:XDG_STATE_HOME = "${HOME}\.local\state"
$env:XDG_CACHE_HOME = "${HOME}\.cache"

# Load local config
$local_config_file = Join-Path -Path $PSScriptRoot -ChildPath "local.ps1"

if (Test-Path $local_config_file) {
    Write-Output "Loading ${local_config_file}"
    . $local_config_file
}
