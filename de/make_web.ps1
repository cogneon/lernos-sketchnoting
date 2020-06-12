#Cleanup tmp
Remove-Item -Path "tmp4web\images\*"
Copy-Item -Path "src\images\*" -Destination "tmp4web\images"

Remove-Item -Path "tmp4web\sketchnotes\*"
Copy-Item -Path "src\sketchnotes\*" -Destination "tmp4web\sketchnotes"

Remove-Item -Path "tmp4web\*.*"
#Cleanup md-files and write to tmp4web
Get-ChildItem -Path "src\*"-Include *.md  -Exclude "0500_Kata_00.md" -Recurse $false | % {
    $temp_doc = $_.Name
    $cont = Get-Content -Path $_.FullName
    $cont = $cont -replace "\\newpage", "" #remove newpage
    $cont = $cont -replace "{#([^}]+)}", "" #remove image configuration tags
    $cont | Set-Content -Path ("tmp4web\{0}" -f $temp_doc) -Force #write file to tmp4web
}