#Simple script to get the contents of the Windows directory and write them to a file on their desktop
$directoryListing = Get-ChildItem $env:WINDIR
$directoryListing | Out-File $($env:USERPROFILE + "\Desktop\WindowsDirectoryListing.txt")