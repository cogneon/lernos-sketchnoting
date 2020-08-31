#Cleanup tmp
#Cleanup images
Remove-Item -Path "tmp4doc\images\*"
Copy-Item -Path "src\images\*" -Destination "tmp4doc\images"
#Cleanup sketchnotes
Remove-Item -Path "tmp4doc\sketchnotes\*"
Copy-Item -Path "src\sketchnotes\*" -Destination "tmp4doc\sketchnotes"
#Cleanup documents
Remove-Item -Path "tmp4doc\*.*"
#Loop md-files and write to target-file
Get-ChildItem -Path "src\*"-Include "*.md" -Exclude "index.md" -Recurse $false | % {
    $temp_doc = "lernOS-Sketchnoting-Guide-en.md"
    $cont = Get-Content -Path $_.FullName
    $cont = $cont -replace "\((0500_Kata_.*?)\)", "" #remove kata-link
    $cont = $cont -replace "\((0410_Week_.*?)\)", "" #remove Week-link
    #Remove [] from Kata-Text
    $reg = "\[(Kata .*?)\]"
    #Search for Katas in brackets
    $found = $cont -match $reg
    If ($found) {    
        #Loop Katas
        [regex]::matches($cont, $reg) | % {      
            #Create exact regex   
            $val_new = $_.Value -replace "[[\]]", ""
            $val_old = "\[({0})\]" -f $val_new
            #Replace
            $cont = $cont -replace $val_old, $val_new
        }
    }
    #Remove [] from Week-Text
    $reg = "\[(Week .*?)\]"
    #Search for Week in brackets
    $found = $cont -match $reg
    If ($found) {    
        #Loop Week
        [regex]::matches($cont, $reg) | % {      
            #Create exact regex   
            $val_new = $_.Value -replace "[[\]]", ""
            $val_old = "\[({0})\]" -f $val_new
            #Replace
            $cont = $cont -replace $val_old, $val_new
        }

    }
    $cont  | Add-Content -Path ("tmp4doc\{0}" -f $temp_doc) -Force #write file to tmp4doc
    ""  | Add-Content -Path ("tmp4doc\{0}" -f $temp_doc) -Force #write file to tmp4doc
}