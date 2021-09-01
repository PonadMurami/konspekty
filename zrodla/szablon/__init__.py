import sphinx.writers.html
import sphinx.writers.latex
from sphinx.util.smartypants import educateQuotes
from docutils.nodes import Element, Node, Text

BaseTranslatorHtml = sphinx.writers.html.HTMLTranslator
BaseTranslatorLatex = sphinx.writers.latex.LaTeXTranslator

class CustomHTMLTranslator(BaseTranslatorHtml):

    def visit_Text(self, text):
        str_text = self.encode(text.astext())
        if '~' in str_text:
            self.body.append(str_text.replace('~', '&nbsp;'))
        else:
            return BaseTranslatorHtml.visit_Text(self, text)

class CustomLatexTranslator(BaseTranslatorLatex):

    def visit_Text(self, node):
        text = self.encode(node.astext())

        if '\\textasciitilde{}' in text:
            text = text.replace('\\textasciitilde{}', '~')

        self.body.append(text)

    def visit_attribution(self, node):
        self.body.append('\mynobreakpar\n\\begin{flushright}\n')
        self.body.append(' --- ')

def setup(app):
    app.set_translator('html', CustomHTMLTranslator)
    app.set_translator('latex', CustomLatexTranslator)
