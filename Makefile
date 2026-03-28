# Makefile for Sphinx documentation
#

# You can set these variables from the command line.
SPHINXOPTS    =
SPHINXBUILD   = sphinx-build
PAPER         = 
BUILDDIR      = zbudowane
SRCDIR_PL     = zrodla_pl
SRCDIR_EN     = zrodla_en
SRCDIR_ES     = zrodla_es
SRCDIR_PT     = zrodla_pt
SRCDIR_FR     = zrodla_fr
SITE_BASEURL ?= http://konspekty.ponadmurami.pl/
HTMLDIR       = $(BUILDDIR)/html
EBOOK_CONVERT ?= /opt/calibre/ebook-convert
PANDOC        ?= pandoc

# User-friendly check for sphinx-build
ifeq ($(shell which $(SPHINXBUILD) >/dev/null 2>&1; echo $$?), 1)
$(error The '$(SPHINXBUILD)' command was not found. Make sure you have Sphinx installed, then set the SPHINXBUILD environment variable to point to the full path of the '$(SPHINXBUILD)' executable. Alternatively you can add the directory with the executable to your PATH. If you don't have Sphinx installed, grab it from http://sphinx-doc.org/)
endif

# Internal variables.
PAPEROPT_a4     = -D latex_paper_size=a4
PAPEROPT_letter = -D latex_paper_size=letter
ALLSPHINXOPTS_PL   = -d $(BUILDDIR)/doctrees-pl $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) $(SRCDIR_PL)
ALLSPHINXOPTS_EN   = -d $(BUILDDIR)/doctrees-en $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) $(SRCDIR_EN)
ALLSPHINXOPTS_ES   = -d $(BUILDDIR)/doctrees-es $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) $(SRCDIR_ES)
ALLSPHINXOPTS_PT   = -d $(BUILDDIR)/doctrees-pt $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) $(SRCDIR_PT)
ALLSPHINXOPTS_FR   = -d $(BUILDDIR)/doctrees-fr $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) $(SRCDIR_FR)

# i18n builder cannot share environment/doctrees
I18NSPHINXOPTS_PL  = $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) $(SRCDIR_PL)
I18NSPHINXOPTS_EN  = $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) $(SRCDIR_EN)
I18NSPHINXOPTS_ES  = $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) $(SRCDIR_ES)
I18NSPHINXOPTS_PT  = $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) $(SRCDIR_PT)
I18NSPHINXOPTS_FR  = $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) $(SRCDIR_FR)

# Backwards-compatible defaults (build PL only for other targets if specified generically, but we mostly focus on specific targets)
ALLSPHINXOPTS      = $(ALLSPHINXOPTS_PL)

.PHONY: help clean html dirhtml singlehtml pickle json htmlhelp qthelp devhelp epub latex latexpdf mobi docx release text man changes linkcheck doctest gettext landing htaccess

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  html       to make standalone HTML files"
	@echo "  dirhtml    to make HTML files named index.html in directories"
	@echo "  singlehtml to make a single large HTML file"
	@echo "  pickle     to make pickle files"
	@echo "  json       to make JSON files"
	@echo "  htmlhelp   to make HTML files and a HTML help project"
	@echo "  qthelp     to make HTML files and a qthelp project"
	@echo "  devhelp    to make HTML files and a Devhelp project"
	@echo "  epub       to make an epub"
	@echo "  latex      to make LaTeX files, you can set PAPER=a4 or PAPER=letter"
	@echo "  latexpdf   to make LaTeX files and run them through xelatex"
	@echo "  latexpdfja to make LaTeX files and run them through platex/dvipdfmx"
	@echo "  text       to make text files"
	@echo "  man        to make manual pages"
	@echo "  texinfo    to make Texinfo files"
	@echo "  info       to make Texinfo files and run them through makeinfo"
	@echo "  gettext    to make PO message catalogs"
	@echo "  changes    to make an overview of all changed/added/deprecated items"
	@echo "  xml        to make Docutils-native XML files"
	@echo "  pseudoxml  to make pseudoxml-XML files for display purposes"
	@echo "  linkcheck  to check all external links for integrity"
	@echo "  doctest    to run all doctests embedded in the documentation (if enabled)"

