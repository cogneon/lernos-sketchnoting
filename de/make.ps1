#Cleanup tmp
Remove-Item -Path "tmp\images\*"
Copy-Item -Path "src\images\*" -Destination "tmp\images"

Remove-Item -Path "tmp\sketchnotes\*"
Copy-Item -Path "src\sketchnotes\*" -Destination "tmp\sketchnotes"

Remove-Item -Path "tmp\*.*"
#Cleanup md-files and write to tmp
Get-ChildItem -Path "src\*"-Include *.md -Recurse $false | % {
    $temp_doc = $_.Name
    $cont = Get-Content -Path $_.FullName
    $cont = $cont -replace "\\newpage", "" #remove newpage
    $cont = $cont -replace "{#([^}]+)}", "" #remove image configuration tags
    $cont | Set-Content -Path ("tmp\{0}" -f $temp_doc) -Force
    #$cont | Set-Content -Path  "tmp\{$temp_doc}" -Force
}