<p align="center">
  <a href="https://dev.azure.com/evotecpl/MarkdownPrince/_build/latest?definitionId=3"><img src="https://dev.azure.com/evotecpl/MarkdownPrince/_apis/build/status/EvotecIT.MarkdownPrince"></a>
  <a href="https://www.powershellgallery.com/packages/MarkdownPrince"><img src="https://img.shields.io/powershellgallery/v/MarkdownPrince.svg"></a>
  <a href="https://www.powershellgallery.com/packages/MarkdownPrince"><img src="https://img.shields.io/powershellgallery/vpre/MarkdownPrince.svg?label=powershell%20gallery%20preview&colorB=yellow"></a>
  <a href="https://github.com/EvotecIT/MarkdownPrince"><img src="https://img.shields.io/github/license/EvotecIT/MarkdownPrince.svg"></a>
</p>

<p align="center">
  <a href="https://www.powershellgallery.com/packages/MarkdownPrince"><img src="https://img.shields.io/powershellgallery/p/MarkdownPrince.svg"></a>
  <a href="https://github.com/EvotecIT/MarkdownPrince"><img src="https://img.shields.io/github/languages/top/evotecit/MarkdownPrince.svg"></a>
  <a href="https://github.com/EvotecIT/MarkdownPrince"><img src="https://img.shields.io/github/languages/code-size/evotecit/MarkdownPrince.svg"></a>
  <a href="https://www.powershellgallery.com/packages/MarkdownPrince"><img src="https://img.shields.io/powershellgallery/dt/MarkdownPrince.svg"></a>
</p>

<p align="center">
  <a href="https://twitter.com/PrzemyslawKlys"><img src="https://img.shields.io/twitter/follow/PrzemyslawKlys.svg?label=Twitter%20%40PrzemyslawKlys&style=social"></a>
  <a href="https://evotec.xyz/hub"><img src="https://img.shields.io/badge/Blog-evotec.xyz-2A6496.svg"></a>
  <a href="https://www.linkedin.com/in/pklys"><img src="https://img.shields.io/badge/LinkedIn-pklys-0077B5.svg?logo=LinkedIn"></a>
</p>

# MarkdownPrince - PowerShell Module

**MarkdownPrince** is small **PowerShell** module that helps to **convert HTML files into Markdown**.

## How to use

```powershell
ConvertFrom-HTMLToMarkdown -Path $HTMLFile -UnknownTags Drop -GithubFlavored -DestinationPath $DestinationPath
```

## To install

```powershell
Install-Module -Name MarkdownPrince -AllowClobber -Force
```

Force and AllowClobber aren't necessary, but they do skip errors in case some appear.

## And to update

```powershell
Update-Module -Name MarkdownPrince
```

That's it. Whenever there's a new version, you run the command, and you can enjoy it. Remember that you may need to close, reopen PowerShell session if you have already used module before updating it.

**The essential thing** is if something works for you on production, keep using it till you test the new version on a test computer. I do changes that may not be big, but big enough that auto-update may break your code. For example, small rename to a parameter and your code stops working! Be responsible!

## Changelog

- 0.0.2 - 14.08.2020
  - Improvements
- 0.0.1 - 8.08.2020
  - First draft release

## 3rd party libraries

**MarkdownPrince** uses **3rd party libraries** to deliver it's functionality

- [x] [ReverseMarkdown](https://github.com/mysticmind/reversemarkdown-net) (**MIT** License) - delivers conversion from **HTML** to **MARKDOWN**
- [x] [Markdig](https://github.com/lunet-io/markdig) (**BSD-Clause 2** license) - delivers conversion from **MAKRDOWN** to **HTML** (**not functional yet!**)

Without those projects MarkdownPrince would be small
