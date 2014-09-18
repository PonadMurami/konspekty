import sphinx.writers.html
import sphinx.writers.latex
from sphinx.util.smartypants import educate_quotes_latex

BaseTranslatorHtml = sphinx.writers.html.SmartyPantsHTMLTranslator
BaseTranslatorLatex = sphinx.writers.latex.LaTeXTranslator

class CustomHTMLTranslator(BaseTranslatorHtml):

    def bulk_text_processor(self, text):
        if '~' in text:
            text = text.replace('~', '&nbsp;')
        return BaseTranslatorHtml.bulk_text_processor(self, text)

class CustomLatexTranslator(BaseTranslatorLatex):

    def visit_Text(self, node):
        text = self.encode(node.astext())
        if '\\textasciitilde{}' in text:
            text = text.replace('\\textasciitilde{}', '~')
        if not self.no_contractions:
            text = educate_quotes_latex(text)
        self.body.append(text)

    def visit_attribution(self, node):
        self.body.append('\mynobreakpar\n\\begin{flushright}\n')
        self.body.append(' --- ')

def setup(app):
    sphinx.writers.latex.LaTeXTranslator = CustomLatexTranslator;