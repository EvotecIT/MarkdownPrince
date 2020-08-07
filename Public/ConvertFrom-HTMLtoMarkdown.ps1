function ConvertFrom-HTMLToMarkdown {
    [cmdletBinding()]
    param(
        [Parameter(Mandatory)][string] $Path,
        [Parameter(Mandatory)][string] $DestinationPath,
        [ReverseMarkdown.Config+UnknownTagsOption] $UnknownTags = [ReverseMarkdown.Config+UnknownTagsOption]::Drop,
        [switch] $GithubFlavored
    )
    if ($Path -and (Test-Path -Path $Path)) {
        $Content = Get-Content -Path $Path

        $Converter = [ReverseMarkdown.Converter]::new()
        $Converter.Config.UnknownTags = $UnknownTags
        $Converter.Config.GithubFlavored = $GithubFlavored.IsPresent
        $ContentMD = $Converter.Convert($Content)
        $ContentMD | Out-File -FilePath $DestinationPath
    }
}