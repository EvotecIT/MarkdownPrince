function ConvertFrom-HTMLToMarkdown {
    <#
    .SYNOPSIS
    Converts HTML to Markdown file

    .DESCRIPTION
    Converts HTML to Markdown file.
    Supports all the established html tags like h1, h2, h3, h4, h5, h6, p, em, strong, i, b, blockquote, code, img, a, hr, li, ol, ul, table, tr, th, td, br
    Can deal with nested lists.
    Github Flavoured Markdown conversion supported for br, pre and table.

    .PARAMETER Path
    Path to HTML file

    .PARAMETER DestinationPath
    Path where to save Markdown file

    .PARAMETER UnknownTags
    PassThrough - Include the unknown tag completely into the result. That is, the tag along with the text will be left in output. This is the default
    Drop - Drop the unknown tag and its content
    Bypass - Ignore the unknown tag but try to convert its content
    Raise - Raise an error to let you know

    .PARAMETER ListBulletChar
    Allows to change the bullet character. Default value is -. Some systems expect the bullet character to be * rather than -, this config allows to change it.

    .PARAMETER WhitelistUriSchemes
    Specify which schemes (without trailing colon) are to be allowed for <a> and <img> tags. Others will be bypassed (output text or nothing). By default allows everything.
    If string.Empty provided and when href or src schema coudn't be determined - whitelists
    Schema is determined by Uri class, with exception when url begins with / (file schema) and // (http schema)

    .PARAMETER TableWithoutHeaderRowHandling
    Default - First row will be used as header row (default)
    EmptyRow - An empty row will be added as the header row

    .PARAMETER RemoveComments
    Remove comment tags with text. Default is false

    .PARAMETER SmartHrefHandling
    false - Outputs [{name}]({href}{title}) even if name and href is identical. This is the default option.
    true - If name and href equals, outputs just the name. Note that if Uri is not well formed as per Uri.IsWellFormedUriString (i.e string is not correctly escaped like http://example.com/path/file name.docx) then markdown syntax will be used anyway.
    If href contains http/https protocol, and name doesn't but otherwise are the same, output href only
    If tel: or mailto: scheme, but afterwards identical with name, output name only.

    .PARAMETER GithubFlavored
    Github style markdown for br, pre and table. Default is false

    .EXAMPLE
    ConvertFrom-HTMLToMarkdown -Path  "$PSScriptRoot\Input\Example01.html" -UnknownTags Drop -GithubFlavored -DestinationPath $PSScriptRoot\Output\Example01.md

    .NOTES
    General notes
    #>
    [cmdletBinding()]
    param(
        [Parameter(Mandatory)][string] $Path,
        [Parameter(Mandatory)][string] $DestinationPath,
        [ReverseMarkdown.Config+UnknownTagsOption] $UnknownTags,
        [ValidateSet('-', '*')][string] $ListBulletChar,
        [string] $WhitelistUriSchemes,
        [ReverseMarkdown.Config+TableWithoutHeaderRowHandlingOption] $TableWithoutHeaderRowHandling,
        [switch] $RemoveComments,
        [switch] $SmartHrefHandling,
        [switch] $GithubFlavored
    )
    if ($Path -and (Test-Path -Path $Path)) {
        $Content = Get-Content -Path $Path

        $Converter = [ReverseMarkdown.Converter]::new()
        if ($PSBoundParameters.ContainsKey('UnknownTags')) {
            $Converter.Config.UnknownTags = $UnknownTags
        }
        if ($GithubFlavored.IsPresent) {
            $Converter.Config.GithubFlavored = $GithubFlavored.IsPresent
        }
        if ($PSBoundParameters.ContainsKey('ListBulletChar')) {
            $Converter.Config.ListBulletChar = $ListBulletChar
        }
        if ($PSBoundParameters.ContainsKey('ListBulletChar')) {
            $Converter.Config.ListBulletChar = $ListBulletChar
        }
        if ($RemoveComments.IsPresent) {
            $Converter.Config.RemoveComments = $RemoveComments.IsPresent
        }
        if ($PSBoundParameters.ContainsKey('TableWithoutHeaderRowHandling')) {
            $Converter.Config.TableWithoutHeaderRowHandling = $TableWithoutHeaderRowHandling
        }
        if ($SmartHrefHandling.IsPresent) {
            $Converter.Config.SmartHrefHandling = $SmartHrefHandling.IsPresent
        }
        $ContentMD = $Converter.Convert($Content)
        $ContentMD | Out-File -FilePath $DestinationPath
    }
}