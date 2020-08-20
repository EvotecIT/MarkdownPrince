function Format-MarkdownCode {
    [cmdletBinding()]
    param(
        [string] $ContentMarkdown
    )
    $SplitOverNewLines = $ContentMarkdown -split [Environment]::Newline
    $MyData = [System.Text.StringBuilder]::new()
    $EmptyLineLast = $false
    $InsideCodeBlock = $false
    foreach ($N in $SplitOverNewLines) {
        $TrimmedLine = $N.Trim()
        if ($TrimmedLine) {
            if ($TrimmedLine -match '```') {
                if ($InsideCodeBlock -eq $true) {
                    # this means we found closing tag so we need to add new line after
                    $null = $MyData.AppendLine($N)
                    $null = $MyData.AppendLine()
                    $InsideCodeBlock = $false
                    $EmptyLineLast = $true
                } else {
                    # this means we found opening tag so we need to add new line before
                    $InsideCodeBlock = $true
                    if ($EmptyLineLast) {

                    } else {
                        $null = $MyData.AppendLine()
                    }
                    $null = $MyData.AppendLine($N)
                    $EmptyLineLast = $false
                }
            } elseif (($TrimmedLine.StartsWith('#') -or $TrimmedLine.StartsWith('![]'))) {
                if ($InsideCodeBlock) {
                    # we're inside of code block. we put things without new lines
                    $null = $MyData.AppendLine($N.TrimEnd())
                    $EmptyLineLast = $false
                } else {
                    if ($EmptyLineLast) {

                    } else {
                        $null = $MyData.AppendLine()
                    }
                    $null = $MyData.AppendLine($N.TrimEnd())
                    $null = $MyData.AppendLine()
                    $EmptyLineLast = $true
                }
            } else {
                if ($InsideCodeBlock) {
                    # we're inside of code block. we put things without new lines
                    $null = $MyData.AppendLine($N.TrimEnd())
                    $EmptyLineLast = $false
                } else {
                    $null = $MyData.AppendLine($N.TrimEnd())
                    $null = $MyData.AppendLine()
                    $EmptyLineLast = $true
                }
            }
        }
    }
    $MyData.ToString().Trim()
}