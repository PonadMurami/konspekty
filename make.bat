@ECHO OFF

REM Command file for Sphinx documentation

if "%SPHINXBUILD%" == "" (
	set SPHINXBUILD=sphinx-build
)
if "%EBOOK_CONVERT%" == "" (
	set EBOOK_CONVERT=ebook-convert
)
if "%PANDOC%" == "" (
	set PANDOC=pandoc
)
set BUILDDIR=zbudowane
set SRCDIR_PL=zrodla_pl
set SRCDIR_EN=zrodla_en
set HTMLDIR=%BUILDDIR%/html
set ALLSPHINXOPTS_PL=-d %BUILDDIR%/doctrees-pl %SPHINXOPTS% %SRCDIR_PL%
set ALLSPHINXOPTS_EN=-d %BUILDDIR%/doctrees-en %SPHINXOPTS% %SRCDIR_EN%
set I18NSPHINXOPTS_PL=%SPHINXOPTS% %SRCDIR_PL%
set I18NSPHINXOPTS_EN=%SPHINXOPTS% %SRCDIR_EN%
REM Backwards-compatible defaults (build PL only for other targets)
set ALLSPHINXOPTS=%ALLSPHINXOPTS_PL%
set I18NSPHINXOPTS=%I18NSPHINXOPTS_PL%
if NOT "%PAPER%" == "" (
	set ALLSPHINXOPTS_PL=-D latex_paper_size=%PAPER% %ALLSPHINXOPTS_PL%
	set ALLSPHINXOPTS_EN=-D latex_paper_size=%PAPER% %ALLSPHINXOPTS_EN%
	set I18NSPHINXOPTS_PL=-D latex_paper_size=%PAPER% %I18NSPHINXOPTS_PL%
	set I18NSPHINXOPTS_EN=-D latex_paper_size=%PAPER% %I18NSPHINXOPTS_EN%
)

if "%1" == "" goto help

if "%1" == "help" (
	:help
	echo.Please use `make ^<target^>` where ^<target^> is one of
	echo.  html       to make standalone HTML files
	echo.  dirhtml    to make HTML files named index.html in directories
	echo.  singlehtml to make a single large HTML file
	echo.  pickle     to make pickle files
	echo.  json       to make JSON files
	echo.  htmlhelp   to make HTML files and a HTML help project
	echo.  qthelp     to make HTML files and a qthelp project
	echo.  devhelp    to make HTML files and a Devhelp project
	echo.  epub       to make an epub
	echo.  latex      to make LaTeX files, you can set PAPER=a4 or PAPER=letter
	echo.  text       to make text files
	echo.  man        to make manual pages
	echo.  texinfo    to make Texinfo files
	echo.  gettext    to make PO message catalogs
	echo.  changes    to make an overview over all changed/added/deprecated items
	echo.  xml        to make Docutils-native XML files
	echo.  pseudoxml  to make pseudoxml-XML files for display purposes
	echo.  linkcheck  to check all external links for integrity
	echo.  doctest    to run all doctests embedded in the documentation if enabled
	goto end
)

if "%1" == "clean" (
	for /d %%i in (%BUILDDIR%\*) do rmdir /q /s %%i
	del /q /s %BUILDDIR%\*
	goto end
)


%SPHINXBUILD% 2> nul
if errorlevel 9009 (
	echo.
	echo.The 'sphinx-build' command was not found. Make sure you have Sphinx
	echo.installed, then set the SPHINXBUILD environment variable to point
	echo.to the full path of the 'sphinx-build' executable. Alternatively you
	echo.may add the Sphinx directory to PATH.
	echo.
	echo.If you don't have Sphinx installed, grab it from
	echo.http://sphinx-doc.org/
	exit /b 1
)

if "%1" == "html" (
	%SPHINXBUILD% -b html %ALLSPHINXOPTS_PL% %HTMLDIR%/pl
	if errorlevel 1 exit /b 1
	%SPHINXBUILD% -b html %ALLSPHINXOPTS_EN% %HTMLDIR%/en
	if errorlevel 1 exit /b 1
	if not exist %BUILDDIR%\html mkdir %BUILDDIR%\html
	python scripts\generate_landing.py %BUILDDIR%\html
	python scripts\generate_sitemap_index.py %BUILDDIR%\html http://konspekty.ponadmurami.pl/
	copy /Y shared\.htaccess %BUILDDIR%\html\.htaccess >nul
	echo.
	echo.Build finished. The HTML pages are in %HTMLDIR%/pl and %HTMLDIR%/en.
	goto end
)

if "%1" == "dirhtml" (
	%SPHINXBUILD% -b dirhtml %ALLSPHINXOPTS% %BUILDDIR%/dirhtml
	if errorlevel 1 exit /b 1
	echo.
	echo.Build finished. The HTML pages are in %BUILDDIR%/dirhtml.
	goto end
)

