
out = docs
doc = $(out)/Le_programme_commun_de_gouvernement_1972
src = $(wildcard src/*.md)

all: directories $(out)/index.html $(doc).html $(doc).md $(doc).epub $(doc).odt\
	$(doc)-a4-print.pdf $(doc)-a4-screen.pdf $(doc)-a5.pdf

directories:
	@mkdir -p docs

$(doc).html: $(src) Makefile
	pandoc -s --toc -o $@ -V fontsize=16pt -V lang="fr" \
		-M "date-meta=$$(date --iso-8601);" \
		-M "description=Découvrez les positions historiques des partis de gauche de 1972. Apprenez en plus sur ce consensus entre les communistes et socialistes français." \
		$(src)

$(doc).md: $(src) Makefile
	pandoc -s -o $@ $(src)

$(doc).epub: $(src) Makefile
	pandoc -s -o $@ $(src)

$(doc).odt: $(src) Makefile
	pandoc -s --toc  $< -o $@ \
		$(src)

$(doc)-a4-screen.pdf: $(src) Makefile
	pandoc -o $@  -s --toc  --pdf-engine=pdflatex \
		-V papersize=a4 -V fontsize=12pt -V classoption:oneside \
		-V documentclass=scrbook \
		$(src)

$(doc)-a4-print.pdf: $(src) Makefile
	pandoc -o $@  -s --toc  --pdf-engine=pdflatex \
		-V papersize=a4 -V fontsize=12pt -V classoption:twoside \
		-V documentclass=scrbook \
		$(src)

$(doc)-a5.pdf: $(src) Makefile
	pandoc -o $@  -s --toc --pdf-engine=pdflatex -V geometry:top=10mm \
		-V geometry:bottom=15mm -V geometry:left=10mm -V geometry:right=10mm \
		-V papersize=a5 -V fontsize=8pt -V classoption:twocolumn \
		-V classoption:oneside -V documentclass=scrbook \
		$(src)

$(out)/index.html: README.md Makefile
	pandoc -V lang="fr" -M "date-meta=$$(date --iso-8601);" \
		-M "description=Découvrez les programme commun de la gauche de gouvernement dans son intégralité. Comparez le aux programmes du PS et PCF actuels." \
		-M "title=Le programme commun de la gauche 1972" \
		-s -o $@ $<


.PHONY: clean

clean:
	@rm $(out)/index.html $(doc).html $(doc).md $(doc).epub $(doc).odt \
		$(doc)-a4-screen.pdf $(doc)-a4-print.pdf $(doc)-a5.pdf
