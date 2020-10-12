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
set filename="lernOS-Sketchnoting-Guide-en"

REM Delete Old Versions
echo -- Delete old files
del %filename%.docx %filename%.epub %filename%.mobi %filename%.html %filename%.pdf images\ebook-cover.png
echo -- Old files deleted

REM Create Microsoft Word Version (docx)
echo -- Create Word document
pandoc metadata.yaml -s --resource-path="./tmp4doc" ./tmp4doc/%filename%.md -o %filename%.docx
echo -- Word document created

REM Create Web Version (html)
echo -- Create HTML document
pandoc metadata.yaml -s --resource-path="./tmp4doc" --toc ./tmp4doc/%filename%.md -o %filename%.html
echo -- HTML document created

REM Create PDF Version (pdf)
echo -- Create PDF document
pandoc metadata.yaml --from markdown --resource-path="./tmp4doc" --template sketchnotes --number-sections -V lang=en-en ./tmp4doc/%filename%.md -o %filename%.pdf 
echo -- PDF document created

REM Create eBook Versions (epub, mobi)
echo -- Create eBook dokuments
echo - Create cover
magick convert -density 300 %filename%.pdf[0] ./tmp4doc/images/ebook-cover.png
echo - Create epub-document
pandoc metadata.yaml -s --resource-path="./tmp4doc" --epub-cover-image=./tmp4doc/images/ebook-cover.png ./tmp4doc/%filename%.md -o %filename%.epub
echo - Convert epub-document to epub-document
ebook-convert %filename%.epub %filename%.mobi

pause
