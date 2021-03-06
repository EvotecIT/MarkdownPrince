


 
 
[## Creating Office 365 Migration Diagram with PowerShell](https://evotec.xyz/creating-office-365-migration-diagram-with-powershell/)





A few weeks ago, I posted a concept migration diagram for Office 365 to [Twitter](https://twitter.com/PrzemyslawKlys/status/1336377938514767874?s=20) and [Facebook](https://fb.watch/2gUs3ZLkxY/). Today I thought I would show you how you can do it yourself using **PowerShell** and [PSWriteHTML PowerShell](https://github.com/EvotecIT/PSWriteHTML) module. When I started working on this, I've thought I want to create before and after infrastructure to see how it will look when migration ends. I've initially planned to assign myself an **Office 365 Visio Plan 2** license and do something manually, thinking it may be just much easier. Unfortunately for me, there were no free Visio licenses in my tenant, and my laziness took over, so I've decided to give it a go using **PowerShell** only.


 


[![](https://evotec.xyz/wp-content/uploads/2020/12/img_5fd128bf1d705.png)](https://evotec.xyz/wp-content/uploads/2020/12/img_5fd128bf1d705.png)


 


If you like what you see above and you should be happy to know it's only 20 PowerShell lines of code, and with just a small effort on your side you can have your own infrastructure done soon enough.







*How to get started with PSWriteHTML*



How to get started? It's quite simple. You will need to install a PowerShell module called [**PSWriteHTML**](https://github.com/EvotecIT/PSWriteHTML/issues). It's available from PowerShellGallery. The module is signed and optimized for speed. If you prefer, you can always get the version straight from [GitHub](https://github.com/EvotecIT/PSWriteHTML/issues), with the difference being it's not signed and consists of hundreds of files without any optimization. Good for development and inspecting sources, not for production use – but whatever makes you happy.


 

```powershell
Install-Module PSWriteHTML
```



That little command is all you need to get started creating your own diagrams (among other things – but we're not here to brag about all the features, right?).







*First Steps - How to create basic diagram with PSWriteHTML*



Once we have **PSWriteHTML** installed with just 5 commands, we can generate what you see above. A critical part of creating a new **HTML** document is starting it up with the **New-HTML** cmdlet. As you can see, I'm using the **Online** parameter, which will use **CDN** links to styles/scripts rather than inlining everything. I'm using the **FilePath** parameter to define where the file should be saved. Finally, I'm using **ShowHTML** to automatically open up HTML in the browser when the HTML generation is done.


 

```powershell
New-HTML -Online -FilePath $PSScriptRoot\MyDiagram.html {

} -ShowHTML
```



Please notice the opening and closing brace. This is where the content will go. If you run the code above, you would get an empty **HTML** file. It's important to understand the idea behind braces, where you will see this quite often for most of the commands available in **PSWriteHTML**. It simply tries to follow the idea of visual representation and an easy way to understand what goes where and what order. This makes **PSWriteHTML** readable in most cases, without having to spend a lot of time. **The next step** is adding a diagram to our HTML. This can be done by adding **New-HTMLDiagram** and again using braces for any content related to that diagram.


 

```powershell
New-HTML -Online -FilePath $PSScriptRoot\MyDiagram.html {
    New-HTMLDiagram {
        New-DiagramNode -Label 'First Node'
        New-DiagramNode -Label '2nd Node'

        New-DiagramLink -From 'First Node' -To '2nd Node'
    }
} -ShowHTML
```



What we have above? We've created a diagram and used **New-DiagramNode** two times to create two different nodes, and then we use **New-DiagramLink** to create a link between both nodes.


 


[![](https://evotec.xyz/wp-content/uploads/2020/12/img_5fd14eb1d188e.png)](https://evotec.xyz/wp-content/uploads/2020/12/img_5fd14eb1d188e.png)


 


So we already have 3 commands used. The last 2 commands you will need to create are **New-DiagramOptionsLayout** and **New-DiagramPhysics**. The first one controls the layout changing standard one into hierarchical. The second control how physics behaves when nodes are created and linked together. Those will be important aspects in terms of how nodes will behave when being added to a diagram. Feel free to experiment with different options


 

```powershell
New-HTML -Online -FilePath $PSScriptRoot\MyDiagram.html {
    New-HTMLDiagram {
        # Those control layout / physics
        New-DiagramOptionsLayout -HierarchicalEnabled $true #-HierarchicalDirection FromLeftToRight
        New-DiagramOptionsPhysics -Enabled $true -HierarchicalRepulsionAvoidOverlap 1 -HierarchicalRepulsionNodeDistance 200

        # Thos control nodes + links between nodes
        New-DiagramNode -Label 'First Node'
        New-DiagramNode -Label '2nd Node'

        New-DiagramLink -From 'First Node' -To '2nd Node'
    }
} -ShowHTML
```



[![](https://evotec.xyz/wp-content/uploads/2020/12/img_5fed8e4e117f5.png)](https://evotec.xyz/wp-content/uploads/2020/12/img_5fed8e4e117f5.png)


 


Using a **hierarchical layout** changed the way the diagram behaves. It creates nodes from top to bottom, or if you provide a **HierarchicalDirection** parameter, **you can force it from Left to Right**. This allows for easier positioning without having to resort to much more time-consuming options. With just those five cmdlets, you can create a diagram, as shown in this blog post's introduction. Good luck!







*Creating Office 365 Diagram*



If you thought I would leave you hanging with that basic introduction, I have to disappoint you 🤣 Now that you know the basics of working with the **PSWriteHTML** diagram, we just need to use additional parameters of cmdlets we already know. **New-DiagramNode** has multiple parameters that allow you to decide on how the node looks like. You can use **built-in Icons** or **FontAwesome Icons** or, like in my case, use external images. Since I wanted to have an **Office 365 diagram,** I've decided to use external images hosted on [Icon Scout](https://iconscout.com/). But that is completely up to you. You can use your own images, images from any website, as long as you accept the risks of someone replacing your chosen Icon with something entirely different. I've searched on [Icon Scout for Office 365](https://iconscout.com/icons/office-365) and was not disappointed. It provides beautiful icons that are quick and easy to use.


 

```powershell
New-HTML -Online -FilePath $PSScriptRoot\MyDiagram.html {
    New-HTMLDiagram {
        # Those control layout / physics
        New-DiagramOptionsLayout -HierarchicalEnabled $true #-HierarchicalDirection FromLeftToRight
        New-DiagramOptionsPhysics -Enabled $true -HierarchicalRepulsionAvoidOverlap 1 -HierarchicalRepulsionNodeDistance 200

        # Lets add nodes to the diagram representing Company A
        New-DiagramNode -Label "Active Directory`nCompanyADawid.Local" -Id 'CompanyAAD' -Image 'https://cdn.iconscout.com/icon/premium/png-64-thumb/active-directory-1830982-1554160.png' -ImageType squareImage -Level 3
        New-DiagramNode -Label "Azure AD Connect`nCompanyADawid.Local" -Id 'AzureADConnectCompanyA' -Image 'https://cdn.iconscout.com/icon/free/png-64/azure-190760.png' -ImageType squareImage -Level 4
        New-DiagramNode -Label "Exchange`nCompanyADawid.local" -Id 'ExchangeCompanyA' -Image 'https://cdn.iconscout.com/icon/free/png-64/microsoft-exchange-2-569302.png' -ImageType squareImage -Level 4
        New-DiagramNode -Label 'Internet' -Image 'https://cdn.iconscout.com/icon/premium/png-64-thumb/internet-2102080-1768387.png' -ImageType squareImage -Id 'Internet1' -Level 2
        New-DiagramNode -Label 'Office 365 - CompanyALTD.onmicrosoft.com' -Id 'CompanyAO365' -ImageType circularImage -Image 'https://cdn.iconscout.com/icon/free/png-64/office-365-1482123-1254388.png' -Level 1
        New-DiagramNode -Label 'OneDrive' -Image 'https://cdn.iconscout.com/icon/free/png-64/onedrive-1411856-1194345.png' -ImageType squareImage -Level 0
        New-DiagramNode -Label 'Teams' -Image 'https://cdn.iconscout.com/icon/free/png-64/teams-1411850-1194339.png' -ImageType squareImage -Level 0
        New-DiagramNode -Label 'SharePoint' -Image 'https://cdn.iconscout.com/icon/free/png-64/sharepoint-1411852-1194341.png' -ImageType squareImage -Level 0

    }
} -ShowHTML
```



As you can notice in code, each of my diagram nodes, have


 

- Label – describe what the node is all about
- ID – define unique node ID that will be used in New-DiagramLink to link two or more nodes together
- An image that allows you to define the path to Image
- ImageType which allows you to choose whether an image will be circular or square
- Level – which defines a hierarchical position on a diagram





The level is responsible for the nodes' positioning and probably the most important parameter for this diagram.


 


[![](https://evotec.xyz/wp-content/uploads/2020/12/img_5fed96835f7b0.png)](https://evotec.xyz/wp-content/uploads/2020/12/img_5fed96835f7b0.png)


 


As you can see above, we have added 8 nodes to the diagram, and with the level, we made sure its position on the diagram is fixed (only from top to bottom). If we wouldn't specify it – by default, it would be level 0 and look like this:


 


[![](https://evotec.xyz/wp-content/uploads/2020/12/img_5fed973410e1d.png)](https://evotec.xyz/wp-content/uploads/2020/12/img_5fed973410e1d.png)


 


The next step is to add nodes for the second company. We repeat the process as above. Don't worry if you don't get Level right at the beginning. I experimented a bit on how to visualize the architecture best before I got my levels correctly decided. And, of course, you can extend the diagram with whatever content you choose. You can add more nodes with Domain Controllers, Sites, Users, and so on. I didn't need it on the migration diagram, but nothing stops you from doing so.


 

```powershell
New-HTML -Online -FilePath $PSScriptRoot\MyDiagram.html {
    New-HTMLDiagram {
        # Those control layout / physics
        New-DiagramOptionsLayout -HierarchicalEnabled $true #-HierarchicalDirection FromLeftToRight
        New-DiagramOptionsPhysics -Enabled $true -HierarchicalRepulsionAvoidOverlap 1 -HierarchicalRepulsionNodeDistance 200

        # Lets add nodes to the diagram representing Company A
        New-DiagramNode -Label "Active Directory`nCompanyADawid.Local" -Id 'CompanyAAD' -Image 'https://cdn.iconscout.com/icon/premium/png-64-thumb/active-directory-1830982-1554160.png' -ImageType squareImage -Level 3
        New-DiagramNode -Label "Azure AD Connect`nCompanyADawid.Local" -Id 'AzureADConnectCompanyA' -Image 'https://cdn.iconscout.com/icon/free/png-64/azure-190760.png' -ImageType squareImage -Level 4
        New-DiagramNode -Label "Exchange`nCompanyADawid.local" -Id 'ExchangeCompanyA' -Image 'https://cdn.iconscout.com/icon/free/png-64/microsoft-exchange-2-569302.png' -ImageType squareImage -Level 4
        New-DiagramNode -Label 'Internet' -Image 'https://cdn.iconscout.com/icon/premium/png-64-thumb/internet-2102080-1768387.png' -ImageType squareImage -Id 'Internet1' -Level 2
        New-DiagramNode -Label 'Office 365 - CompanyALTD.onmicrosoft.com' -Id 'CompanyAO365' -ImageType circularImage -Image 'https://cdn.iconscout.com/icon/free/png-64/office-365-1482123-1254388.png' -Level 1
        New-DiagramNode -Label 'OneDrive' -Image 'https://cdn.iconscout.com/icon/free/png-64/onedrive-1411856-1194345.png' -ImageType squareImage -Level 0
        New-DiagramNode -Label 'Teams' -Image 'https://cdn.iconscout.com/icon/free/png-64/teams-1411850-1194339.png' -ImageType squareImage -Level 0
        New-DiagramNode -Label 'SharePoint' -Image 'https://cdn.iconscout.com/icon/free/png-64/sharepoint-1411852-1194341.png' -ImageType squareImage -Level 0

        # Lets add nodes to the diagram representing Company B
        New-DiagramNode -Label 'Internet' -Image 'https://cdn.iconscout.com/icon/premium/png-64-thumb/internet-2102080-1768387.png' -ImageType squareImage -Id 'Internet2' -Level 2
        New-DiagramNode -Label 'Office 365 - CompanyBSA.onmicrosoft.com' -ImageType circularImage -Image 'https://cdn.iconscout.com/icon/free/png-64/office-365-1482123-1254388.png' -Id 'CompanyBO365' -Level 1
        New-DiagramNode -Label "Active Directory`nCompanyB.corp" -Id 'CompanyBAD' -Image 'https://cdn.iconscout.com/icon/premium/png-64-thumb/active-directory-1830982-1554160.png' -ImageType squareImage -Level 3
        New-DiagramNode -Label "Azure AD Connect`nCompanyB.corp" -Id 'AzureADConnectCompanyB' -Image 'https://cdn.iconscout.com/icon/free/png-64/azure-190760.png' -ImageType squareImage -Level 4
        New-DiagramNode -Label 'Exchange Online' -Id 'ExchangeCompanyB' -ImageType squareImage -Image 'https://cdn.iconscout.com/icon/free/png-64/microsoft-exchange-4-896276.png' -Level 0
        New-DiagramNode -Label "OneDrive`nCompanyB" -Id 'OneDriveCompanyB' -Image 'https://cdn.iconscout.com/icon/free/png-64/onedrive-1411856-1194345.png' -ImageType squareImage -Level 0
        New-DiagramNode -Label "Teams`nCompanyB" -Id 'TeamsCompanyB' -Image 'https://cdn.iconscout.com/icon/free/png-64/teams-1411850-1194339.png' -ImageType squareImage -Level 0
        New-DiagramNode -Label "SharePoint`nCompanyB" -Id 'SharePointCompanyB' -Image 'https://cdn.iconscout.com/icon/free/png-64/sharepoint-1411852-1194341.png' -ImageType squareImage -Level 0
    }
} -ShowHTML
```



[![](https://evotec.xyz/wp-content/uploads/2020/12/img_5fed9852b1978.png)](https://evotec.xyz/wp-content/uploads/2020/12/img_5fed9852b1978.png)


 


Since we have no links between nodes, the positioning horizontally is automatic and done by the module itself. We only defined levels, so there's nothing pushing nodes in the right direction. Levels make sure that nodes of the same type are on the same level, so it's easier to place them on the diagram visually. As you remember, we have defined with **New-DiagramOptionsPhysics** that node distance should be **200**, and there should be no overlap, which you will soon see how it works when we define links. However, be informed that there are multiple ways to configure physics using different parameters. Feel free to experiment with those and see how it behaves in different situations. Whatever I'm showing you here is just one way to do it. The next step is to make sure we connect our nodes for the first company. You use the **ID** from one **node to connect it to another node**. By design, when ID for New-DiagramNode is not given, Label becomes ID as well. This means you can skip defining ID and use Labels only; however, this becomes problematic with more complicated labels.


 

```powershell
New-DiagramLink -From 'ExchangeCompanyA' -To 'CompanyAAD' -ArrowsToEnabled -ArrowsFromEnabled
New-DiagramLink -From 'ExchangeCompanyA' -To 'Internet 2'
New-DiagramLink -From 'Internet1' -To 'CompanyAO365' -ArrowsToEnabled -ArrowsFromEnabled
New-DiagramLink -From 'CompanyAAD' -To 'AzureADConnectCompanyA' -ArrowsFromEnabled
New-DiagramLink -From 'CompanyAAD' -To 'Internet1' -ArrowsToEnabled
New-DiagramLink -From 'CompanyAO365' -To 'OneDrive' -ArrowsToEnabled -ArrowsFromEnabled
New-DiagramLink -From 'CompanyAO365' -To 'SharePoint' -ArrowsToEnabled -ArrowsFromEnabled
New-DiagramLink -From 'CompanyAO365' -To 'Teams' -ArrowsToEnabled -ArrowsFromEnabled
```



While I am not showing that above, **New-DiagramLink** allows many to many connections, this means you don't have to make each link separate to create complicated structures. In this case, it's not needed, but know it's there. Let's put those defined links to the diagram, shall we?


 

```powershell
New-HTML -Online -FilePath $PSScriptRoot\MyDiagram.html {
    New-HTMLDiagram {
        # Those control layout / physics
        New-DiagramOptionsLayout -HierarchicalEnabled $true #-HierarchicalDirection FromLeftToRight
        New-DiagramOptionsPhysics -Enabled $true -HierarchicalRepulsionAvoidOverlap 1 -HierarchicalRepulsionNodeDistance 200

        # Lets add nodes to the diagram representing Company A
        New-DiagramNode -Label "Active Directory`nCompanyADawid.Local" -Id 'CompanyAAD' -Image 'https://cdn.iconscout.com/icon/premium/png-64-thumb/active-directory-1830982-1554160.png' -ImageType squareImage -Level 3
        New-DiagramNode -Label "Azure AD Connect`nCompanyADawid.Local" -Id 'AzureADConnectCompanyA' -Image 'https://cdn.iconscout.com/icon/free/png-64/azure-190760.png' -ImageType squareImage -Level 4
        New-DiagramNode -Label "Exchange`nCompanyADawid.local" -Id 'ExchangeCompanyA' -Image 'https://cdn.iconscout.com/icon/free/png-64/microsoft-exchange-2-569302.png' -ImageType squareImage -Level 4
        New-DiagramNode -Label 'Internet' -Image 'https://cdn.iconscout.com/icon/premium/png-64-thumb/internet-2102080-1768387.png' -ImageType squareImage -Id 'Internet1' -Level 2
        New-DiagramNode -Label 'Office 365 - CompanyALTD.onmicrosoft.com' -Id 'CompanyAO365' -ImageType circularImage -Image 'https://cdn.iconscout.com/icon/free/png-64/office-365-1482123-1254388.png' -Level 1
        New-DiagramNode -Label 'OneDrive' -Image 'https://cdn.iconscout.com/icon/free/png-64/onedrive-1411856-1194345.png' -ImageType squareImage -Level 0
        New-DiagramNode -Label 'Teams' -Image 'https://cdn.iconscout.com/icon/free/png-64/teams-1411850-1194339.png' -ImageType squareImage -Level 0
        New-DiagramNode -Label 'SharePoint' -Image 'https://cdn.iconscout.com/icon/free/png-64/sharepoint-1411852-1194341.png' -ImageType squareImage -Level 0

        # Lets add nodes to the diagram representing Company B
        New-DiagramNode -Label 'Internet' -Image 'https://cdn.iconscout.com/icon/premium/png-64-thumb/internet-2102080-1768387.png' -ImageType squareImage -Id 'Internet2' -Level 2
        New-DiagramNode -Label 'Office 365 - CompanyBSA.onmicrosoft.com' -ImageType circularImage -Image 'https://cdn.iconscout.com/icon/free/png-64/office-365-1482123-1254388.png' -Id 'CompanyBO365' -Level 1
        New-DiagramNode -Label "Active Directory`nCompanyB.corp" -Id 'CompanyBAD' -Image 'https://cdn.iconscout.com/icon/premium/png-64-thumb/active-directory-1830982-1554160.png' -ImageType squareImage -Level 3
        New-DiagramNode -Label "Azure AD Connect`nCompanyB.corp" -Id 'AzureADConnectCompanyB' -Image 'https://cdn.iconscout.com/icon/free/png-64/azure-190760.png' -ImageType squareImage -Level 4
        New-DiagramNode -Label 'Exchange Online' -Id 'ExchangeCompanyB' -ImageType squareImage -Image 'https://cdn.iconscout.com/icon/free/png-64/microsoft-exchange-4-896276.png' -Level 0
        New-DiagramNode -Label "OneDrive`nCompanyB" -Id 'OneDriveCompanyB' -Image 'https://cdn.iconscout.com/icon/free/png-64/onedrive-1411856-1194345.png' -ImageType squareImage -Level 0
        New-DiagramNode -Label "Teams`nCompanyB" -Id 'TeamsCompanyB' -Image 'https://cdn.iconscout.com/icon/free/png-64/teams-1411850-1194339.png' -ImageType squareImage -Level 0
        New-DiagramNode -Label "SharePoint`nCompanyB" -Id 'SharePointCompanyB' -Image 'https://cdn.iconscout.com/icon/free/png-64/sharepoint-1411852-1194341.png' -ImageType squareImage -Level 0

        # Company 1 -Connections
        New-DiagramLink -From 'ExchangeCompanyA' -To 'CompanyAAD' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'ExchangeCompanyA' -To 'Internet 2'
        New-DiagramLink -From 'Internet1' -To 'CompanyAO365' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyAAD' -To 'AzureADConnectCompanyA' -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyAAD' -To 'Internet1' -ArrowsToEnabled
        New-DiagramLink -From 'CompanyAO365' -To 'OneDrive' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyAO365' -To 'SharePoint' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyAO365' -To 'Teams' -ArrowsToEnabled -ArrowsFromEnabled
    }
} -ShowHTML
```



[![](https://evotec.xyz/wp-content/uploads/2020/12/img_5fedb0a00fd35.png)](https://evotec.xyz/wp-content/uploads/2020/12/img_5fedb0a00fd35.png)


 


In the next step, we do the same thing as above – connect all the nodes for the second company.


 

```powershell
New-HTML -Online -FilePath $PSScriptRoot\MyDiagram.html {
    New-HTMLDiagram {
        # Those control layout / physics
        New-DiagramOptionsLayout -HierarchicalEnabled $true #-HierarchicalDirection FromLeftToRight
        New-DiagramOptionsPhysics -Enabled $true -HierarchicalRepulsionAvoidOverlap 1 -HierarchicalRepulsionNodeDistance 200

        # Lets add nodes to the diagram representing Company A
        New-DiagramNode -Label "Active Directory`nCompanyADawid.Local" -Id 'CompanyAAD' -Image 'https://cdn.iconscout.com/icon/premium/png-64-thumb/active-directory-1830982-1554160.png' -ImageType squareImage -Level 3
        New-DiagramNode -Label "Azure AD Connect`nCompanyADawid.Local" -Id 'AzureADConnectCompanyA' -Image 'https://cdn.iconscout.com/icon/free/png-64/azure-190760.png' -ImageType squareImage -Level 4
        New-DiagramNode -Label "Exchange`nCompanyADawid.local" -Id 'ExchangeCompanyA' -Image 'https://cdn.iconscout.com/icon/free/png-64/microsoft-exchange-2-569302.png' -ImageType squareImage -Level 4
        New-DiagramNode -Label 'Internet' -Image 'https://cdn.iconscout.com/icon/premium/png-64-thumb/internet-2102080-1768387.png' -ImageType squareImage -Id 'Internet1' -Level 2
        New-DiagramNode -Label 'Office 365 - CompanyALTD.onmicrosoft.com' -Id 'CompanyAO365' -ImageType circularImage -Image 'https://cdn.iconscout.com/icon/free/png-64/office-365-1482123-1254388.png' -Level 1
        New-DiagramNode -Label 'OneDrive' -Image 'https://cdn.iconscout.com/icon/free/png-64/onedrive-1411856-1194345.png' -ImageType squareImage -Level 0
        New-DiagramNode -Label 'Teams' -Image 'https://cdn.iconscout.com/icon/free/png-64/teams-1411850-1194339.png' -ImageType squareImage -Level 0
        New-DiagramNode -Label 'SharePoint' -Image 'https://cdn.iconscout.com/icon/free/png-64/sharepoint-1411852-1194341.png' -ImageType squareImage -Level 0

        # Lets add nodes to the diagram representing Company B
        New-DiagramNode -Label 'Internet' -Image 'https://cdn.iconscout.com/icon/premium/png-64-thumb/internet-2102080-1768387.png' -ImageType squareImage -Id 'Internet2' -Level 2
        New-DiagramNode -Label 'Office 365 - CompanyBSA.onmicrosoft.com' -ImageType circularImage -Image 'https://cdn.iconscout.com/icon/free/png-64/office-365-1482123-1254388.png' -Id 'CompanyBO365' -Level 1
        New-DiagramNode -Label "Active Directory`nCompanyB.corp" -Id 'CompanyBAD' -Image 'https://cdn.iconscout.com/icon/premium/png-64-thumb/active-directory-1830982-1554160.png' -ImageType squareImage -Level 3
        New-DiagramNode -Label "Azure AD Connect`nCompanyB.corp" -Id 'AzureADConnectCompanyB' -Image 'https://cdn.iconscout.com/icon/free/png-64/azure-190760.png' -ImageType squareImage -Level 4
        New-DiagramNode -Label 'Exchange Online' -Id 'ExchangeCompanyB' -ImageType squareImage -Image 'https://cdn.iconscout.com/icon/free/png-64/microsoft-exchange-4-896276.png' -Level 0
        New-DiagramNode -Label "OneDrive`nCompanyB" -Id 'OneDriveCompanyB' -Image 'https://cdn.iconscout.com/icon/free/png-64/onedrive-1411856-1194345.png' -ImageType squareImage -Level 0
        New-DiagramNode -Label "Teams`nCompanyB" -Id 'TeamsCompanyB' -Image 'https://cdn.iconscout.com/icon/free/png-64/teams-1411850-1194339.png' -ImageType squareImage -Level 0
        New-DiagramNode -Label "SharePoint`nCompanyB" -Id 'SharePointCompanyB' -Image 'https://cdn.iconscout.com/icon/free/png-64/sharepoint-1411852-1194341.png' -ImageType squareImage -Level 0

        # Company 1 -Connections
        New-DiagramLink -From 'ExchangeCompanyA' -To 'CompanyAAD' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'ExchangeCompanyA' -To 'Internet 2'
        New-DiagramLink -From 'Internet1' -To 'CompanyAO365' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyAAD' -To 'AzureADConnectCompanyA' -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyAAD' -To 'Internet1' -ArrowsToEnabled
        New-DiagramLink -From 'CompanyAO365' -To 'OneDrive' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyAO365' -To 'SharePoint' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyAO365' -To 'Teams' -ArrowsToEnabled -ArrowsFromEnabled

        # Company 2 - Connections
        New-DiagramLink -From "ExchangeCompanyB" -To 'CompanyBO365'
        New-DiagramLink -From "CompanyBData" -To 'CompanyBO365'
        New-DiagramLink -From 'CompanyBAD' -To 'AzureADConnectCompanyB' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyBAD' -To 'Internet2' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'Internet2' -To 'CompanyBO365' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyBO365' -To 'OneDriveCompanyB' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyBO365' -To 'SharePointCompanyB' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyBO365' -To 'TeamsCompanyB' -ArrowsToEnabled -ArrowsFromEnabled
    }
} -ShowHTML
```



[![](https://evotec.xyz/wp-content/uploads/2020/12/img_5fedb0da39fe6.png)](https://evotec.xyz/wp-content/uploads/2020/12/img_5fedb0da39fe6.png)


 


As you can see, we now have two separate company infrastructures. Those are similar, but with some differences. Now let's connect those two companies with a link to the Internet.


 

```powershell
New-HTML -Online -FilePath $PSScriptRoot\MyDiagram.html {
    New-HTMLDiagram {
        # Those control layout / physics
        New-DiagramOptionsLayout -HierarchicalEnabled $true #-HierarchicalDirection FromLeftToRight
        New-DiagramOptionsPhysics -Enabled $true -HierarchicalRepulsionAvoidOverlap 1 -HierarchicalRepulsionNodeDistance 200

        # Lets add nodes to the diagram representing Company A
        New-DiagramNode -Label "Active Directory`nCompanyADawid.Local" -Id 'CompanyAAD' -Image 'https://cdn.iconscout.com/icon/premium/png-64-thumb/active-directory-1830982-1554160.png' -ImageType squareImage -Level 3
        New-DiagramNode -Label "Azure AD Connect`nCompanyADawid.Local" -Id 'AzureADConnectCompanyA' -Image 'https://cdn.iconscout.com/icon/free/png-64/azure-190760.png' -ImageType squareImage -Level 4
        New-DiagramNode -Label "Exchange`nCompanyADawid.local" -Id 'ExchangeCompanyA' -Image 'https://cdn.iconscout.com/icon/free/png-64/microsoft-exchange-2-569302.png' -ImageType squareImage -Level 4
        New-DiagramNode -Label 'Internet' -Image 'https://cdn.iconscout.com/icon/premium/png-64-thumb/internet-2102080-1768387.png' -ImageType squareImage -Id 'Internet1' -Level 2
        New-DiagramNode -Label 'Office 365 - CompanyALTD.onmicrosoft.com' -Id 'CompanyAO365' -ImageType circularImage -Image 'https://cdn.iconscout.com/icon/free/png-64/office-365-1482123-1254388.png' -Level 1
        New-DiagramNode -Label 'OneDrive' -Image 'https://cdn.iconscout.com/icon/free/png-64/onedrive-1411856-1194345.png' -ImageType squareImage -Level 0
        New-DiagramNode -Label 'Teams' -Image 'https://cdn.iconscout.com/icon/free/png-64/teams-1411850-1194339.png' -ImageType squareImage -Level 0
        New-DiagramNode -Label 'SharePoint' -Image 'https://cdn.iconscout.com/icon/free/png-64/sharepoint-1411852-1194341.png' -ImageType squareImage -Level 0

        # Lets add nodes to the diagram representing Company B
        New-DiagramNode -Label 'Internet' -Image 'https://cdn.iconscout.com/icon/premium/png-64-thumb/internet-2102080-1768387.png' -ImageType squareImage -Id 'Internet2' -Level 2
        New-DiagramNode -Label 'Office 365 - CompanyBSA.onmicrosoft.com' -ImageType circularImage -Image 'https://cdn.iconscout.com/icon/free/png-64/office-365-1482123-1254388.png' -Id 'CompanyBO365' -Level 1
        New-DiagramNode -Label "Active Directory`nCompanyB.corp" -Id 'CompanyBAD' -Image 'https://cdn.iconscout.com/icon/premium/png-64-thumb/active-directory-1830982-1554160.png' -ImageType squareImage -Level 3
        New-DiagramNode -Label "Azure AD Connect`nCompanyB.corp" -Id 'AzureADConnectCompanyB' -Image 'https://cdn.iconscout.com/icon/free/png-64/azure-190760.png' -ImageType squareImage -Level 4
        New-DiagramNode -Label 'Exchange Online' -Id 'ExchangeCompanyB' -ImageType squareImage -Image 'https://cdn.iconscout.com/icon/free/png-64/microsoft-exchange-4-896276.png' -Level 0
        New-DiagramNode -Label "OneDrive`nCompanyB" -Id 'OneDriveCompanyB' -Image 'https://cdn.iconscout.com/icon/free/png-64/onedrive-1411856-1194345.png' -ImageType squareImage -Level 0
        New-DiagramNode -Label "Teams`nCompanyB" -Id 'TeamsCompanyB' -Image 'https://cdn.iconscout.com/icon/free/png-64/teams-1411850-1194339.png' -ImageType squareImage -Level 0
        New-DiagramNode -Label "SharePoint`nCompanyB" -Id 'SharePointCompanyB' -Image 'https://cdn.iconscout.com/icon/free/png-64/sharepoint-1411852-1194341.png' -ImageType squareImage -Level 0

        # Company 1 -Connections
        New-DiagramLink -From 'ExchangeCompanyA' -To 'CompanyAAD' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'ExchangeCompanyA' -To 'Internet 2'
        New-DiagramLink -From 'Internet1' -To 'CompanyAO365' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyAAD' -To 'AzureADConnectCompanyA' -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyAAD' -To 'Internet1' -ArrowsToEnabled
        New-DiagramLink -From 'CompanyAO365' -To 'OneDrive' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyAO365' -To 'SharePoint' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyAO365' -To 'Teams' -ArrowsToEnabled -ArrowsFromEnabled

        # Company 2 - Connections
        New-DiagramLink -From "ExchangeCompanyB" -To 'CompanyBO365'
        New-DiagramLink -From "CompanyBData" -To 'CompanyBO365'
        New-DiagramLink -From 'CompanyBAD' -To 'AzureADConnectCompanyB' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyBAD' -To 'Internet2' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'Internet2' -To 'CompanyBO365' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyBO365' -To 'OneDriveCompanyB' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyBO365' -To 'SharePointCompanyB' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyBO365' -To 'TeamsCompanyB' -ArrowsToEnabled -ArrowsFromEnabled

        # Lets connect Internets together
        New-DiagramLink -From 'Internet1' -To 'Internet2' -Label 'VPN Connection' -Color Blue -Dashes
    }
} -ShowHTML
```



[![](https://evotec.xyz/wp-content/uploads/2020/12/img_5fedb1d47c505.png)](https://evotec.xyz/wp-content/uploads/2020/12/img_5fedb1d47c505.png)


 


Isn't it cool? By default, when creating **New-HTMLDiagram,** the diagram height is **400px,** and the width takes up **100% of the width** of the container it is in. This makes sure diagram resizes itself correctly when it's part of a larger structure on the **HTML** page, as **PSWriteHTML** offers a bunch of features such as **Tables**, **Charts**, **OrgCharts**, **Wizards** and many many more that allow you to not only create diagram, but make it really interactive for the end user. While width automatically resizes itself, height does not. If you're playing with a diagram and would like the diagram to fit a visible part of your browser (be it a small laptop screen or a huge 49-inch monitor you can use magic value **100vh** to make sure your diagram fits perfectly.


 

```powershell
New-HTML -Online -FilePath $PSScriptRoot\MyDiagram.html {
    New-HTMLDiagram {
        # Those control layout / physics
        New-DiagramOptionsLayout -HierarchicalEnabled $true #-HierarchicalDirection FromLeftToRight
        New-DiagramOptionsPhysics -Enabled $true -HierarchicalRepulsionAvoidOverlap 1 -HierarchicalRepulsionNodeDistance 200

        # Lets add nodes to the diagram representing Company A
        New-DiagramNode -Label "Active Directory`nCompanyADawid.Local" -Id 'CompanyAAD' -Image 'https://cdn.iconscout.com/icon/premium/png-64-thumb/active-directory-1830982-1554160.png' -ImageType squareImage -Level 3
        New-DiagramNode -Label "Azure AD Connect`nCompanyADawid.Local" -Id 'AzureADConnectCompanyA' -Image 'https://cdn.iconscout.com/icon/free/png-64/azure-190760.png' -ImageType squareImage -Level 4
        New-DiagramNode -Label "Exchange`nCompanyADawid.local" -Id 'ExchangeCompanyA' -Image 'https://cdn.iconscout.com/icon/free/png-64/microsoft-exchange-2-569302.png' -ImageType squareImage -Level 4
        New-DiagramNode -Label 'Internet' -Image 'https://cdn.iconscout.com/icon/premium/png-64-thumb/internet-2102080-1768387.png' -ImageType squareImage -Id 'Internet1' -Level 2
        New-DiagramNode -Label 'Office 365 - CompanyALTD.onmicrosoft.com' -Id 'CompanyAO365' -ImageType circularImage -Image 'https://cdn.iconscout.com/icon/free/png-64/office-365-1482123-1254388.png' -Level 1
        New-DiagramNode -Label 'OneDrive' -Image 'https://cdn.iconscout.com/icon/free/png-64/onedrive-1411856-1194345.png' -ImageType squareImage -Level 0
        New-DiagramNode -Label 'Teams' -Image 'https://cdn.iconscout.com/icon/free/png-64/teams-1411850-1194339.png' -ImageType squareImage -Level 0
        New-DiagramNode -Label 'SharePoint' -Image 'https://cdn.iconscout.com/icon/free/png-64/sharepoint-1411852-1194341.png' -ImageType squareImage -Level 0

        # Lets add nodes to the diagram representing Company B
        New-DiagramNode -Label 'Internet' -Image 'https://cdn.iconscout.com/icon/premium/png-64-thumb/internet-2102080-1768387.png' -ImageType squareImage -Id 'Internet2' -Level 2
        New-DiagramNode -Label 'Office 365 - CompanyBSA.onmicrosoft.com' -ImageType circularImage -Image 'https://cdn.iconscout.com/icon/free/png-64/office-365-1482123-1254388.png' -Id 'CompanyBO365' -Level 1
        New-DiagramNode -Label "Active Directory`nCompanyB.corp" -Id 'CompanyBAD' -Image 'https://cdn.iconscout.com/icon/premium/png-64-thumb/active-directory-1830982-1554160.png' -ImageType squareImage -Level 3
        New-DiagramNode -Label "Azure AD Connect`nCompanyB.corp" -Id 'AzureADConnectCompanyB' -Image 'https://cdn.iconscout.com/icon/free/png-64/azure-190760.png' -ImageType squareImage -Level 4
        New-DiagramNode -Label 'Exchange Online' -Id 'ExchangeCompanyB' -ImageType squareImage -Image 'https://cdn.iconscout.com/icon/free/png-64/microsoft-exchange-4-896276.png' -Level 0
        New-DiagramNode -Label "OneDrive`nCompanyB" -Id 'OneDriveCompanyB' -Image 'https://cdn.iconscout.com/icon/free/png-64/onedrive-1411856-1194345.png' -ImageType squareImage -Level 0
        New-DiagramNode -Label "Teams`nCompanyB" -Id 'TeamsCompanyB' -Image 'https://cdn.iconscout.com/icon/free/png-64/teams-1411850-1194339.png' -ImageType squareImage -Level 0
        New-DiagramNode -Label "SharePoint`nCompanyB" -Id 'SharePointCompanyB' -Image 'https://cdn.iconscout.com/icon/free/png-64/sharepoint-1411852-1194341.png' -ImageType squareImage -Level 0

        # Company 1 -Connections
        New-DiagramLink -From 'ExchangeCompanyA' -To 'CompanyAAD' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'ExchangeCompanyA' -To 'Internet 2'
        New-DiagramLink -From 'Internet1' -To 'CompanyAO365' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyAAD' -To 'AzureADConnectCompanyA' -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyAAD' -To 'Internet1' -ArrowsToEnabled
        New-DiagramLink -From 'CompanyAO365' -To 'OneDrive' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyAO365' -To 'SharePoint' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyAO365' -To 'Teams' -ArrowsToEnabled -ArrowsFromEnabled

        # Company 2 - Connections
        New-DiagramLink -From "ExchangeCompanyB" -To 'CompanyBO365'
        New-DiagramLink -From "CompanyBData" -To 'CompanyBO365'
        New-DiagramLink -From 'CompanyBAD' -To 'AzureADConnectCompanyB' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyBAD' -To 'Internet2' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'Internet2' -To 'CompanyBO365' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyBO365' -To 'OneDriveCompanyB' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyBO365' -To 'SharePointCompanyB' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyBO365' -To 'TeamsCompanyB' -ArrowsToEnabled -ArrowsFromEnabled

        # Lets connect Internets together
        New-DiagramLink -From 'Internet1' -To 'Internet2' -Label 'VPN Connection' -Color Blue -Dashes
    } -Height '100vh'
} -ShowHTML
```



[![](https://evotec.xyz/wp-content/uploads/2020/12/img_5fedb3cdc6cbc.png)](https://evotec.xyz/wp-content/uploads/2020/12/img_5fedb3cdc6cbc.png)


 


In my case, the diagram positioned itself in the middle of the screen, leaving some whitespace around the top and bottom. The **Height** **parameter** in **New-HTMLDiagram** can take multiple different values. It can be in **calc(100vh-20px)** or **800px** or any other valid **HTML** value for size. Depending on your end goal, you will need to experiment with what suits you better.







*Multiple diagrams showing migration phases of Office 365*



Now that we have learned how to create an infrastructure diagram by hand, we can show our Client how the infrastructure will change over time as the migration between two companies will happen.


 

```powershell
New-HTML -Online -FilePath $PSScriptRoot\MyDiagram.html {
    New-HTMLDiagram {
        New-DiagramOptionsLayout -HierarchicalEnabled $true #-HierarchicalDirection FromLeftToRight #-HierarchicalSortMethod directed
        New-DiagramOptionsPhysics -Enabled $true -HierarchicalRepulsionAvoidOverlap 1 -HierarchicalRepulsionNodeDistance 200

        # Company 1 - CompanyA
        New-DiagramNode -Label "Active Directory`nCompanyADawid.Local" -Id 'CompanyAAD' -Image 'https://cdn.iconscout.com/icon/premium/png-64-thumb/active-directory-1830982-1554160.png' -ImageType squareImage -Level 3
        New-DiagramNode -Label "Azure AD Connect`nCompanyADawid.Local" -Id 'AzureADConnectCompanyA' -Image 'https://cdn.iconscout.com/icon/free/png-64/azure-190760.png' -ImageType squareImage -Level 4
        New-DiagramNode -Label "Exchange`nCompanyADawid.local" -Id 'ExchangeCompanyA' -Image 'https://cdn.iconscout.com/icon/free/png-64/microsoft-exchange-2-569302.png' -ImageType squareImage -Level 4
        New-DiagramNode -Label 'Internet' -Image 'https://cdn.iconscout.com/icon/premium/png-64-thumb/internet-2102080-1768387.png' -ImageType squareImage -Id 'Internet1' -Level 2
        New-DiagramNode -Label 'Office 365 - CompanyADavidLTD.onmicrosoft.com' -Id 'CompanyAO365' -ImageType circularImage -Image 'https://cdn.iconscout.com/icon/free/png-64/office-365-1482123-1254388.png' -Level 1
        New-DiagramNode -Label 'OneDrive' -Image 'https://cdn.iconscout.com/icon/free/png-64/onedrive-1411856-1194345.png' -ImageType squareImage -Level 0
        New-DiagramNode -Label 'Teams' -Image 'https://cdn.iconscout.com/icon/free/png-64/teams-1411850-1194339.png' -ImageType squareImage -Level 0
        New-DiagramNode -Label 'SharePoint' -Image 'https://cdn.iconscout.com/icon/free/png-64/sharepoint-1411852-1194341.png' -ImageType squareImage -Level 0

        # Company 2 - CompanyB
        New-DiagramNode -Label 'Internet' -Image 'https://cdn.iconscout.com/icon/premium/png-64-thumb/internet-2102080-1768387.png' -ImageType squareImage -Id 'Internet2' -Level 2
        New-DiagramNode -Label 'Office 365 - CompanyBSA.onmicrosoft.com' -ImageType circularImage -Image 'https://cdn.iconscout.com/icon/free/png-64/office-365-1482123-1254388.png' -Id 'CompanyBO365' -Level 1
        New-DiagramNode -Label "Active Directory`nCompanyB.corp" -Id 'CompanyBAD' -Image 'https://cdn.iconscout.com/icon/premium/png-64-thumb/active-directory-1830982-1554160.png' -ImageType squareImage -Level 3
        New-DiagramNode -Label "Azure AD Connect`nCompanyB.corp" -Id 'AzureADConnectCompanyB' -Image 'https://cdn.iconscout.com/icon/free/png-64/azure-190760.png' -ImageType squareImage -Level 4
        New-DiagramNode -Label 'Exchange Online' -Id 'ExchangeCompanyB' -ImageType squareImage -Image 'https://cdn.iconscout.com/icon/free/png-64/microsoft-exchange-4-896276.png' -Level 0
        New-DiagramNode -Label "OneDrive`nCompanyB" -Id 'OneDriveCompanyB' -Image 'https://cdn.iconscout.com/icon/free/png-64/onedrive-1411856-1194345.png' -ImageType squareImage -Level 0
        New-DiagramNode -Label "Teams`nCompanyB" -Id 'TeamsCompanyB' -Image 'https://cdn.iconscout.com/icon/free/png-64/teams-1411850-1194339.png' -ImageType squareImage -Level 0
        New-DiagramNode -Label "SharePoint`nCompanyB" -Id 'SharePointCompanyB' -Image 'https://cdn.iconscout.com/icon/free/png-64/sharepoint-1411852-1194341.png' -ImageType squareImage -Level 0


        # Company 1 -Connections
        New-DiagramLink -From 'ExchangeCompanyA' -To 'CompanyAAD' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'ExchangeCompanyA' -To 'Internet 2'
        New-DiagramLink -From 'Internet1' -To 'CompanyAO365' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyAAD' -To 'AzureADConnectCompanyA' -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyAAD' -To 'Internet1' -ArrowsToEnabled
        New-DiagramLink -From 'CompanyAO365' -To 'OneDrive' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyAO365' -To 'SharePoint' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyAO365' -To 'Teams' -ArrowsToEnabled -ArrowsFromEnabled

        # Company 2 - Connections
        New-DiagramLink -From "ExchangeCompanyB" -To 'CompanyBO365'
        New-DiagramLink -From "CompanyBData" -To 'CompanyBO365'
        New-DiagramLink -From 'CompanyBAD' -To 'AzureADConnectCompanyB' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyBAD' -To 'Internet2' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'Internet2' -To 'CompanyBO365' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyBO365' -To 'OneDriveCompanyB' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyBO365' -To 'SharePointCompanyB' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyBO365' -To 'TeamsCompanyB' -ArrowsToEnabled -ArrowsFromEnabled

        # Lets connect Internets together
        New-DiagramLink -From 'Internet1' -To 'Internet2' -Label 'VPN Connection' -Color Blue -Dashes

        # Step 1
        New-DiagramLink -From 'ExchangeCompanyA' -To 'CompanyBO365' -Dashes -Color Blue -Label 'Setup of Hybrid' -FontColor Blue -FontAlign middle
        New-DiagramLink -From 'AzureADConnectCompanyB' -To 'CompanyAAD' -ArrowsToEnabled -ArrowsFromEnabled -Label 'Via VPN connection' -Dashes -Color Green -FontColor Green -FontAlign middle

    } -Height 'calc(100vh - 20px)'
} -ShowHTML
```



[![](https://evotec.xyz/wp-content/uploads/2020/12/img_5fedf8a3c06b0.png)](https://evotec.xyz/wp-content/uploads/2020/12/img_5fedf8a3c06b0.png)


 


We have added a few additional links that show the setup of **Exchange hybrid** and make it clear that **Azure AD Connect** of Company B connects to Company A Active Directory using a VPN connection. On the next diagram, we will show how data will be migrating between two Office 365 tenants. Notice that I am mostly defining new links and not changing nodes. Additionally, in earlier diagrams, I've made connections that were done using straight lines. In the next case, I'm using the **SmoothType** parameter to make links **curved**, as otherwise, it wouldn't be as visually attractive.


 

```powershell
New-HTML -Online -FilePath $PSScriptRoot\MyDiagram.html {
    New-HTMLDiagram {
        New-DiagramOptionsLayout -HierarchicalEnabled $true #-HierarchicalDirection FromLeftToRight #-HierarchicalSortMethod directed
        New-DiagramOptionsPhysics -Enabled $true -HierarchicalRepulsionAvoidOverlap 1 -HierarchicalRepulsionNodeDistance 200

        # Company 1 - CompanyA
        New-DiagramNode -Label "Active Directory`nCompanyADawid.Local" -Id 'CompanyAAD' -Image 'https://cdn.iconscout.com/icon/premium/png-64-thumb/active-directory-1830982-1554160.png' -ImageType squareImage -Level 3
        New-DiagramNode -Label "Azure AD Connect`nCompanyADawid.Local" -Id 'AzureADConnectCompanyA' -Image 'https://cdn.iconscout.com/icon/free/png-64/azure-190760.png' -ImageType squareImage -Level 4
        New-DiagramNode -Label "Exchange`nCompanyADawid.local" -Id 'ExchangeCompanyA' -Image 'https://cdn.iconscout.com/icon/free/png-64/microsoft-exchange-2-569302.png' -ImageType squareImage -Level 4
        New-DiagramNode -Label 'Internet' -Image 'https://cdn.iconscout.com/icon/premium/png-64-thumb/internet-2102080-1768387.png' -ImageType squareImage -Id 'Internet1' -Level 2
        New-DiagramNode -Label 'Office 365 - CompanyADavidLTD.onmicrosoft.com' -Id 'CompanyAO365' -ImageType circularImage -Image 'https://cdn.iconscout.com/icon/free/png-64/office-365-1482123-1254388.png' -Level 1
        New-DiagramNode -Label 'OneDrive' -Image 'https://cdn.iconscout.com/icon/free/png-64/onedrive-1411856-1194345.png' -ImageType squareImage -Level 0
        New-DiagramNode -Label 'Teams' -Image 'https://cdn.iconscout.com/icon/free/png-64/teams-1411850-1194339.png' -ImageType squareImage -Level 0
        New-DiagramNode -Label 'SharePoint' -Image 'https://cdn.iconscout.com/icon/free/png-64/sharepoint-1411852-1194341.png' -ImageType squareImage -Level 0

        # Company 2 - CompanyB
        New-DiagramNode -Label 'Internet' -Image 'https://cdn.iconscout.com/icon/premium/png-64-thumb/internet-2102080-1768387.png' -ImageType squareImage -Id 'Internet2' -Level 2
        New-DiagramNode -Label 'Office 365 - CompanyBSA.onmicrosoft.com' -ImageType circularImage -Image 'https://cdn.iconscout.com/icon/free/png-64/office-365-1482123-1254388.png' -Id 'CompanyBO365' -Level 1
        New-DiagramNode -Label "Active Directory`nCompanyB.corp" -Id 'CompanyBAD' -Image 'https://cdn.iconscout.com/icon/premium/png-64-thumb/active-directory-1830982-1554160.png' -ImageType squareImage -Level 3
        New-DiagramNode -Label "Azure AD Connect`nCompanyB.corp" -Id 'AzureADConnectCompanyB' -Image 'https://cdn.iconscout.com/icon/free/png-64/azure-190760.png' -ImageType squareImage -Level 4
        New-DiagramNode -Label 'Exchange Online' -Id 'ExchangeCompanyB' -ImageType squareImage -Image 'https://cdn.iconscout.com/icon/free/png-64/microsoft-exchange-4-896276.png' -Level 0
        New-DiagramNode -Label "OneDrive`nCompanyB" -Id 'OneDriveCompanyB' -Image 'https://cdn.iconscout.com/icon/free/png-64/onedrive-1411856-1194345.png' -ImageType squareImage -Level 0
        New-DiagramNode -Label "Teams`nCompanyB" -Id 'TeamsCompanyB' -Image 'https://cdn.iconscout.com/icon/free/png-64/teams-1411850-1194339.png' -ImageType squareImage -Level 0
        New-DiagramNode -Label "SharePoint`nCompanyB" -Id 'SharePointCompanyB' -Image 'https://cdn.iconscout.com/icon/free/png-64/sharepoint-1411852-1194341.png' -ImageType squareImage -Level 0


        # Company 1 -Connections
        New-DiagramLink -From 'ExchangeCompanyA' -To 'CompanyAAD' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'ExchangeCompanyA' -To 'Internet 2'
        New-DiagramLink -From 'Internet1' -To 'CompanyAO365' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyAAD' -To 'AzureADConnectCompanyA' -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyAAD' -To 'Internet1' -ArrowsToEnabled
        New-DiagramLink -From 'CompanyAO365' -To 'OneDrive' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyAO365' -To 'SharePoint' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyAO365' -To 'Teams' -ArrowsToEnabled -ArrowsFromEnabled

        # Company 2 - Connections
        New-DiagramLink -From "ExchangeCompanyB" -To 'CompanyBO365'
        New-DiagramLink -From "CompanyBData" -To 'CompanyBO365'
        New-DiagramLink -From 'CompanyBAD' -To 'AzureADConnectCompanyB' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyBAD' -To 'Internet2' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'Internet2' -To 'CompanyBO365' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyBO365' -To 'OneDriveCompanyB' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyBO365' -To 'SharePointCompanyB' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyBO365' -To 'TeamsCompanyB' -ArrowsToEnabled -ArrowsFromEnabled


        # Lets connect Internets together
        New-DiagramLink -From 'Internet1' -To 'Internet2' -Label 'VPN Connection' -Color Blue -Dashes

        # Step 1
        New-DiagramLink -From 'AzureADConnectCompanyB' -To 'CompanyAAD' -ArrowsToEnabled -ArrowsFromEnabled -Label 'Via VPN connection' -Dashes -Color Green -FontColor Green -FontAlign middle

        # Step 2
        New-DiagramNode -Label "Exchange`nUsers From`nCompanyADawid.local" -Id 'ExchangeCompanyAUsers' -Image 'https://cdn.iconscout.com/icon/free/png-64/microsoft-exchange-2-569302.png' -ImageType squareImage -Level -1
        New-DiagramLink -From 'ExchangeCompanyB' -To 'ExchangeCompanyAUsers' -ArrowsFromEnabled

        # Step 3
        New-DiagramLink -From 'OneDrive' -To 'OneDriveCompanyB' -SmoothType curvedCW -Label "Migrate OneDrive`n using Mover.io" -ArrowsToEnabled -Dashes
        New-DiagramLink -From 'SharePoint' -To 'SharePointCompanyB' -SmoothType curvedCW -Label "Migrate SharePoint`n using ?" -ArrowsToEnabled -Dashes
        New-DiagramLink -From 'Teams' -To 'TeamsCompanyB' -SmoothType curvedCW -Label "Migrate Teams`n Manually" -ArrowsToEnabled -Dashes

    } -Height 'calc(100vh - 20px)'
} -ShowHTML
```



[![](https://evotec.xyz/wp-content/uploads/2020/12/img_5fedf92809f0b.png)](https://evotec.xyz/wp-content/uploads/2020/12/img_5fedf92809f0b.png)


 


For the last diagram, I've decided to show how migration ends and how the infrastructure will look after two companies merged. I had to remove some nodes and change few links – but as you see, we're still operating using the same 5 cmdlets over and over again.


 

```powershell
New-HTML -Online -FilePath $PSScriptRoot\MyDiagram.html {
    New-HTMLDiagram {
        New-DiagramOptionsLayout -HierarchicalEnabled $true #-HierarchicalDirection FromLeftToRight #-HierarchicalSortMethod directed
        New-DiagramOptionsPhysics -Enabled $true -HierarchicalRepulsionAvoidOverlap 1 -HierarchicalRepulsionNodeDistance 200

        # Company 1 - CompanyA
        New-DiagramNode -Label "Active Directory`nCompanyADawid.Local" -Id 'CompanyAAD' -Image 'https://cdn.iconscout.com/icon/premium/png-64-thumb/active-directory-1830982-1554160.png' -ImageType squareImage -Level 3
        New-DiagramNode -Label 'Internet' -Image 'https://cdn.iconscout.com/icon/premium/png-64-thumb/internet-2102080-1768387.png' -ImageType squareImage -Id 'Internet1' -Level 2

        # Company 2 - CompanyB
        New-DiagramNode -Label 'Internet' -Image 'https://cdn.iconscout.com/icon/premium/png-64-thumb/internet-2102080-1768387.png' -ImageType squareImage -Id 'Internet2' -Level 2
        New-DiagramNode -Label 'Office 365 - CompanyBSA.onmicrosoft.com' -ImageType circularImage -Image 'https://cdn.iconscout.com/icon/free/png-64/office-365-1482123-1254388.png' -Id 'CompanyBO365' -Level 1
        New-DiagramNode -Label "Active Directory`nCompanyB.corp" -Id 'CompanyBAD' -Image 'https://cdn.iconscout.com/icon/premium/png-64-thumb/active-directory-1830982-1554160.png' -ImageType squareImage -Level 3
        New-DiagramNode -Label "Azure AD Connect`nCompanyB.corp" -Id 'AzureADConnectCompanyB' -Image 'https://cdn.iconscout.com/icon/free/png-64/azure-190760.png' -ImageType squareImage -Level 4
        New-DiagramNode -Label "Exchange Online`nCompanyB & CompanyA" -Id 'ExchangeCompanyB' -ImageType squareImage -Image 'https://cdn.iconscout.com/icon/free/png-64/microsoft-exchange-4-896276.png' -Level 0
        New-DiagramNode -Label "OneDrive`nCompanyB & CompanyA" -Id 'OneDriveCompanyB' -Image 'https://cdn.iconscout.com/icon/free/png-64/onedrive-1411856-1194345.png' -ImageType squareImage -Level 0
        New-DiagramNode -Label "Teams`nCompanyB & CompanyA" -Id 'TeamsCompanyB' -Image 'https://cdn.iconscout.com/icon/free/png-64/teams-1411850-1194339.png' -ImageType squareImage -Level 0
        New-DiagramNode -Label "SharePoint`nCompanyB & CompanyA" -Id 'SharePointCompanyB' -Image 'https://cdn.iconscout.com/icon/free/png-64/sharepoint-1411852-1194341.png' -ImageType squareImage -Level 0

        # Company 1 -Connections
        New-DiagramLink -From 'CompanyAAD' -To 'AzureADConnectCompanyA' -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyAAD' -To 'Internet1' -ArrowsToEnabled

        # Company 2 - Connections
        New-DiagramLink -From "ExchangeCompanyB" -To 'CompanyBO365'
        New-DiagramLink -From "CompanyBData" -To 'CompanyBO365'
        New-DiagramLink -From 'CompanyBAD' -To 'AzureADConnectCompanyB' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyBAD' -To 'Internet2' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'Internet2' -To 'CompanyBO365' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyBO365' -To 'OneDriveCompanyB' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyBO365' -To 'SharePointCompanyB' -ArrowsToEnabled -ArrowsFromEnabled
        New-DiagramLink -From 'CompanyBO365' -To 'TeamsCompanyB' -ArrowsToEnabled -ArrowsFromEnabled

        # Lets connect Internets together
        New-DiagramLink -From 'Internet1' -To 'Internet2' -Label 'VPN Connection' -Color Blue -Dashes

        # Final link for AD Connect
        New-DiagramLink -From 'AzureADConnectCompanyB' -To 'CompanyAAD' -ArrowsToEnabled -ArrowsFromEnabled -Label 'Via VPN connection' -Dashes -Color Green -FontColor Green

    } -Height 'calc(100vh - 20px)'
} -ShowHTML
```



[![](https://evotec.xyz/wp-content/uploads/2020/12/img_5fedf97c17552.png)](https://evotec.xyz/wp-content/uploads/2020/12/img_5fedf97c17552.png)


 


When I started working on this diagram, I wasn't sure I would pull it off – it's fair to say I feel I could achieve my goal. Usually, I used [PSWriteHTML](https://github.com/EvotecIT/PSWriteHTML) to automatically generate diagrams of [Active Directory Group Membership](https://evotec.xyz/visually-display-active-directory-nested-group-membership-using-powershell/) or [Active Directory Trusts](https://evotec.xyz/visually-display-active-directory-trusts-using-powershell/) entirely autogenerated from Active Directory. Still, building something manually that could entirely replace Visio in some situations was a new one for me. While this blog post focuses on creating a diagram, it's straightforward to incorporate other features of PSWriteHTML – but I'll leave that for another day. Feel free to experiment – shall you have any questions/feedback/feature requests, please open [GitHub](https://github.com/EvotecIT/PSWriteHTML) issues.







*Earlier resources for PSWriteHTML*



If you would like to learn more about **PSWriteHTML**, **Dashimo**, **Emailimo,** or **Out-HTMLView**, please read those articles below to understand how you can use its power to fulfill your goals.


 

- [Meet Statusimo – PowerShell generated Status Page](https://evotec.xyz/meet-statusimo-powershell-generated-status-page/)
- [Meet Dashimo – PowerShell Generated Dashboard](https://evotec.xyz/meet-dashimo-powershell-generated-dashboard/)
- [Dashimo – Easy Table Conditional Formatting and more](https://evotec.xyz/dashimo-easy-table-conditional-formatting-and-more/)
- [Out-HtmlView – HTML alternative to Out-GridView](https://evotec.xyz/out-htmlview-html-alternative-to-out-gridview/)
- [Meet Emailimo – New way to send pretty emails with PowerShell](https://evotec.xyz/meet-emailimo-new-way-to-send-pretty-emails-with-powershell/)
- [All your HTML Tables are belong to us](https://evotec.xyz/all-your-html-tables-are-belong-to-us/)
- [Sending HTML emails with PowerShell and zero HTML knowledge required](https://evotec.xyz/sending-html-emails-with-powershell-and-zero-html-knowledge-required/)
- [Dashimo (PSWriteHTML) – Charting, Icons and few other changes](https://evotec.xyz/dashimo-pswritehtml-charting-icons-and-few-other-changes/)
- [Working with HTML in PowerShell just got better](https://evotec.xyz/working-with-html-in-powershell-just-got-better/)
- [Comparing two or more objects visually in PowerShell (cross-platform)](https://evotec.xyz/comparing-two-or-more-objects-visually-in-powershell-cross-platform/)
- [Easy way to create diagrams using PowerShell and PSWriteHTML](https://evotec.xyz/easy-way-to-create-diagrams-using-powershell-and-pswritehtml/)
- [Nested Tabs, Diagram Updates, Diagram Events, Calendar Object and more in PSWriteHTML](https://evotec.xyz/nested-tabs-diagram-updates-diagram-events-calendar-object-and-more-in-pswritehtml/)
- [Emailimo merged into PSWriteHTML, IE support and no dependencies](https://evotec.xyz/emailimo-merged-into-pswritehtml-ie-support-and-no-dependencies/)





To run – install it from **PowerShellGallery, **and you're good. Please remember that **Emailimo** & **Dashimo** are “integrated” in PSWriteHTML, and there's no reason to do a separate install if you would like to use those.


 

```powershell
Install-Module PSWriteHTML -Force
```