clean:
	rm -rf $(BUILDDIR)/*

landing:
	@mkdir -p $(HTMLDIR)
	python scripts/generate_landing.py $(HTMLDIR)

sitemap:
	@mkdir -p $(HTMLDIR)
	python scripts/generate_sitemap_index.py $(HTMLDIR) $(SITE_BASEURL)

htaccess:
	@mkdir -p $(HTMLDIR)
	cp -f shared/.htaccess $(HTMLDIR)/.htaccess

html:
	@mkdir -p $(HTMLDIR)
	# Avoid stale tag pages when tag slugs change (do not delete download artifacts).
	# Note: We need to know the output directory for tags in each language.
	# PL/EN: tag, ES/PT: etiqueta, FR: etiquette
	rm -rf $(HTMLDIR)/pl/tag $(HTMLDIR)/en/tag $(HTMLDIR)/es/etiqueta $(HTMLDIR)/pt/etiqueta $(HTMLDIR)/fr/etiquette
	rm -rf $(HTMLDIR)/pl/_sources/tag $(HTMLDIR)/en/_sources/tag $(HTMLDIR)/es/_sources/etiqueta $(HTMLDIR)/pt/_sources/etiqueta $(HTMLDIR)/fr/_sources/etiquette
	$(SPHINXBUILD) -b html $(ALLSPHINXOPTS_PL) $(HTMLDIR)/pl
	$(SPHINXBUILD) -b html $(ALLSPHINXOPTS_EN) $(HTMLDIR)/en
	$(SPHINXBUILD) -b html $(ALLSPHINXOPTS_ES) $(HTMLDIR)/es
	$(SPHINXBUILD) -b html $(ALLSPHINXOPTS_PT) $(HTMLDIR)/pt
	$(SPHINXBUILD) -b html $(ALLSPHINXOPTS_FR) $(HTMLDIR)/fr
	$(MAKE) landing
	$(MAKE) sitemap
	$(MAKE) htaccess
	@echo
	@echo "Build finished. The HTML pages are in $(HTMLDIR)/{pl,en,es,pt,fr}."

dirhtml:
	$(SPHINXBUILD) -b dirhtml $(ALLSPHINXOPTS) $(BUILDDIR)/dirhtml
	@echo
	@echo "Build finished. The HTML pages are in $(BUILDDIR)/dirhtml."

singlehtml:
	$(SPHINXBUILD) -b singlehtml $(ALLSPHINXOPTS_PL) $(BUILDDIR)/singlehtml/pl
	$(SPHINXBUILD) -b singlehtml $(ALLSPHINXOPTS_EN) $(BUILDDIR)/singlehtml/en
	$(SPHINXBUILD) -b singlehtml $(ALLSPHINXOPTS_ES) $(BUILDDIR)/singlehtml/es
	$(SPHINXBUILD) -b singlehtml $(ALLSPHINXOPTS_PT) $(BUILDDIR)/singlehtml/pt
	$(SPHINXBUILD) -b singlehtml $(ALLSPHINXOPTS_FR) $(BUILDDIR)/singlehtml/fr
	@echo
	@echo "Build finished. The HTML page is in $(BUILDDIR)/singlehtml/(pl|en|es|pt|fr)."

pickle:
	$(SPHINXBUILD) -b pickle $(ALLSPHINXOPTS) $(BUILDDIR)/pickle
	@echo
	@echo "Build finished; now you can process the pickle files."

json:
	$(SPHINXBUILD) -b json $(ALLSPHINXOPTS) $(BUILDDIR)/json
	@echo
	@echo "Build finished; now you can process the JSON files."

htmlhelp:
	$(SPHINXBUILD) -b htmlhelp $(ALLSPHINXOPTS) $(BUILDDIR)/htmlhelp
	@echo
	@echo "Build finished; now you can run HTML Help Workshop with the" \
	      ".hhp project file in $(BUILDDIR)/htmlhelp."

qthelp:
	$(SPHINXBUILD) -b qthelp $(ALLSPHINXOPTS) $(BUILDDIR)/qthelp
	@echo
	@echo "Build finished; now you can run "qcollectiongenerator" with the" \
	      ".qhcp project file in $(BUILDDIR)/qthelp, like this:"
	@echo "# qcollectiongenerator $(BUILDDIR)/qthelp/test.qhcp"
	@echo "To view the help file:"
	@echo "# assistant -collectionFile $(BUILDDIR)/qthelp/test.qhc"

devhelp:
	$(SPHINXBUILD) -b devhelp $(ALLSPHINXOPTS) $(BUILDDIR)/devhelp
	@echo
	@echo "Build finished."
	@echo "To view the help file:"
	@echo "# mkdir -p $$HOME/.local/share/devhelp/test"
	@echo "# ln -s $(BUILDDIR)/devhelp $$HOME/.local/share/devhelp/test"
	@echo "# devhelp"

epub:
	$(SPHINXBUILD) -b epub $(ALLSPHINXOPTS_PL) $(BUILDDIR)/epub/pl
	$(SPHINXBUILD) -b epub $(ALLSPHINXOPTS_EN) $(BUILDDIR)/epub/en
	$(SPHINXBUILD) -b epub $(ALLSPHINXOPTS_ES) $(BUILDDIR)/epub/es
	$(SPHINXBUILD) -b epub $(ALLSPHINXOPTS_PT) $(BUILDDIR)/epub/pt
	$(SPHINXBUILD) -b epub $(ALLSPHINXOPTS_FR) $(BUILDDIR)/epub/fr
	@mkdir -p $(HTMLDIR)/pl $(HTMLDIR)/en $(HTMLDIR)/es $(HTMLDIR)/pt $(HTMLDIR)/fr
	cp -f $(BUILDDIR)/epub/pl/konspekty.epub $(HTMLDIR)/pl/konspekty.epub
	cp -f $(BUILDDIR)/epub/en/konspekty.epub $(HTMLDIR)/en/konspekty.epub
	cp -f $(BUILDDIR)/epub/es/konspekty.epub $(HTMLDIR)/es/konspekty.epub
	cp -f $(BUILDDIR)/epub/pt/konspekty.epub $(HTMLDIR)/pt/konspekty.epub
	cp -f $(BUILDDIR)/epub/fr/konspekty.epub $(HTMLDIR)/fr/konspekty.epub
	@echo
	@echo "Build finished. The epub files are in $(BUILDDIR)/epub/(pl|en|es|pt|fr) and copied to $(HTMLDIR)/(pl|en|es|pt|fr)."

mobi: epub
	python scripts/filter_ebook_convert.py "$(EBOOK_CONVERT)" $(HTMLDIR)/pl/konspekty.epub $(HTMLDIR)/pl/konspekty.mobi
	python scripts/filter_ebook_convert.py "$(EBOOK_CONVERT)" $(HTMLDIR)/en/konspekty.epub $(HTMLDIR)/en/konspekty.mobi
	python scripts/filter_ebook_convert.py "$(EBOOK_CONVERT)" $(HTMLDIR)/es/konspekty.epub $(HTMLDIR)/es/konspekty.mobi
	python scripts/filter_ebook_convert.py "$(EBOOK_CONVERT)" $(HTMLDIR)/pt/konspekty.epub $(HTMLDIR)/pt/konspekty.mobi
	python scripts/filter_ebook_convert.py "$(EBOOK_CONVERT)" $(HTMLDIR)/fr/konspekty.epub $(HTMLDIR)/fr/konspekty.mobi
	@echo
	@echo "Build finished. The mobi files are in $(HTMLDIR)/(pl|en|es|pt|fr)."

docx: epub
	$(PANDOC) -o $(HTMLDIR)/pl/konspekty.docx $(HTMLDIR)/pl/konspekty.epub
	$(PANDOC) -o $(HTMLDIR)/en/konspekty.docx $(HTMLDIR)/en/konspekty.epub
	$(PANDOC) -o $(HTMLDIR)/es/konspekty.docx $(HTMLDIR)/es/konspekty.epub
	$(PANDOC) -o $(HTMLDIR)/pt/konspekty.docx $(HTMLDIR)/pt/konspekty.epub
	$(PANDOC) -o $(HTMLDIR)/fr/konspekty.docx $(HTMLDIR)/fr/konspekty.epub
	@echo
	@echo "Build finished. The docx files are in $(HTMLDIR)/(pl|en|es|pt|fr)."

release: clean html latexpdf epub mobi docx

latex:
	$(SPHINXBUILD) -b latex $(ALLSPHINXOPTS_PL) $(BUILDDIR)/latex/pl
	$(SPHINXBUILD) -b latex $(ALLSPHINXOPTS_EN) $(BUILDDIR)/latex/en
	$(SPHINXBUILD) -b latex $(ALLSPHINXOPTS_ES) $(BUILDDIR)/latex/es
	$(SPHINXBUILD) -b latex $(ALLSPHINXOPTS_PT) $(BUILDDIR)/latex/pt
	$(SPHINXBUILD) -b latex $(ALLSPHINXOPTS_FR) $(BUILDDIR)/latex/fr
	@echo
	@echo "Build finished; the LaTeX files are in $(BUILDDIR)/latex/(pl|en|es|pt|fr)."
	@echo "Run \`make' in that directory to run these through XeLaTeX" \
	      "(use \`make latexpdf' here to do that automatically)."

latexpdf:
	$(SPHINXBUILD) -b latex $(ALLSPHINXOPTS_PL) $(BUILDDIR)/latex/pl
	$(SPHINXBUILD) -b latex $(ALLSPHINXOPTS_EN) $(BUILDDIR)/latex/en
	$(SPHINXBUILD) -b latex $(ALLSPHINXOPTS_ES) $(BUILDDIR)/latex/es
	$(SPHINXBUILD) -b latex $(ALLSPHINXOPTS_PT) $(BUILDDIR)/latex/pt
	$(SPHINXBUILD) -b latex $(ALLSPHINXOPTS_FR) $(BUILDDIR)/latex/fr
	@echo "Running LaTeX files through xelatex (pl)..."
	$(MAKE) -C $(BUILDDIR)/latex/pl all-pdf
	@echo "Running LaTeX files through xelatex (en)..."
	$(MAKE) -C $(BUILDDIR)/latex/en all-pdf
	@echo "Running LaTeX files through xelatex (es)..."
	$(MAKE) -C $(BUILDDIR)/latex/es all-pdf
	@echo "Running LaTeX files through xelatex (pt)..."
	$(MAKE) -C $(BUILDDIR)/latex/pt all-pdf
	@echo "Running LaTeX files through xelatex (fr)..."
	$(MAKE) -C $(BUILDDIR)/latex/fr all-pdf
	@mkdir -p $(HTMLDIR)/pl $(HTMLDIR)/en $(HTMLDIR)/es $(HTMLDIR)/pt $(HTMLDIR)/fr
	cp -f $(BUILDDIR)/latex/pl/konspekty.pdf $(HTMLDIR)/pl/konspekty.pdf
	cp -f $(BUILDDIR)/latex/en/konspekty.pdf $(HTMLDIR)/en/konspekty.pdf
	cp -f $(BUILDDIR)/latex/es/konspekty.pdf $(HTMLDIR)/es/konspekty.pdf
	cp -f $(BUILDDIR)/latex/pt/konspekty.pdf $(HTMLDIR)/pt/konspekty.pdf
	cp -f $(BUILDDIR)/latex/fr/konspekty.pdf $(HTMLDIR)/fr/konspekty.pdf
	@echo "xelatex finished; the PDF files are in $(BUILDDIR)/latex/(pl|en|es|pt|fr) and copied to $(HTMLDIR)/(pl|en|es|pt|fr)."

latexpdfja:
	$(SPHINXBUILD) -b latex $(ALLSPHINXOPTS) $(BUILDDIR)/latex
	@echo "Running LaTeX files through platex and dvipdfmx..."
	$(MAKE) -C $(BUILDDIR)/latex all-pdf-ja
	@echo "xelatex finished; the PDF files are in $(BUILDDIR)/latex."

text:
	$(SPHINXBUILD) -b text $(ALLSPHINXOPTS) $(BUILDDIR)/text
	@echo
	@echo "Build finished. The text files are in $(BUILDDIR)/text."

man:
	$(SPHINXBUILD) -b man $(ALLSPHINXOPTS) $(BUILDDIR)/man
	@echo
	@echo "Build finished. The manual pages are in $(BUILDDIR)/man."

texinfo:
	$(SPHINXBUILD) -b texinfo $(ALLSPHINXOPTS) $(BUILDDIR)/texinfo
	@echo
	@echo "Build finished. The Texinfo files are in $(BUILDDIR)/texinfo."
	@echo "Run \`make' in that directory to run these through makeinfo" \
	      "(use \`make info' here to do that automatically)."

info:
	$(SPHINXBUILD) -b texinfo $(ALLSPHINXOPTS) $(BUILDDIR)/texinfo
	@echo "Running Texinfo files through makeinfo..."
	make -C $(BUILDDIR)/texinfo info
	@echo "makeinfo finished; the Info files are in $(BUILDDIR)/texinfo."

gettext:
	$(SPHINXBUILD) -b gettext $(I18NSPHINXOPTS_PL) $(BUILDDIR)/locale/pl
	$(SPHINXBUILD) -b gettext $(I18NSPHINXOPTS_EN) $(BUILDDIR)/locale/en
	$(SPHINXBUILD) -b gettext $(I18NSPHINXOPTS_ES) $(BUILDDIR)/locale/es
	$(SPHINXBUILD) -b gettext $(I18NSPHINXOPTS_PT) $(BUILDDIR)/locale/pt
	$(SPHINXBUILD) -b gettext $(I18NSPHINXOPTS_FR) $(BUILDDIR)/locale/fr
	@echo
	@echo "Build finished. The message catalogs are in $(BUILDDIR)/locale/(pl|en|es|pt|fr)."

changes:
	$(SPHINXBUILD) -b changes $(ALLSPHINXOPTS) $(BUILDDIR)/changes
	@echo
	@echo "The overview file is in $(BUILDDIR)/changes."

linkcheck:
	$(SPHINXBUILD) -b linkcheck $(ALLSPHINXOPTS) $(BUILDDIR)/linkcheck
	@echo
	@echo "Link check complete; look for any errors in the above output " \
	      "or in $(BUILDDIR)/linkcheck/output.txt."

doctest:
	$(SPHINXBUILD) -b doctest $(ALLSPHINXOPTS) $(BUILDDIR)/doctest
	@echo "Testing of doctests in the sources finished, look at the " \
	      "results in $(BUILDDIR)/doctest/output.txt."

xml:
	$(SPHINXBUILD) -b xml $(ALLSPHINXOPTS) $(BUILDDIR)/xml
	@echo
	@echo "Build finished. The XML files are in $(BUILDDIR)/xml."

pseudoxml:
	$(SPHINXBUILD) -b pseudoxml $(ALLSPHINXOPTS) $(BUILDDIR)/pseudoxml
	@echo
	@echo "Build finished. The pseudo-XML files are in $(BUILDDIR)/pseudoxml."
