# specify the minumum required major PowerShell version that the build script should validate
[int]$script:requiredPSVersion = '5'
Add-BuildTask PostInit -After Init {
    $ProjectName = $script:ModuleName
    $Repo = Get-GitHubRepository -OrganizationName 'Riot-Enterprises' -RepositoryName $ProjectName
    $HashArguments = @{
        OwnerName      = $Repo.owner.UserName
        RepositoryName = $Repo.name
        BranchName     = 'main'
    }
    $StatusChecks = Get-ChildItem (Join-Path $ProjectRoot '.github/workflows/*.yml') |
    Select-String '(?:name:\s+?)(Run Test.*?$)' |
    Select-Object -ExpandProperty matches |
    Select-Object -ExpandProperty Groups |
    Where-Object name -eq  1 |
    Select-Object -ExpandProperty Value
    New-GitHubRepositoryBranchProtectionRule @HashArguments -StatusChecks $StatusChecks -EnforceAdmins
    Write-Build Green "      ...Repository Rules added successfully"
}

Add-BuildTask Init {
    Write-Build White '      Initialising Repository'
    $ProjectRoot = Split-Path -Path $BuildRoot -Parent
    $ProjectName = $script:ModuleName
    Push-Location $ProjectRoot
    $Repo = New-GitHubRepository -OrganizationName 'Riot-Enterprises' -RepositoryName $ProjectName
    if (!(Test-Path README.md)){
        Set-Content -Path README.md -Value "# $ProjectName"
    }
    git init
    git add README.md
    git commit -m "Initial commit"
    git branch -M main
    git remote add origin $repo.clone_url
    git push -u origin main
    git checkout -b Initial_Template
    Pop-Location
    Write-Build Green "      ...Repository initialiased successfully"
}