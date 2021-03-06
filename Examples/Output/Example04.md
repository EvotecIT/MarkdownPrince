


 
 






Since my website went down in fire with **OVH SBG2**, I used this occasion to publish my restored website via **Cloudflare**. It allows me to have to cache, minimization, and some additional security. One thing that caught my attention while browsing through **Cloudflare** settings was the **Always Online** feature based on **web.archive.org**. Basically, the concept is – whenever the website is down, **Cloudflare** would go and fetch content from** web.archive.org**.


 


[![](https://evotec.xyz/wp-content/uploads/2021/03/img_60533f859c598.png)](https://evotec.xyz/wp-content/uploads/2021/03/img_60533f859c598.png)


 


While the feature is in beta, and I really hope it won't ever happen again that my website will go down for longer than a few minutes, I thought that it's worth enabling this feature as some of the content I host is the documentation for my open-source projects that can't be found anywhere else. The only thought I had, is now I need to make sure that **web.archive.org** actually has my website covered and updated. If you go to the website, you can tell archive.org to archive your link, but the problem is – it will only take that link and nothing else.


 


[![](https://evotec.xyz/wp-content/uploads/2021/03/img_60538e4155123.png)](https://evotec.xyz/wp-content/uploads/2021/03/img_60538e4155123.png)







*Submitting all blogs to web.archive.org*



To make sure all my blogs will be added to **WayBackMachine** without me spending tons of time, I've written a short script that will help me do it. The **hardest **part is getting all the blogs from wy website. Fortunately, a while back, I wrote a **PowerShell** module called [PSWebToolbox](https://github.com/EvotecIT/PSWebToolbox) that contains **Get-RSSFeed** cmdlet, which can scan **RSS** feed and get all blogs from any website.


 

```powershell
'https://evotec.xyz/feed' | Get-RSSFeed -Count 12 -Verbose | Format-Table -AutoSize
'https://evotec.xyz/feed' | Get-RSSFeed -Count 2
```



[![](https://evotec.xyz/wp-content/uploads/2021/03/img_605486ce30eff.png)](https://evotec.xyz/wp-content/uploads/2021/03/img_605486ce30eff.png)


 


Having **PSWebToolbox** with its **Get-RSSFeed** meant that I only need to submit the blogs using the **Invoke-WebRequest** cmdlet. **Get-RSSFeed** provides me titles, links, categories, and even descriptions. The script has basic error handling along with a fail-safe. If something fails (the archive.org website isn't the most responsive), the script will continue applying other blog posts. Once done, the script, when rerun, would push only missing links rather than starting from scratch.


 

```powershell
$Blogs = Get-RSSFeed -Url 'https://evotec.xyz/feed/' -All
if (-not $StatusBlogs) {
    $StatusBlogs = [ordered] @{}
}
foreach ($Blog in $Blogs) {
    if ($StatusBlogs[$Blog.Link] -eq $true) {
        continue
    }
    Write-Color "[+] ", "Submiting blog ", $($Blog.Title), " ($($Blog.Link)) ", "published on ", $($Blog.PublishDate) -Color Yellow, White, Yellow, Cyan, White, Yellow, White, Red
    try {
        $Status = Invoke-WebRequest -Uri "https://web.archive.org/save/$($Blog.Link)" -ErrorAction Stop
        if ($Status.StatusCode -eq 200) {
            $StatusBlogs[$Blog.Link] = $true
            Write-Color "[+] ", "Submiting blog succeeded ", $($Blog.Title), " ($($Blog.Link)) ", "published on ", $($Blog.PublishDate) -Color Yellow, White, Yellow, Green, White, Yellow, White, Red
        } else {
            $StatusBlogs[$Blog.Link] = $false
            Write-Color "[-] ", "Submiting blog failed ", $($Blog.Title), " ($($Blog.Link)) ", "published on ", $($Blog.PublishDate) -Color Yellow, White, Yellow, Red, White, Yellow, White, Red
        }
    } catch {
        $StatusBlogs[$Blog.Link] = $false
        Write-Color "[-] ", "Submiting blog failed ", $($Blog.Title), " ($($Blog.Link)) ", "published on ", $($Blog.PublishDate), " with error: ", $($_.Exception.Message) -Color Yellow, White, Yellow, Red, White, Yellow, White, Red
    }
}
```



You may have also noticed me using the **Write-Color** cmdlet, which simplifies colorful messages. It's not necessary and could be easily replaced by **Write-Host** or anything else. If you would like to have **Write-Color** at your disposal, you can install it from **PowerShellGallery** or get the sources from [GitHub](https://github.com/EvotecIT/PSWriteColor).


 


![Submitting blogs to WebArchive using PowerShell](https://evotec.xyz/wp-content/uploads/2021/03/img_60532774b99f8.png)







*Required PowerShell Modules*



To install or update **PowerShell** modules required to get the above script up and running, you need to install the following **PowerShell** modules.


 

```powershell
Install-Module PSWebToolbox
Install-Module PSWriteColor
```





