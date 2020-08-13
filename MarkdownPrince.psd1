@{
    AliasesToExport      = ''
    Author               = 'Przemyslaw Klys'
    CompanyName          = 'Evotec'
    CompatiblePSEditions = 'Desktop', 'Core'
    Copyright            = '(c) 2011 - 2020 Przemyslaw Klys @ Evotec. All rights reserved.'
    Description          = 'Little project to work with Markdown files'
    FunctionsToExport    = 'ConvertFrom-HTMLToMarkdown', 'ConvertTo-MarkdownFromHTML'
    GUID                 = 'c6547723-88bb-4644-a1cc-8dcd1ae4e0dc'
    ModuleVersion        = '0.0.2'
    PowerShellVersion    = '5.1'
    PrivateData          = @{
        PSData = @{
            LicenseUri                 = 'https://github.com/EvotecIT/MarkdownPrince/blob/master/LICENSE'
            Tags                       = 'macOS', 'linux', 'windows', 'markdown', 'html'
            ProjectUri                 = 'https://github.com/EvotecIT/MarkdownPrince'
            ExternalModuleDependencies = 'Microsoft.PowerShell.Utility', 'Microsoft.PowerShell.Management'
            IconUri                    = 'https://evotec.xyz/wp-content/uploads/2020/08/MarkdownPrince.png'
        }
    }
    RequiredModules      = 'Microsoft.PowerShell.Utility', 'Microsoft.PowerShell.Management'
    RootModule           = 'MarkdownPrince.psm1'
}