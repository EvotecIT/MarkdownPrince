Import-Module $PSScriptRoot\..\MarkdownPrince.psd1 -Force

# Define file to load
$HTMLFile = "$PSScriptRoot\Input\Example01.html"
# Convert it
ConvertFrom-HTMLToMarkdown -Path $HTMLFile -UnknownTags Drop -GithubFlavored -DestinationPath $PSScriptRoot\Output\Example01.md