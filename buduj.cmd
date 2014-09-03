CALL make clean
CALL make html
CALL make latexpdf
CALL make epub
copy zbudowane\latex\konspekty.pdf zbudowane\html\konspekty.pdf 
copy zbudowane\epub\konspekty.epub  zbudowane\html\konspekty.epub
ebook-convert zbudowane\html\konspekty.epub zbudowane\html\konspekty.mobi 