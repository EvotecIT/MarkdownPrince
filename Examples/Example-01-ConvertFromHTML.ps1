Import-Module $PSScriptRoot\..\MarkdownPrince.psd1 -Force -Verbose

$HTMLFile = "$PSScriptRoot\Input\Example01.html"

ConvertFrom-HTMLToMarkdown -Path $HTMLFile -UnknownTags Drop -GithubFlavored -DestinationPath $PSScriptRoot\Output\Example01.md