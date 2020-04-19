@echo off
echo Starting lernOS Sketchnoting Guide Generation ...

REM Required Software
REM Calibre, includes ebook-convert, https://calibre-ebook.com
REM Ghostscript, https://www.ghostscript.com (version 9.24, version 9.26 does not work!)
REM ImageMagick, https://www.imagemagick.org
REM MiKTeX, https://miktex.org
REM Pandoc, https://pandoc.org
REM Wandmalfarbe Pandoc Template, https://github.com/Wandmalfarbe/pandoc-latex-template

REM Variables
set filename="lernOS-Sketchnoting-Guide-de"
set chapters=./src/0100_Vorwort.md ./src/0200_Danksagung.md ./src/0300_Grundlagen.md ./src/0400_Sketchnode_Lernpfad.md ./src/0500_Kata_01.md ./src/0500_Kata_02.md ./src/0500_Kata_03.md ./src/0500_Kata_04.md ./src/0500_Kata_05.md ./src/0500_Kata_06.md ./src/0500_Kata_07.md ./src/0500_Kata_08.md ./src/0500_Kata_09.md ./src/0500_Kata_10.md ./src/0500_Kata_11.md ./src/0500_Kata_12.md ./src/0500_Kata_13.md ./src/0500_Kata_14.md ./src/0500_Kata_15.md ./src/0500_Kata_16.md ./src/0500_Kata_17.md ./src/0500_Kata_18.md ./src/0500_Kata_19.md ./src/0500_Kata_20.md ./src/0500_Kata_21.md ./src/0500_Kata_22.md ./src/0500_Kata_23.md  ./src/0600_Warmups.md ./src/0700_Ressourcen.md ./src/0800_Start_Doing.md ./src/0900_Anhang.md 

REM Delete Old Versions
echo -- Delete old files
del %filename%.docx %filename%.epub %filename%.mobi %filename%.html %filename%.pdf images\ebook-cover.png
echo -- Old files deleted

REM Create Microsoft Word Version (docx)
echo -- Create Word document
pandoc metadata.yaml -s --resource-path="./src" %chapters% -o %filename%.docx
echo -- Word document created

REM Create Web Version (html)
echo -- Create HTML document
pandoc metadata.yaml -s --resource-path="./src" --toc %chapters% -o %filename%.html
echo -- HTML document created

REM Create PDF Version (pdf)
echo -- Create PDF document
pandoc metadata.yaml --from markdown --resource-path="./src" --template sketchnotes --number-sections -V lang=de-de %chapters% -o %filename%.pdf 
echo -- PDF document created

REM Create eBook Versions (epub, mobi)
echo -- Create eBook dokuments
echo - Create cover
magick convert -density 300 %filename%.pdf[0] src/images/ebook-cover.png
echo - Create epub-document
pandoc metadata.yaml -s --resource-path="./src" --epub-cover-image=src/images/ebook-cover.png %chapters% -o %filename%.epub
echo - Convert epub-document to epub-document
ebook-convert %filename%.epub %filename%.mobi

pause
