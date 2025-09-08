
out = docs
doc = $(out)/Le_programme_commun_de_gouvernement_1972
src = $(wildcard src/*.md)

all: directories $(out)/index.html $(doc).html $(doc).md $(doc).epub $(doc).odt\
	$(doc)-a4-print.pdf $(doc)-a4-screen.pdf $(doc)-a5.pdf

directories:
	@mkdir -p docs

$(doc).html: $(src)
	pandoc -s --toc -o $@ -V fontsize=16pt \
		$(src)

$(doc).md: $(src)
	pandoc -s -o $@ $(src)

$(doc).epub: $(src)
	pandoc -s -o $@ $(src)

$(doc).odt: $(src)
	pandoc -s --toc  $< -o $@ \
		$(src)

$(doc)-a4-screen.pdf: $(src)
	pandoc -o $@  -s --toc  --pdf-engine=pdflatex \
		-V papersize=a4 -V fontsize=12pt -V classoption:oneside \
		-V documentclass=scrbook \
		$(src)

$(doc)-a4-print.pdf: $(src)
	pandoc -o $@  -s --toc  --pdf-engine=pdflatex \
		-V papersize=a4 -V fontsize=12pt -V classoption:twoside \
		-V documentclass=scrbook \
		$(src)

$(doc)-a5.pdf: $(src)
	pandoc -o $@  -s --toc --pdf-engine=pdflatex -V geometry:top=10mm \
		-V geometry:bottom=15mm -V geometry:left=10mm -V geometry:right=10mm \
		-V papersize=a5 -V fontsize=8pt -V classoption:twocolumn \
		-V classoption:oneside -V documentclass=scrbook \
		$(src)

$(out)/index.html: README.md
	pandoc -s -o $@ $<


.PHONY: clean
clean:
	@rm $(out)/index.html $(doc).html $(doc).md $(doc).epub $(doc).odt \
		$(doc)-a4-screen.pdf $(doc)-a4-print.pdf $(doc)-a5.pdf
