#$paths = @(
#    'C:\Users\user\Downloads\Universe S01E02 Alien Worlds - The Search for Second Earth.srt',
#    'C:\Users\user\Downloads\Universe S01E01 The Sun - God Star.srt'
#)

$paths = gci C:\Users\user\Downloads -Filter *.srt

foreach($path in $paths)
{
    $c = Get-Content $path.FullName;
    $output = '';
    foreach($line in $c)
    {
        if($line -eq '' -or $line -match '^\d+$' -or $line -match '\d{2}:\d{2}:\d{2},\d{3} --> \d{2}:\d{2}:\d{2},\d{3}')
        {
            continue;
        }
        $li = $line;
        $li = $line -replace '\<font color="#[a-z0-9]{6}"\>',''
        $li = $li -replace '\</font\>',''
        $output += $li;
        if ($li -match "\w\.$")
        {
            $output += [System.Environment]::NewLine * 2;
        } 
        else 
        {
            $output += " "
        }
    }
    $output = $output -replace '\.{3}',',' 
    $output = $output -replace '\.{2}',''
    $output
    $fi = ([System.IO.FileInfo]$path)
    $outputFileName = $fi.Name -replace '\s','_'
    $outputPath = "C:\temp\$outputFileName.txt"
    $outputPath
    $output | Out-File $outputPath
}