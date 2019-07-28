@echo off
echo Starting lernOS Guide Generation ...

REM Required Software
REM Calibre, includes ebook-convert, https://calibre-ebook.com
REM Ghostscript, https://www.ghostscript.com (version 9.24, version 9.26 does not work!)
REM ImageMagick, https://www.imagemagick.org
REM MiKTeX, https://miktex.org
REM Pandoc, https://pandoc.org
REM Wandmalfarbe Pandoc Template, https://github.com/Wandmalfarbe/pandoc-latex-template

REM Variables
set filename="lernOS-Sketchnoting-Guide-de"

REM Delete Old Versions
echo -- Delete old files
del %filename%.docx %filename%.epub %filename%.mobi %filename%.html %filename%.pdf images\ebook-cover.png
echo -- Old files deleted

REM Create Microsoft Word Version (docx)
echo -- Create Word document
pandoc -s -o %filename%.docx %filename%.md --metadata-file metadata/metadata.yaml
echo -- Word document created

REM Create Web Version (html)
echo -- Create HTML document
pandoc -s --toc -o %filename%.html %filename%.md --metadata-file metadata/metadata.yaml
echo -- HTML document created

REM Create PDF Version (pdf)
echo -- Create PDF document
pandoc %filename%.md metadata/metadata.yaml -o %filename%.pdf --from markdown --template sketchnotes --number-sections -V lang=de-de
echo -- PDF document created

REM Create eBook Versions (epub, mobi)
echo -- Create eBook dokuments
echo - Create cover
magick convert -density 300 %filename%.pdf[0] images/ebook-cover.png
echo - Create epub-document
pandoc -s --epub-cover-image=images/ebook-cover.png -o %filename%.epub %filename%.md --metadata-file metadata/metadata.yaml
echo - Convert epub-document to epub-document
ebook-convert %filename%.epub %filename%.mobi

pause
