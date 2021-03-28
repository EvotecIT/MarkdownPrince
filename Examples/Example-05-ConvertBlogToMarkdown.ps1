Import-Module $PSScriptRoot\..\MarkdownPrince.psd1 -Force

# Get Content
$BlogContent = Invoke-WebRequest -Uri 'https://evotec.xyz/submitting-blogs-to-web-archive-org-using-powershell/'
$BlogContent.Content | Out-File -FilePath $PSScriptRoot\Input\Example04.html

# Use PSParseHTML to format HTML so we can easier see what to remove
Format-HTML -File $PSScriptRoot\Input\Example04.html -OutputFile $PSScriptRoot\Input\Example04.html

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
    '(?ms)<pre class="hidden">(.*?)</pre>'
    '(?ms)<script id="wp-util-js-extra">(.*?)<\/script>'
)
$RulesAfter = @(
    '<br>'
)

$Splat = @{
    Content                  = $BlogContent.Content
    DestinationPath          = "$PSScriptRoot\Output\Example04.md"
    UnknownTags              = Bypass
    GithubFlavored           = $true
    RemoveComments           = $true
    SmartHrefHandling        = $true
    RulesBefore              = $RulesBefore
    RulesAfter               = $RulesAfter
    DefaultCodeBlockLanguage = 'powershell'
    Format                   = $true
}
ConvertFrom-HTMLToMarkdown @Splat