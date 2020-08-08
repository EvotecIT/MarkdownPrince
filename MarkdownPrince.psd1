@{
    AliasesToExport      = ''
    Author               = 'Przemyslaw Klys'
    CompanyName          = 'Evotec'
    CompatiblePSEditions = 'Desktop', 'Core'
    Copyright            = '(c) 2011 - 2020 Przemyslaw Klys @ Evotec. All rights reserved.'
    Description          = 'Little project to work with Markdown files'
    FunctionsToExport    = 'ConvertFrom-HTMLToMarkdown'
    GUID                 = 'c6547723-88bb-4644-a1cc-8dcd1ae4e0dc'
    ModuleVersion        = '0.0.1'
    PowerShellVersion    = '5.1'
    PrivateData          = @{
        PSData = @{
            Tags                       = 'macOS', 'linux', 'windows'
            ExternalModuleDependencies = 'Microsoft.PowerShell.Utility', 'Microsoft.PowerShell.Management'
        }
    }
    RequiredModules      = @{
        ModuleVersion = '0.0.166'
        ModuleName    = 'PSSharedGoods'
        Guid          = 'ee272aa8-baaa-4edf-9f45-b6d6f7d844fe'
    }, 'Microsoft.PowerShell.Utility', 'Microsoft.PowerShell.Management'
    RootModule           = 'MarkdownPrince.psm1'
}