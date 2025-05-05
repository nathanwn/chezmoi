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
        $repo_dir = Get-ChildItem -Path "${env:USERPROFILE}\dev" -Force  -Recurse -Directory -Depth 4 -Filter ".git" | ForEach-Object { $_.Parent.Fullname } | fzf
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

function wsl-start() {
    wt --window 0 new-tab --profile "Ubuntu-24.04"
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

# Set-PSReadLineOption -Colors @{ InlinePrediction = '#A0A0A0' }
# Set-PSReadLineOption -Colors @{ Parameter = '#404040' }
# Set-PSReadLineOption -Colors @{ Command = '#008000' }
# Set-PSReadLineOption -Colors @{ Member = '#404040' }
# Set-PSReadLineOption -Colors @{ Type = '#404040' }
# Set-PSReadLineOption -Colors @{ ContinuationPrompt = '#404040' }
# Set-PSReadLineOption -Colors @{ Default = '#404040' }

$LightTheme = @{
    Command                  = $PSStyle.Foreground.FromRGB(0x0000FF)
    Comment                  = $PSStyle.Foreground.FromRGB(0x006400)
    ContinuationPrompt       = $PSStyle.Foreground.FromRGB(0x0000FF)
    Default                  = $PSStyle.Foreground.FromRGB(0x0000FF)
    Emphasis                 = $PSStyle.Foreground.FromRGB(0x287BF0)
    Error                    = $PSStyle.Foreground.FromRGB(0xE50000)
    InlinePrediction         = $PSStyle.Foreground.FromRGB(0x93A1A1)
    Keyword                  = $PSStyle.Foreground.FromRGB(0x00008b)
    ListPrediction           = $PSStyle.Foreground.FromRGB(0x06DE00)
    Member                   = $PSStyle.Foreground.FromRGB(0x000000)
    Number                   = $PSStyle.Foreground.FromRGB(0x800080)
    Operator                 = $PSStyle.Foreground.FromRGB(0x757575)
    Parameter                = $PSStyle.Foreground.FromRGB(0x000080)
    String                   = $PSStyle.Foreground.FromRGB(0x8b0000)
    Type                     = $PSStyle.Foreground.FromRGB(0x008080)
    Variable                 = $PSStyle.Foreground.FromRGB(0xff4500)
    ListPredictionSelected   = $PSStyle.Background.FromRGB(0x93A1A1)
    Selection                = $PSStyle.Background.FromRGB(0x00BFFF)
}

# Monokai
$DarkTheme = @{
    Command                  = $PSStyle.Foreground.FromRGB(0xF92672)  # pink/red
    Comment                  = $PSStyle.Foreground.FromRGB(0x75715E)  # olive gray
    ContinuationPrompt       = $PSStyle.Foreground.FromRGB(0xA6E22E)  # green
    Default                  = $PSStyle.Foreground.FromRGB(0xF8F8F2)  # default white-ish
    Emphasis                 = $PSStyle.Foreground.FromRGB(0xFD971F)  # orange
    Error                    = $PSStyle.Foreground.FromRGB(0xFF5555)  # bright red
    InlinePrediction         = $PSStyle.Foreground.FromRGB(0x707070)  # subtle gray
    Keyword                  = $PSStyle.Foreground.FromRGB(0x66D9EF)  # cyan
    ListPrediction           = $PSStyle.Foreground.FromRGB(0xA6E22E)  # green
    Member                   = $PSStyle.Foreground.FromRGB(0xF8F8F2)  # white
    Number                   = $PSStyle.Foreground.FromRGB(0xAE81FF)  # purple
    Operator                 = $PSStyle.Foreground.FromRGB(0xF92672)  # pink/red
    Parameter                = $PSStyle.Foreground.FromRGB(0xFD971F)  # orange
    String                   = $PSStyle.Foreground.FromRGB(0xE6DB74)  # yellow
    Type                     = $PSStyle.Foreground.FromRGB(0x66D9EF)  # cyan
    Variable                 = $PSStyle.Foreground.FromRGB(0xF92672)  # pink/red
    ListPredictionSelected   = $PSStyle.Background.FromRGB(0x49483E)  # background highlight
    Selection                = $PSStyle.Background.FromRGB(0x75715E)  # gray highlight
}

# OneDark
$DarkTheme = @{
    Command                  = $PSStyle.Foreground.FromRGB(0x61AFEF)  # blue
    Comment                  = $PSStyle.Foreground.FromRGB(0x5C6370)  # comment gray
    ContinuationPrompt       = $PSStyle.Foreground.FromRGB(0x56B6C2)  # cyan
    Default                  = $PSStyle.Foreground.FromRGB(0xABB2BF)  # foreground
    Emphasis                 = $PSStyle.Foreground.FromRGB(0xD19A66)  # orange
    Error                    = $PSStyle.Foreground.FromRGB(0xE06C75)  # red
    InlinePrediction         = $PSStyle.Foreground.FromRGB(0x4B5263)  # faded comment-ish
    Keyword                  = $PSStyle.Foreground.FromRGB(0xC678DD)  # purple
    ListPrediction           = $PSStyle.Foreground.FromRGB(0x98C379)  # green
    Member                   = $PSStyle.Foreground.FromRGB(0xABB2BF)  # foreground
    Number                   = $PSStyle.Foreground.FromRGB(0xD19A66)  # orange
    Operator                 = $PSStyle.Foreground.FromRGB(0xABB2BF)  # foreground
    Parameter                = $PSStyle.Foreground.FromRGB(0x61AFEF)  # blue
    String                   = $PSStyle.Foreground.FromRGB(0x98C379)  # green
    Type                     = $PSStyle.Foreground.FromRGB(0x56B6C2)  # cyan
    Variable                 = $PSStyle.Foreground.FromRGB(0xE06C75)  # red
    ListPredictionSelected   = $PSStyle.Background.FromRGB(0x3E4451)  # selection
    Selection                = $PSStyle.Background.FromRGB(0x3E4451)  # selection
}
$PSStyle.FileInfo.Directory = "$($PSStyle.Foreground.FromRGB(0x61AFEF))$($PSStyle.Background.FromRGB(0x000000))"

# Set-PSReadLineOption -Colors $LightTheme
Set-PSReadLineOption -Colors $DarkTheme

Set-PSReadLineOption -EditMode Vi
Set-PSReadLineKeyHandler -Chord 'Ctrl+[' -Function ViCommandMode
Set-PSReadLineKeyHandler -Chord Ctrl-r -Function ReverseSearchHistory -ViMode Insert
Set-PSReadLineKeyHandler -Chord Ctrl-r -Function ReverseSearchHistory -ViMode Command

Set-PSReadLineKeyHandler -Chord "Ctrl+y" -Function ForwardWord

# Application settings
function komorebi_restart() {
    komorebic stop --whkd
    komorebic start --whkd
}
$env:KOMOREBI_CONFIG_HOME = "${env:USERPROFILE}\.config\komorebi"
