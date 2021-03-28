Import-Module $PSScriptRoot\..\MarkdownPrince.psd1 -Force

# RSS
$RSSFeed = Get-RSSFeed -Url 'https://evotec.xyz/feed/' -Count 5
$RSSFeed | Format-Table
foreach ($RSS in $RSSFeed) {
    $BlogContent = Invoke-WebRequest -Uri $RSS.link
    $FileName = ("$($RSS.Title)").Replace('\', '_').Replace('/', '_')
    $FilePath = ("$PSScriptRoot\InputBlogs\$FileName.html")
    $BlogContent.Content | Out-File -FilePath $FilePath

    # Use PSParseHTML to format HTML so we can easier see what to remove, currently using it causes markdown to loose links to images
    #Format-HTML -File $FilePath -OutputFile $FilePath

    $RulesBefore = @(
        '(?ms)<div id="logo" class="clearfix">(.*?)<\/div>'
        '(?ms)<a class="pTitle clearfix" href="https://evotec.xyz/submitting-blogs-to-web-archive-org-using-powershell/">(.*?)<\/a>'
        '(?ms)<ul class="meta">(.*?)<\/ul>'
        '(?ms)<title>(.*?)<\/title>'
        '(?ms)<div class="left clearfix">(.*?)<\/div>'
        '(?ms)<div class="right clearfix">(.*?)<\/div>'
        '(?ms)<div id="icl_lang_sel_widget-3" class="widget sidebox widget_icl_lang_sel_widget">(.*?)<\/div>'
        '(?ms)<div id="pageTitle" class="clearfix">(.*?)<\/div>'
        '(?ms)<nav id="menu" class="cartfalse">(.*?)<\/nav>'
        '(?ms)<nav id="breadcrumb" itemprop="breadcrumb">(.*?)<\/nav>'
        '(?ms)<div class="wpml-ls-statics-footer wpml-ls wpml-ls-legacy-list-horizontal">(.*?)<\/div>'
        '(?ms)<div id="oldie">(.*?)<\/div>'
        '(?ms)<footer id="footer1" class="clearfix">(.*?)<\/footer>'
        '(?ms)<footer id="footer2" class="clearfix">(.*?)<\/footer>'
        # remove tags
        '(?ms)<span class="meta-holder">(.*)<\/span>'
        # we shouldn't have to play with script at all but seems to be a bug in reversemarkdown library
        "(?ms)<script type='text/javascript' id='wp-util-js-extra'>(.*)<\/script>"
        '(?ms)<script id="wp-util-js-extra">(.*)<\/script>'
    )
    $RulesAfter = @(
        '<br>'
    )

    $Splat = @{
        #Content                  = $BlogContent.Content
        Path                     = $FilePath
        DestinationPath          = "$PSScriptRoot\OutputBlogs\$($FileName).md"
        UnknownTags              = 'Bypass'
        GithubFlavored           = $true
        RemoveComments           = $true
        SmartHrefHandling        = $true
        RulesBefore              = $RulesBefore
        RulesAfter               = $RulesAfter
        DefaultCodeBlockLanguage = 'powershell'
        Format                   = $false
    }
    ConvertFrom-HTMLToMarkdown @Splat
}