Get-ChildItem $args[0] -Directory | ForEach-Object -Parallel {
    $TARGET_DIR = $_.FullName
    Get-ChildItem $TARGET_DIR -Filter "*.bme" | ForEach-Object -Parallel {
        node ".\bme-process.js" $_.FullName
    }
}