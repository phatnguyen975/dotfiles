[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

Import-Module -Name Terminal-Icons

$ENV:STARSHIP_CONFIG = "$HOME\dotfiles\.config\starship\starship.toml"
$ENV:STARSHIP_CACHE = "$HOME\AppData\Local\Temp"
Invoke-Expression (&starship init powershell)
