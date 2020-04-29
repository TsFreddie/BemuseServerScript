Get-ChildItem $args[0] -Directory | ForEach-Object -Parallel {
    $TARGET_DIR = $_.FullName
    $NEW_NAME = & node .\folder_name.js "$($_.Name)"
    Write-Output $NEW_NAME

    if ($NEW_NAME -ne $_.Name) {
        Rename-Item -Path $_.FullName -NewName $NEW_NAME
    }
}