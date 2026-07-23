oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/robbyrussell.omp.json" | Invoke-Expression

Set-PSReadLineOption -EditMode Vi
Set-PSReadLineOption -PredictionViewStyle ListView

# ---- ADD LINUX/EMACS SHORTCUTS TO VI INSERT MODE ----
# History navigation (Ctrl+P and Ctrl+N)
Set-PSReadLineKeyHandler -Chord 'Ctrl+p' -ViMode Insert -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Chord 'Ctrl+n' -ViMode Insert -Function HistorySearchForward

# Reverse interactive history search (Ctrl+R)
Set-PSReadLineKeyHandler -Chord 'Ctrl+r' -ViMode Insert -Function ReverseSearchHistory

# Word skipping (Alt+B and Alt+F)
Set-PSReadLineKeyHandler -Chord 'Alt+b' -ViMode Insert -Function BackwardWord
Set-PSReadLineKeyHandler -Chord 'Alt+f' -ViMode Insert -Function NextWord

# Character shifting (Ctrl+B and Ctrl+F)
Set-PSReadLineKeyHandler -Chord 'Ctrl+b' -ViMode Insert -Function BackwardChar
Set-PSReadLineKeyHandler -Chord 'Ctrl+f' -ViMode Insert -Function ForwardChar

# Line ends (Ctrl+A and Ctrl+E)
Set-PSReadLineKeyHandler -Chord 'Ctrl+a' -ViMode Insert -Function BeginningOfLine
Set-PSReadLineKeyHandler -Chord 'Ctrl+e' -ViMode Insert -Function EndOfLine

# Delete the word behind the cursor (Linux default)
Set-PSReadLineKeyHandler -Chord 'Ctrl+w' -ViMode Insert -Function BackwardKillWord

# Delete the word in front of the cursor
Set-PSReadLineKeyHandler -Chord 'Alt+d' -ViMode Insert -Function KillWord

# Delete everything from the cursor to the end of the line
Set-PSReadLineKeyHandler -Chord 'Ctrl+k' -ViMode Insert -Function KillLine

# Delete everything from the cursor back to the start of the line
Set-PSReadLineKeyHandler -Chord 'Ctrl+u' -ViMode Insert -Function BackwardKillLine

# Delete the single character behind the cursor (Backspace alternative)
Set-PSReadLineKeyHandler -Chord 'Ctrl+h' -ViMode Insert -Function BackwardDeleteChar

# Delete the single character under the cursor (Delete alternative)
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -ViMode Insert -Function DeleteChar
# ---- end of the config ----

# Import PSFzf and bind Ctrl+R
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordReverseHistory 'Ctrl+r'

# Custom Styling for the FZF History List View
$env:FZF_CTRL_R_OPTS = @'
--reverse
--height=45%
--border=sharp
--header="[ 📜 HISTORY LIST ]"
--prompt="🔍 Search: "
'@

Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler {
    param([Microsoft.PowerShell.ViMode]$Mode)
    if ($Mode -eq 'Command') {
        # Normal Mode: Thick Block
        Write-Host "`e[1 q" -NoNewLine
    } else {
        # Insert Mode: Thin Bar
        Write-Host "`e[5 q" -NoNewLine
    }
}

# Force default state to Insert Mode on startup
Write-Host "`e[5 q" -NoNewLine

#alias
Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })
function nvid {
    neovide @args
}
