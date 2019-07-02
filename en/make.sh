#! /bin/sh

# Required Software
# Calibre, includes ebook-convert, https://calibre-ebook.com
# Ghostscript, https://www.ghostscript.com (version 9.24, version 9.26 does not work!)
# ImageMagick, https://www.imagemagick.org
# MiKTeX, https://miktex.org
# Pandoc, https://pandoc.org
# Wandmalfarbe Pandoc Template, https://github.com/Wandmalfarbe/pandoc-latex-template

# Variables 

filename=lernOS-Sketchnoting-Guide-en

# Delete old versions
rm $filename.docx $filename.epub $filename.mobi $filename.html $filename.pdf images/ebook-cover.png

# Create Microsoft Word Version (docx) 

pandoc -s -o $filename.docx --epub-metadata=./metadata/metadata.yaml $filename.md

# Create Web Version (html)

pandoc -s --toc -o $filename.html --epub-metadata=./metadata/metadata.yaml $filename.md

# Create PDF Version (pdf)

pandoc -V --from=markdown --template=sketchnotes --number-sections --toc -o $filename.pdf --epub-metadata=./metadata/metadata.yaml $filename.md

# Create eBook Version (epub, mobi)

# Create cover
convert -ennsity 300 $filename.pdf[0] images/ebook-cover.png

# Crate epub-document
pandoc -s --epub-cover-image=images/ebook-cover.png -o $filename.epub --epub-metadata=./metadata/metadata.yaml $filename.md

# Convert epub-document to mobi-document
ebook-convert $filename.epub $filename.mobi
