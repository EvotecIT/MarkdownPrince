Import-Module $PSScriptRoot\..\MarkdownPrince.psd1 -Force

# Define file to load
$HTMLFile = "$PSScriptRoot\Input\Example01.html"

# Let me build small HTML to show it using PSWriteHTML
# Install-Module PSWriteHTML
New-HTML {
    New-HTMLText -Text 'This is some text'
    New-HTMLText -Text 'This is some other text'
    New-HTMLTable -DataTable (Get-Process | Select-Object -First 5 -Property 'Id', 'Handles', 'CPU', 'SI', 'Name')
    New-HTMLText -Text 'This is some other text continuing'
    New-HTMLText -Text 'This is some other text'
} -FilePath "$PSScriptRoot\Input\Example01.html"


ConvertFrom-HTMLToMarkdown -Path $HTMLFile -UnknownTags Drop -GithubFlavored -DestinationPath $PSScriptRoot\Output\Example01.md