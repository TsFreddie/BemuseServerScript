Get-ChildItem $args[0] -Directory | ForEach-Object {
    $Folder = "$($_.FullName)\"
    $Done_Pattern = "$($_.FullName)\assets\*.bemuse"
    if (!(Test-Path $Done_Pattern)) {
        Write-Output "Packing $($_.Name)"
        bemuse-tools pack $Folder
    } else {
        Write-Output "Skipping $($_.Name)"
    }
}
