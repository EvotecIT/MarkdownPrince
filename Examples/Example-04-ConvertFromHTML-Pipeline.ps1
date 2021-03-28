#Import-Module .\PSParseHTML.psd1 -Force
Import-Module $PSScriptRoot\..\MarkdownPrince.psd1 -Force
Import-Module 'C:\Support\GitHub\PSParseHTML\PSParseHTML.psd1' -Force

$Path = 'C:\Support\GitHub\TechnetGalleryArchive\Categories\Printing\Client-Side Printing\b7f74333-e78b-49d8-b23a-f1307d5b1ee6\Sources\PageProject.html'
$content = Get-Content -Path $Path


#(ConvertFrom-HTMLAttributes -id 'LastUpdated' -Content $content).Trim()
#(ConvertFrom-HTMLAttributes -id 'Tags' -Content $content).Trim() -join ','
#(ConvertFrom-HTMLAttributes -id 'License' -Content $content).Trim()

$Table = ([regex]::Match($Content, '<table(.*?)\</table>')).Value
$Table | ConvertFrom-HTMLToMarkdown -GithubFlavored