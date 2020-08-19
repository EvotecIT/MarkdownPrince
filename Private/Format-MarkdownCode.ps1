function Format-MarkdownCode {
    [cmdletBinding()]
    param(
        [string] $ContentMarkdown
    )
    $SplitOverNewLines = $ContentMarkdown -split [Environment]::Newline
    $MyData = [System.Text.StringBuilder]::new()
    $FirstCodeTag = $false
    foreach ($N in $SplitOverNewLines) {
        if ($N.Trim()) {
            if ($N.Trim() -match '```') {
                if ($FirstCodeTag -eq $true) {
                    # this means we found closing tag so we need to add new line after
                    $null = $MyData.AppendLine($N)
                    $null = $MyData.AppendLine()
                } else {
                    # this means we found opening tag so we need to add new line before
                    $FirstCodeTag = $true
                    $null = $MyData.AppendLine()
                    $null = $MyData.AppendLine($N)
                }
            } else {
                $null = $MyData.AppendLine($N.TrimEnd())
            }
        }
    }
    $MyData.ToString().Trim()
}