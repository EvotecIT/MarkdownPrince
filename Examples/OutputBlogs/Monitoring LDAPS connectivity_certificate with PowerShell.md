


 
 
[## Monitoring LDAPS connectivity/certificate with PowerShell](https://evotec.xyz/monitoring-ldaps-connectivity-certificate-with-powershell/)





Some time ago, I wrote a blog post on checking for [LDAP, LDAPS, LDAP GC, and LDAPS GC](https://evotec.xyz/testing-ldap-and-ldaps-connectivity-with-powershell/) ports with PowerShell. It mostly works, but it requires a tad bit of effort, and it doesn't cover the full scope that I wanted. Recently (well over [3 years ago](https://gist.github.com/indented-automation/7a96a71be7eac9afc750e98fddab488f)), Chris Dent shared some code that verifies the **LDAP certificate**, and I thought this would be good to update my cmdlets to support just that with a bit of my own magic on top.







*Testing LDAPS with Testimo*



I don't know if you ever heard of **[Testimo](https://github.com/EvotecIT/Testimo)**, but it allows you to quickly test for different parts of your **Active Director**y with minimal effort. With the same little cmdlet, the full forest is scanned for all domains within the forest, and it goes and checks all Domain Controllers in each domain for **LDAP**. Testimo offers the **Sources** parameter, which allows you to pick one or multiple tests during a single run. In our case, we're interested in the **DomainLDAP** test.


 

```powershell
Invoke-Testimo -Sources DomainLDAP -Online
```



Online switch in that cmdlet is optional, and it controls the **HTML** report use of external resources. Online switch forces the use of **CDN** resources rather than push everything locally (which makes **HTML** sources a bit more readable). Feel free to skip it if required.


 


[![](https://evotec.xyz/wp-content/uploads/2021/03/img_603cfcdbda98e.png)](https://evotec.xyz/wp-content/uploads/2021/03/img_603cfcdbda98e.png)


 


In the below report, what you see in the left top corner is a **basic summary** of all tests done and whether all tests passed or some problems occurred. Just below it, it contains a cmdlet that was executed to get the data. On the right, you see a description of the test, few resources to deepen your knowledge about **LDAP**, and an overall summary of all tests. This is useful if you have **10**–**50**–**100**–**200** domain controllers, and you want to make sure all of those are ok. If those show proper status, there's usually no need to dive into the details. However, the details are also there – just at the bottom of the report.


 


[![](https://evotec.xyz/wp-content/uploads/2021/03/img_603cfdc449192.png)](https://evotec.xyz/wp-content/uploads/2021/03/img_603cfdc449192.png)


 


The report is pretty comprehensive when it comes to testing for **LDAP availability**. It first does basic **LDAP connectivity** checks to switch to full **LDAP binding** with reading certificate information. This means we're able to tell how much time it is for the certificate to expire and need replacement, what names are on the certificate, and which CA is responsible for supplying it, and generally how good or bad the certificate is.


 


[![](https://evotec.xyz/wp-content/uploads/2021/03/img_603cff2d0d05a.png)](https://evotec.xyz/wp-content/uploads/2021/03/img_603cff2d0d05a.png)


 


It's effortless to assess whether everything is ok, or something is wrong with coloring in place. In case some parameters are outside of the norm will be marked with red color for verification.







*Testing LDAPS the console way*



Of course, if you still prefer the old way of doing things, the same cmdlet available before in **ADEssentials** is still there, just a bit on steroids. By default, it doesn't require any parameters to be passed. It will autodetect DC and use that to work its way thru all **Domain Controllers**.


 

```powershell
Test-LDAP | Format-Table -AutoSize 
```



However, you can specify the VerifyCertificate switch, which will do a proper LDAP Bind and gather that information. While it's cut off from the screen, believe me – it's there!


 

```powershell
Test-LDAP -VerifyCertificate | Format-Table -AutoSize
```



[![](https://evotec.xyz/wp-content/uploads/2021/03/img_603d01babe615.png)](https://evotec.xyz/wp-content/uploads/2021/03/img_603d01babe615.png)


 


An old way still works – you can still query **LDAP** using **ComputerName**.


 


[![](https://evotec.xyz/wp-content/uploads/2021/03/img_603d295b38530.png)](https://evotec.xyz/wp-content/uploads/2021/03/img_603d295b38530.png)







*Summary*



**Testimo** is a big Active Directory test framework. Testing LDAP is just one of the multiple tests. It contains a lot of reports, and just one of those is shown here. Feel free to explore. The full source code is available (and somewhat readable – one function per file) on **GitHub**. Not everything may be easy to understand, but I plan to release more blog posts on different ways to deal with issues. What's important to know is that some tests work without any Domain privileges. For example, the **DomainLDAP** report doesn't require to be **Domain Admin**. It will work as a standard user as long as that user has domain visibility.


 


The code is published on [GitHub](https://github.com/EvotecIT/Testimo)





Issues should be reported on [GitHub](https://github.com/EvotecIT/Testimo/issues)





Code is published as a module on [PowerShellGallery](https://www.powershellgallery.com/packages/Testimo/)





The module is signed with a certificate, like any new modules that I create or update.


 

```powershell
Install-Module Testimo -Force
```



GO Ahead! Have fun! Make sure to report any issues, or if you feel like something would require covering more ground, let me know.







*Useful Resources*



If you like the content above, you may be interested in similar content that talks about [**Testimo**](https://github.com/EvotecIT/Testimo), [**GPOZaurr**](https://github.com/EvotecIT/GPOZaurr), [**PSWinDocumentation**](https://github.com/EvotecIT/PSWinDocumentation), and [**PSWinReportingV2**](https://github.com/EvotecIT/PSWinReporting). All those modules are hosted on GitHub, so all sources are there, but if you want to find out details about them, I've spent a fair amount of time describing their functionality in those blog posts below.


 

- [The only command you will ever need to understand and fix your Group Policies (GPO)](https://evotec.xyz/the-only-command-you-will-ever-need-to-understand-and-fix-your-group-policies-gpo/) – this blog post talks about [GPOZaurr](https://github.com/EvotecIT/GPOZaurr), and how with a single cmdlet, you can have a 360-degree overview of Group Policies. It covers permissions, ownership, **SYSVOL**, **NetLogon**, **GPO** content analysis, and many more issues. What more – it provides solutions to all those problems. But don't be fooled. This blog focuses on a single cmdlet, while **GPOZaurr** has 40 or more cmdlets for you to work with.
- [What do we say to health checking Active Directory?](https://evotec.xyz/what-do-we-say-to-health-checking-active-directory/) – is an old blog post that is an introduction to [**Testimo**](https://github.com/EvotecIT/Testimo). While a lot has changed since the initial release, it's still a good blog post to understand how **Testimo** works, its goals, and what it can do. It contains a vast amount of Active Directory knowledge you may find useful while testing your own Active Directory.
- [What do we say to writing Active Directory documentation?](https://evotec.xyz/what-do-we-say-to-writing-active-directory-documentation/) – an even older blog post about [**PSWinDocumentation**](https://github.com/EvotecIT/PSWinDocumentation). **PSWinDocumentation** goal is to automatically create **Active Directory** (and later on of **Office 365/Azure**). This module can scan **Active Directory** and export all information to **Microsoft Word**, **Excel**, or **SQL**. Its goal is to stop writing documentation in favor of automated one. It's long overdue for us to refresh this module – but it will happen – soon enough.
- [The only PowerShell Command you will ever need to find out who did what in Active Directory](https://evotec.xyz/the-only-powershell-command-you-will-ever-need-to-find-out-who-did-what-in-active-directory/) – is a blog post about **Find-Events** cmdlet that you can find in [**PSWinReportingV2**](https://github.com/EvotecIT/PSWinReporting). This cmdlet can scan all **Active Directory** controllers and read Security event logs, and finally provide an overview of who created users when the user was added to a group, when, and who deleted the user. There over 20 different reports proving very useful for day to the monitoring of administrative activities.







