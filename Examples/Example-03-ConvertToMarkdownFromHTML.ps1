Import-Module $PSScriptRoot\..\MarkdownPrince.psd1 -Force

$InputFile = "$PSScriptRoot\Input\Example03.md"
$OutputFile = "$PSScriptRoot\Output\Example03.html"

ConvertTo-HTMLFromMarkdown -Path $InputFile -DestinationPath $OutputFile








return



$pipelineBuilder = [Markdig.MarkDownExtensions]::Configure($pipelineBuilder, 'common').Build()

[Markdig.Markdown]::ToHtml($HTML, $pipelineBuilder)

return

$Pipeline = [Markdig.MarkdownPipelineBuilder]::new().Extensions('')
$Pipeline. #MarkdownPipelineBuilder().UseAdvancedExtensions().Build();
[Markdig.Markdown]::ToHtml($HTML, $Pipeline)