if "%1" == "singlehtml" (
	%SPHINXBUILD% -b singlehtml %ALLSPHINXOPTS% %BUILDDIR%/singlehtml
	if errorlevel 1 exit /b 1
	echo.
	echo.Build finished. The HTML pages are in %BUILDDIR%/singlehtml.
	goto end
)

if "%1" == "pickle" (
	%SPHINXBUILD% -b pickle %ALLSPHINXOPTS% %BUILDDIR%/pickle
	if errorlevel 1 exit /b 1
	echo.
	echo.Build finished; now you can process the pickle files.
	goto end
)

if "%1" == "json" (
	%SPHINXBUILD% -b json %ALLSPHINXOPTS% %BUILDDIR%/json
	if errorlevel 1 exit /b 1
	echo.
	echo.Build finished; now you can process the JSON files.
	goto end
)

if "%1" == "htmlhelp" (
	%SPHINXBUILD% -b htmlhelp %ALLSPHINXOPTS% %BUILDDIR%/htmlhelp
	if errorlevel 1 exit /b 1
	echo.
	echo.Build finished; now you can run HTML Help Workshop with the ^
.hhp project file in %BUILDDIR%/htmlhelp.
	goto end
)

if "%1" == "qthelp" (
	%SPHINXBUILD% -b qthelp %ALLSPHINXOPTS% %BUILDDIR%/qthelp
	if errorlevel 1 exit /b 1
	echo.
	echo.Build finished; now you can run "qcollectiongenerator" with the ^
.qhcp project file in %BUILDDIR%/qthelp, like this:
	echo.^> qcollectiongenerator %BUILDDIR%\qthelp\test.qhcp
	echo.To view the help file:
	echo.^> assistant -collectionFile %BUILDDIR%\qthelp\test.ghc
	goto end
)

if "%1" == "devhelp" (
	%SPHINXBUILD% -b devhelp %ALLSPHINXOPTS% %BUILDDIR%/devhelp
	if errorlevel 1 exit /b 1
	echo.
	echo.Build finished.
	goto end
)

if "%1" == "epub" (
	%SPHINXBUILD% -b epub %ALLSPHINXOPTS_PL% %BUILDDIR%/epub/pl
	if errorlevel 1 exit /b 1
	%SPHINXBUILD% -b epub %ALLSPHINXOPTS_EN% %BUILDDIR%/epub/en
	if errorlevel 1 exit /b 1
	if not exist %BUILDDIR%\html\pl mkdir %BUILDDIR%\html\pl
	if not exist %BUILDDIR%\html\en mkdir %BUILDDIR%\html\en
	copy /Y %BUILDDIR%\epub\pl\konspekty.epub %BUILDDIR%\html\pl\konspekty.epub >nul
	copy /Y %BUILDDIR%\epub\en\konspekty.epub %BUILDDIR%\html\en\konspekty.epub >nul
	echo.
	echo.Build finished. The epub files are in %BUILDDIR%/epub/(pl|en) and copied to %HTMLDIR%/(pl|en).
	goto end
)

if "%1" == "mobi" (
	if not exist %BUILDDIR%\html\pl\konspekty.epub (
		echo.Missing %BUILDDIR%\html\pl\konspekty.epub - run `make epub` first.
		exit /b 1
	)
	if not exist %BUILDDIR%\html\en\konspekty.epub (
		echo.Missing %BUILDDIR%\html\en\konspekty.epub - run `make epub` first.
		exit /b 1
	)
	%EBOOK_CONVERT% %BUILDDIR%\html\pl\konspekty.epub %BUILDDIR%\html\pl\konspekty.mobi
	if errorlevel 1 exit /b 1
	%EBOOK_CONVERT% %BUILDDIR%\html\en\konspekty.epub %BUILDDIR%\html\en\konspekty.mobi
	if errorlevel 1 exit /b 1
	echo.
	echo.Build finished. The mobi files are in %HTMLDIR%/(pl|en).
	goto end
)

if "%1" == "docx" (
	if not exist %BUILDDIR%\html\pl\konspekty.epub (
		echo.Missing %BUILDDIR%\html\pl\konspekty.epub - run `make epub` first.
		exit /b 1
	)
	if not exist %BUILDDIR%\html\en\konspekty.epub (
		echo.Missing %BUILDDIR%\html\en\konspekty.epub - run `make epub` first.
		exit /b 1
	)
	%PANDOC% -o %BUILDDIR%\html\pl\konspekty.docx %BUILDDIR%\html\pl\konspekty.epub
	if errorlevel 1 exit /b 1
	%PANDOC% -o %BUILDDIR%\html\en\konspekty.docx %BUILDDIR%\html\en\konspekty.epub
	if errorlevel 1 exit /b 1
	echo.
	echo.Build finished. The docx files are in %HTMLDIR%/(pl|en).
	goto end
)

