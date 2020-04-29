Get-ChildItem $args[0] -Directory | ForEach-Object {
    New-Item -ItemType Directory -Force -Path "..\Bemuse_Organize\$($_.Name)\"
    if (Test-Path "$($_.FullName)\assets") {
        Move-Item -Path "$($_.FullName)\assets" -Destination "..\Bemuse_Organize\$($_.Name)\assets" -Force
    }
    if (Test-Path "$($_.FullName)\bga.mp4") {
        Move-Item -Path "$($_.FullName)\bga.mp4" -Destination "..\Bemuse_Organize\$($_.Name)\bga.mp4" -Force
    }
    if (Test-Path "$($_.FullName)\*.bme") {
        Copy-Item -Path "$($_.FullName)\*.bme" -Destination "..\Bemuse_Organize\$($_.Name)\" -Force
    }
    # if (Test-Path ".\$($_.Name)\*.bms") {
    #     Copy-Item -Path ".\$($_.Name)\*.bms" -Destination "..\Bemuse_Organize\$($_.Name)\" -Force
    # }
}
