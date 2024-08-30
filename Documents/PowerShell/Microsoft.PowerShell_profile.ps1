if (Get-Command "starship" -ErrorAction SilentlyContinue) {
    Invoke-Expression (&starship init powershell)
} else {
    function prompt {"$PWD`n> "}
}

function which($name) {
    Get-Command $name | Select-Object -ExpandProperty Definition
}

# Override cd
# cd is aliased to Set-Location by default
if (Get-Alias -name cd -ErrorAction SilentlyContinue) {
    Remove-Alias cd
}

function cd($name) {
    Set-Location $name
    if (Test-Path ".envrc.ps1") {
        echo "Detected .envrc.ps1. Executing it now..."
        . .\.envrc.ps1
    }
}

function cdf($name) {
    if (Get-Command "fzf" -ErrorAction SilentlyContinue) {
        $repo_dir = Get-ChildItem -Path "$env:USERPROFILE\dev" -Force  -Recurse -Directory -Depth 4 -Filter ".git" | ForEach-Object { $_.Parent.Fullname } | fzf
        cd $repo_dir
    } else {
        echo "ERROR: fzf not found"
    }
}


function tail($filename) {
    Get-Content $filename -Wait -Tail 30
}

function wsl-shutdown() {
    wsl --shutdown --system
}

# Environment variables
$env:EDITOR="nvim"
$env:XDG_CONFIG_HOME = "${HOME}\.config"
$env:XDG_DATA_HOME = "${HOME}\.local\share"
$env:XDG_STATE_HOME = "${HOME}\.local\state"
$env:XDG_CACHE_HOME = "${HOME}\.cache"

# Aliases
Set-Alias -Name vim -Value nvim
Set-Alias -Name open -Value Start-Process

# Load local config
$local_config_file = Join-Path -Path $PSScriptRoot -ChildPath "local.ps1"

if (Test-Path $local_config_file) {
    Write-Output "Loading ${local_config_file}"
    . $local_config_file
    if (Test-Path ".envrc.ps1") {
        echo "Detected .envrc.ps1. Executing it now..."
        . .\.envrc.ps1
    }
}

# Color groups:
# - Command
# - Comment
# - ContinuationPrompt
# - Default
# - Emphasis
# - Error
# - InlinePrediction
# - Keyword
# - ListPrediction
# - ListPredictionSelected
# - ListPredictionTooltip
# - Member
# - Number
# - Operator
# - Parameter
# - Selection
# - String
# - Type
# - Variable
Set-PSReadLineOption -Colors @{ InlinePrediction = '#A0A0A0' }
Set-PSReadLineOption -Colors @{ Parameter = '#404040' }
Set-PSReadLineOption -Colors @{ Command = '#006400' }

Set-PSReadLineKeyHandler -Chord "Ctrl+y" -Function ForwardWord
