$IIDX_VERSION = $args[0]
Get-ChildItem $args[0] -Directory | ForEach-Object {
    $TARGET_DIR = $_.FullName
    $TARGET_SONG = $_.Name
    Get-ChildItem $TARGET_DIR -Filter "*.bme" | Select-Object -First 1 | ForEach-Object {
        $TITLE_MATCH = Select-String -Path ($_.FullName) -Pattern "#TITLE (.*)"
        $ARTIST_MATCH = Select-String -Path ($_.FullName) -Pattern "#ARTIST (.*)"
        $GENRE_MATCH = Select-String -Path ($_.FullName) -Pattern "#GENRE (.*)"
        $BPM_MATCH = Select-String -Path ($_.FullName) -Pattern "#BPM (.*)"
        $BGA_MATCH = Select-String -Path ($_.FullName) -Pattern "#([0-9]{3})04:(0*)01(0*)"

        $TITLE = $TITLE_MATCH.Matches.Groups[1].Value;
        $BPM = $BPM_MATCH.Matches.Groups[1].Value;
        $GENRE = $GENRE_MATCH.Matches.Groups[1].Value;
        $ARTIST = $ARTIST_MATCH.Matches.Groups[1].Value;

        $MEASURE = $BGA_MATCH.Matches.Groups[1].Value / 1
        $PRE_TICK = [int]($BGA_MATCH.Matches.Groups[2].Value.Length / 2)
        $POST_TICK = [int]($BGA_MATCH.Matches.Groups[3].Value.Length / 2)
        $TOTAL_TICK = $PRE_TICK + $POST_TICK + 1

        
        $VIDEO_OFFSET =  60 / $BPM * ($PRE_TICK / $TOTAL_TICK * 4)

        Write-Output ("---`ntitle: `"$($TITLE -replace '"', '\"')`"`nvideo_file: bga.mp4`nvideo_offset: {0:F6}`ngenre: `"$($GENRE -replace '"', '\"') [$($IIDX_VERSION)]`"`nreplaygain: -5.5 dB`n---" -f $VIDEO_OFFSET) | Out-File -FilePath "..\Bemuse_Organize\$($TARGET_SONG)\README.md" -Encoding UTF8NoBOM
    }
}
