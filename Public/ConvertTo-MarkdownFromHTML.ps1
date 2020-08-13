function ConvertTo-MarkdownFromHTML {
    [cmdletBinding()]
    param(
        [string] $Path,
        [string] $DestinationPath
    )
    $HTML = Get-Content -Path $Path

    [Markdig.MarkdownPipelineBuilder] $PipelineBuilder = [Markdig.MarkdownPipelineBuilder]::new()
    #$pipelineBuilder = [Markdig.MarkDownExtensions]::UseAdvancedExtensions($pipelineBuilder)
    $PipelineBuilder.Extensions.Count
    $PipelineBuilder = [Markdig.MarkDownExtensions]::UsePipeTables($pipelineBuilder)
    $PipelineBuilder.Extensions.Count
    $Pipeline = $PipelineBuilder.Build()
    [Markdig.Markdown]::ToHtml($HTML, $Pipeline) | Out-File -FilePath $DestinationPath
}