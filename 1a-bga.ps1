Get-ChildItem $args[0] -Directory | ForEach-Object {
    $Folder = "$($_.FullName)\"
    $TargetName = "$($Folder)bga_tmp.mp4"
    $LockTarget = "$($Folder)bga.mp4"

    if (Test-Path "..\Bemuse_Organize\$($_.Name)\bga.mp4") {
        Write-Output "Skipping BGA: $($_.Name) [Organized]"
    } else {
        if (!(Test-Path $LockTarget)) {
            Write-Output "Converting BGA: $($_.Name)"

            Get-ChildItem $Folder | where {$_.extension -in ".wmv",".avi"} | Select-Object -First 1 | ForEach-Object {
                ffmpeg -i "$($Folder)$($_.Name)" -c:v h264_nvenc -b:v 750k -minrate 375k -maxrate 1088k -preset slow -g 150 -pass 1 -f mp4 -an -y nul
                ffmpeg -i "$($Folder)$($_.Name)" -c:v h264_nvenc -b:v 750k -minrate 375k -maxrate 1088k -preset slow -g 150 -pass 2 -f mp4 -an -y $TargetName
                Rename-Item -Path $TargetName -NewName "bga.mp4"
            }

        } else {
            Write-Output "Skipping BGA: $($_.Name)"
        }
    }
}
