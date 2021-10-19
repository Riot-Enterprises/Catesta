# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.12.4]

- ```*.build.ps1```
  - Test task now correctly references ```$script:UnitTestsPath``` instead of overall ```$script:TestsPath```
  - DevCC task now correctly references ```$script:UnitTestsPath``` instead of ```'Tests\Unit'```
  - Infra task now correctly references ```$script:InfraTestsPath``` instead of ```'Tests\Infrastructure'```
  - Adjusted ValidateRequirements task to work with ```[version]``` type when verifying minimum version of PowerShell to validate
  - Added new BuildNoInfra task for building module without running Infra tests
- ```tasks.json```
  - Added new VSCode tasks
    - BuildNoInfra - runs BuildNoInfra tasks
    - Pester-Single-Coverage - enables user to run pester test for single function and get code coverage report
    - Pester-Single-Detailed - enables user to run pester test for single function and get detailed results
    - DevCC-Single - enables user to generate cov.xml coverage file for single function

## [0.12.1]

- Changed the Pester 5 minimum version requirement from ```v5.0.0``` to ```v5.2.2```
- Updated CloudFormation GitHub template to use CodeBuild image version 5.0.

## [0.12.0]

- Catesta template module changes
  - **Added support for Pester 5** - you can now choose either Pester 4 or Pester 5 in a prompt when creating a module or vault with Catesta.
    - Some CICD containers have the Pester module loaded into memory. Added explicit remove in the build file to account for this.
    - Moved Pester import handling from the buildspec/yaml to InvokeBuild
  - Updated pester tests that were using legacy Should syntax (without dashes)
  - Fixed ```tasks.json``` VSCode file to be valid json (was missing comma)
  - Added prompt on ModuleOnly module type to prompt user if they want helpful .vscode files for their module project
  - Catesta now deploys the initial sample module in a style that better reflects a real-world module
    - The private sample function was renamed to Get-Day and gets the day of the week
    - The public sample function now returns hello world with the day of the week included
    - Sample tests are now created for these sample functions in the appropriate public/private folders under the Tests/Unit folder
    - Sample tests now actually test the sample functions
  - AppVeyor CI/CD changes:
    - Updated Ubuntu image from ```Ubuntu1804``` to ```Ubuntu2004```
  - Azure DevOps CI/CD changes:
    - The latest macOS image [now includes PowerShell](https://github.com/actions/virtual-environments/blob/main/images/macos/macos-10.15-Readme.md) by default - removed step in yaml to install PowerShell.
  - AWS CodeBuild CI/CD changes:
    - CB Linux Image updated in CFN from ```Image: aws/codebuild/standard:4.0``` to use latest: ```Image: aws/codebuild/standard:5.0```
    - Updated buildspec_pwsh_windows.yml to use the new syntax for installing PowerShell 7.

      ```bash
      runtime-versions:
        dotnet: 3.1
      ```

    - Added additional documentation links to the buildspec files
  - InvokeBuild bumped from ```5.6.1``` to ```5.8.0```
- Catesta primary module changes
  - Updated pester tests that were using Legacy Should syntax (without dashes)
  - Updated pester tests to support v5+
  - InvokeBuild bumped from ```5.6.1``` to ```5.8.0```

## [0.11.0]

- Adjusted vault templates to include the new capabilities in SecretManagement RC2
  - New optional cmdlets
  - New metadata parameter on several cmdlets
- Added new optional vault parent .psm1 example file
- Catesta now references the GA version of ```Microsoft.PowerShell.SecretManagement```
- Added best practice naming suggestion to ```New-VaultProject```
- Corrected verbiage on several commands to properly reflect which module project was being scaffold
- Fixed bug where module would fail to scaffold on Linux systems due to case sensitivity of path

## [0.10.2]

- Adjusted addition of .gitignore file to be indirectly referenced due to PSGallery behavior of not including the .gitignore in the resource files

## [0.10.1]

- No change, redeployment due to missing .gitignore file in PowerShell gallery 0.10.2 version.

## [0.10.0]

- New features:
  - Added **New-VaultProject** - Catesta now supports creating a PowerShell SecretManagement vault module project that adheres to community best practices.
- Bug fixes:
  - Fixed bug in plaster manifests where repository template options were not being presented as a choice
  - Fixed bug in *.build.ps1 causing build to fail
    - This bug was related to the overwrite of the parent level md docs. Build would fail if run before markdown help had been generated.
- Updates:
  - plaster manifest versions will now match Catesta module version
  - Added additional basic manifest checks to *PSModule*-Module.Tests.ps1
  - Updated buildspec_pwsh_windows.yml to utilize dotnet pwsh 7 install
  - For all CI/CD actions using Windows PowerShell the latest NuGet and PowerShellGet will be installed.

## [0.9.7]

- Catesta template module changes
  - Fixed missing !Sub Intrinsic function reference in PowerShellCodeBuildGit.yml
  - Improved error message when modules fail to install with install_modules.ps1 and actions_bootstrap.ps1
  - Improved output message when missing help information found during *.build.ps1
  - Improved PSModule.build.ps1
    - Resolved bug where CreateMarkdownHelp fails if module not imported
    - Added additional checks for missing markdown documentation
    - Added build steps which import the module manifest explicitly
    - Corrected output in AnalyzeTests to not write out the word green
    - Parent level markdown docs will now be updated on each build
  - Adjusted ExportedFunctions.Tests.ps1 to check for included example rather than example count
- Catesta primary module changes
  - Improved PSModule.build.ps1
    - Resolved bug where CreateMarkdownHelp fails if module not imported
    - Added additional checks for missing markdown documentation
    - Added build steps which import the module manifest explicitly
    - Adjusted ExportedFunctions.Tests.ps1 to check for included example rather than example count
- Updated a few areas of documentation/help to provide more clarification
- Updated .vscode settings to use ```${workspaceFolderBasename}``` instead of hard-coded Catesta name

## [0.9.0]

- Catesta primary module changes
  - ExportedFunctions.Tests.ps1 - Corrected 2 bugs in Exported Commands test
    - Didn't correctly identify all commands
    - Didn't support example checks in PowerShell 5.1
  - Catesta manifest updates
    - Updated to use more recent versions of required modules
    - Sorted tags alphabetically
  - Catesta.build.ps1
    - Updated verbiage in ValidateRequirements to correctly reflect version of PowerShell required
    - Updated Add-BuildTask Test to output Pester test outputfile to testOutput location
    - Updated Add-BuildTask Test to correctly output Pester code coverage file
  - Updated tasks.json to reference ${workspaceFolder}
- Catesta template module changes
  - Build updates
    - Corrected 2 bugs in Exported Commands test
      - Didn't correctly identify all commands
      - Didn't support example checks in PowerShell 5.1
    - PSModule.build.ps1
      - Updated verbiage in ValidateRequirements to correctly reflect version of PowerShell required
      - Updated Add-BuildTask Test to output Pester test outputfile to testOutput location
      - Updated Add-BuildTask Test to correctly output Pester code coverage file
  - AWS Updates
    - Updated CFN deployments to use latest CodeBuild Images (2019)
      - windows-base:1.0 --> windows-base:2019-1.0
    - Updated buildspec_pwsh_windows.yml to download PowerShell 7.0.3 instead of 7.0.0
    - Updated module references to latest version
    - Added AWS.Tools.Common to install_modules.ps1
    - Added $PSVersionTable to pre_build commands of all yml files
    - Added support for Pester report groups in CodeBuild
    - Added support for Code Coverage reports groups in CodeBuild
  - Azure Updates
    - Added clarifying display names to each task
    - Added support for publishing test results
    - Added support for Code Coverage report
    - Updated actions_bootstrap.ps1 to install latest module versions
    - For windows PowerShell based build added line to remove Pester 5 and Import Pester 4.10.1 specifically.
    - Added support for attaching build artifact of Archived module build
  - GitHub Actions
    - Updated actions_bootstrap.ps1 to install latest module versions
    - Added name to all workflows for check out step
    - Changed checkout on all workflows from v1 to v2
    - Added pester test results artifact upload to all workflows
    - Renamed windows workflow that was using pwsh to ActionsTest-Windows-pwsh-Build
    - For windows PowerShell based build added line to remove Pester 5 and Import Pester 4.10.1 specifically.
  - Appveyor Updates
    - Updated actions_bootstrap.ps1 to install latest module versions
    - For windows PowerShell based build added line to remove Pester 5 and Import Pester 4.10.1 specifically.
    - Added support for all appveyor builds to include PesterTest, CodeCoverage, and build artifacts
- Editor updates
  - Added InvokeBuild tasks to tasks.json

## [0.8.12]

- Updated Pester and InvokeBuild module references to latest versions
- AWS:
  - buildspec_pwsh_windows.yml now uses PowerShell 7 instead of PowerShell 6.3
- Minor build updates:
  - Updated tasks.json for better integration with InvokeBuild

## [0.8.10]

- Added link to the online function documentation for New-PowerShellProject as its first link so it will open directly when `Get-Help -Name New-PowerShellProject -Online` is called.

## [0.8.9]

- Bug fix - After build the Imports.ps1 file was being left in the artifacts folder. It will now be removed after build is completed.
- Bug fix - when AWS CI/CD was chosen and an S3 bucket was provided for module install the modules were not correctly downloading to the build container. Fixed temp path issue and bucket name quotes added.
- Bug fix - Build file when running in 5.1 was not honoring the "*.ps1" filter and would pick up files like ps1xml. Changed to a regex so that both 5.1 and higher versions work. This was causing ps1xml files to merged into the psm1 during build.
- Bug fix - Fixed Module name not being replaced in SampleInfraTest.Tests.ps1

## [0.8.5]

- Corrected bug where AWS CI/CD choice was not correctly populating S3 bucket name for install_modules.ps1
- Bumped module references to latest versions

## [0.8.4]

- Added Manifest File to Invoke-Build buildheader
- Added Manifest version to Invoke-Build buildheader
- Corrected bug in Catesta's build process that wasn't displaying Manifest info in the buildheader

## [0.8.3]

- Moved Infrastructure tests from pre-build to post build
  - Included sample Infrastructure test that references artifacts location for import for post-build import.
- Corrected spelling error in Tests folder: Infrastructure to Infrastructure

## [0.8.0]

- Initial release.
