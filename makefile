all: pdf

pdf: prepare
	@echo "Creating pdf output ..."
	@pwd
	@pandoc -s -N --template=assets/latex/template.latex \
    thesis.md --output thesis.pdf \
		--latex-engine=xelatex \
		--bibliography=assets/references.bib \
		--csl assets/ieee.csl \
		--highlight-style=tango \
		--table-of-contents \
    --variable documentclass=article \
    --variable fontsize=13pt \
    --variable mainfont='Helvetica Neue' \
    --variable sansfont='Helvetica Neue' \
    --variable classoption=openright \
    --variable papersize=a4paper,oneside,headsepline

prepare:
	@echo "Preparing ..."
	@cat `find . -name "*.markdown" | sort` > thesis.md
