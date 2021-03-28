Describe 'ConvertFrom-HTMLToMarkdown ' {
    It 'Given HTML it should output Markdown' {
        # Define file to load
        $HTML = New-HTML {
            New-HTMLText -Text 'This is a text in HTML'
        }
        # Convert it
        $Output = ConvertFrom-HTMLToMarkdown -Content $HTML -UnknownTags Drop -GithubFlavored
        $Output | Should -BeLike '*This is a text in HTML*'
    }
}