if "%1" == "latex" (
	%SPHINXBUILD% -b latex %ALLSPHINXOPTS% %BUILDDIR%/latex
	if errorlevel 1 exit /b 1
	echo.
	echo.Build finished; the LaTeX files are in %BUILDDIR%/latex.
	goto end
)

if "%1" == "latexpdf" (
	%SPHINXBUILD% -b latex %ALLSPHINXOPTS_PL% %BUILDDIR%/latex/pl
	if errorlevel 1 exit /b 1
	%SPHINXBUILD% -b latex %ALLSPHINXOPTS_EN% %BUILDDIR%/latex/en
	if errorlevel 1 exit /b 1
	pushd %BUILDDIR%/latex/pl
	make all-pdf
	if errorlevel 1 exit /b 1
	popd
	pushd %BUILDDIR%/latex/en
	make all-pdf
	if errorlevel 1 exit /b 1
	popd
	if not exist %BUILDDIR%\html\pl mkdir %BUILDDIR%\html\pl
	if not exist %BUILDDIR%\html\en mkdir %BUILDDIR%\html\en
	copy /Y %BUILDDIR%\latex\pl\konspekty.pdf %BUILDDIR%\html\pl\konspekty.pdf >nul
	copy /Y %BUILDDIR%\latex\en\konspekty.pdf %BUILDDIR%\html\en\konspekty.pdf >nul
	echo.
	echo.Build finished; the PDF files are in %BUILDDIR%/latex/(pl|en) and copied to %HTMLDIR%/(pl|en).
	goto end
)

if "%1" == "latexpdfja" (
	%SPHINXBUILD% -b latex %ALLSPHINXOPTS% %BUILDDIR%/latex
	cd %BUILDDIR%/latex
	make all-pdf-ja
	cd %BUILDDIR%/..
	echo.
	echo.Build finished; the PDF files are in %BUILDDIR%/latex.
	goto end
)

if "%1" == "text" (
	%SPHINXBUILD% -b text %ALLSPHINXOPTS% %BUILDDIR%/text
	if errorlevel 1 exit /b 1
	echo.
	echo.Build finished. The text files are in %BUILDDIR%/text.
	goto end
)

if "%1" == "man" (
	%SPHINXBUILD% -b man %ALLSPHINXOPTS% %BUILDDIR%/man
	if errorlevel 1 exit /b 1
	echo.
	echo.Build finished. The manual pages are in %BUILDDIR%/man.
	goto end
)

if "%1" == "texinfo" (
	%SPHINXBUILD% -b texinfo %ALLSPHINXOPTS% %BUILDDIR%/texinfo
	if errorlevel 1 exit /b 1
	echo.
	echo.Build finished. The Texinfo files are in %BUILDDIR%/texinfo.
	goto end
)

if "%1" == "gettext" (
	%SPHINXBUILD% -b gettext %I18NSPHINXOPTS_PL% %BUILDDIR%/locale/pl
	if errorlevel 1 exit /b 1
	%SPHINXBUILD% -b gettext %I18NSPHINXOPTS_EN% %BUILDDIR%/locale/en
	if errorlevel 1 exit /b 1
	echo.
	echo.Build finished. The message catalogs are in %BUILDDIR%/locale/(pl|en).
	goto end
)

if "%1" == "changes" (
	%SPHINXBUILD% -b changes %ALLSPHINXOPTS% %BUILDDIR%/changes
	if errorlevel 1 exit /b 1
	echo.
	echo.The overview file is in %BUILDDIR%/changes.
	goto end
)

if "%1" == "linkcheck" (
	%SPHINXBUILD% -b linkcheck %ALLSPHINXOPTS% %BUILDDIR%/linkcheck
	if errorlevel 1 exit /b 1
	echo.
	echo.Link check complete; look for any errors in the above output ^
or in %BUILDDIR%/linkcheck/output.txt.
	goto end
)

if "%1" == "doctest" (
	%SPHINXBUILD% -b doctest %ALLSPHINXOPTS% %BUILDDIR%/doctest
	if errorlevel 1 exit /b 1
	echo.
	echo.Testing of doctests in the sources finished, look at the ^
results in %BUILDDIR%/doctest/output.txt.
	goto end
)

if "%1" == "xml" (
	%SPHINXBUILD% -b xml %ALLSPHINXOPTS% %BUILDDIR%/xml
	if errorlevel 1 exit /b 1
	echo.
	echo.Build finished. The XML files are in %BUILDDIR%/xml.
	goto end
)

if "%1" == "pseudoxml" (
	%SPHINXBUILD% -b pseudoxml %ALLSPHINXOPTS% %BUILDDIR%/pseudoxml
	if errorlevel 1 exit /b 1
	echo.
	echo.Build finished. The pseudo-XML files are in %BUILDDIR%/pseudoxml.
	goto end
)

:end
