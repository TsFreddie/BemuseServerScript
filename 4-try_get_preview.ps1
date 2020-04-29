$IIDX_SOUND_FOLDER = $args[1]
Get-ChildItem $args[0] -Directory | ForEach-Object {
    $TARGET_DIR = $_.FullName
    $TARGET_SONG = $_.Name
    $TARGET_PRE = "..\Bemuse_Organize\$($TARGET_SONG)\_bemuse_preview.mp3"
    if (Test-Path "..\Bemuse_Organize\$($TARGET_SONG)\") {
        if (!(Test-Path $TARGET_PRE)){
            Get-ChildItem $TARGET_DIR -Filter "*.bme" | Select-Object -First 1 | ForEach-Object {
                if ($_.Name -match [regex]"^\D*([0-9]+)\D*$") {
                    $SONG_ID = $Matches[1]
                    $IIDX_PRE_LOC = "$($IIDX_SOUND_FOLDER)\$($SONG_ID)\$($SONG_ID)_pre.2dx"
                    $IIDX_IFS_LOC = "$($IIDX_SOUND_FOLDER)\$($SONG_ID).ifs"
                    if (Test-Path $IIDX_PRE_LOC) {
                        2dx_extract $IIDX_PRE_LOC
                        ffmpeg -i "1.wav" -b:a 128k -filter:a "volume=0.65" "..\Bemuse_Organize\$($TARGET_SONG)\_bemuse_preview_tmp.mp3" -y
                        Rename-Item -Path "..\Bemuse_Organize\$($TARGET_SONG)\_bemuse_preview_tmp.mp3" -NewName "_bemuse_preview.mp3" -Force
                        Remove-Item "1.wav"
                    } elseif (Test-Path $IIDX_IFS_LOC) {
                        ifstools $IIDX_IFS_LOC -o "$($env:TEMP)" -y
                        2dx_extract "$($env:TEMP)\$($SONG_ID)_ifs\$($SONG_ID)\$($SONG_ID)_pre.2dx"
                        ffmpeg -i "1.wav" -b:a 128k -filter:a "volume=0.65" "..\Bemuse_Organize\$($TARGET_SONG)\_bemuse_preview_tmp.mp3" -y
                        Rename-Item -Path "..\Bemuse_Organize\$($TARGET_SONG)\_bemuse_preview_tmp.mp3" -NewName "_bemuse_preview.mp3" -Force
                        Remove-Item "1.wav"
                    }
                }
            }
        }

        
        if (!(Test-Path $TARGET_PRE)){
            Write-Output "$($SONG_ID) $($_.Name) is missing preview."
        }
    }
}
