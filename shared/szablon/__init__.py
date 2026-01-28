import sphinx.writers.html
import sphinx.writers.latex
import json
import os

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


def _docname_to_url(baseurl: str, docname: str) -> str:
    """Convert a Sphinx docname (pagename) to a public URL.

    We intentionally canonicalize *index* documents to directory URLs because
    Apache rules remove explicit `index.html` requests.
    """
    if not baseurl.endswith("/"):
        baseurl = baseurl + "/"

    if docname == "index":
        return baseurl
    if docname.endswith("/index"):
        # keep trailing slash
        return baseurl + docname[: -len("index")]
    return baseurl + docname + ".html"


def _site_baseurl(app) -> str:
    baseurl = getattr(app.config, "html_baseurl", "") or ""
    return baseurl if baseurl.endswith("/") else baseurl + "/"


def _lang_baseurl(site_baseurl: str, lang: str) -> str:
    if not site_baseurl.endswith("/"):
        site_baseurl = site_baseurl + "/"
    return site_baseurl + f"{lang}/"


def _load_i18n_map(app) -> dict:
    # Cache on env across pages within a build.
    cached = getattr(app.env, "_i18n_map_cache", None)
    if cached is not None:
        return cached

    # Default: repo-root relative to confdir (zrodla_pl/ or zrodla_en/)
    map_path = os.environ.get("I18N_MAP_FILE")
    if not map_path:
        map_path = os.path.abspath(os.path.join(app.confdir, "..", "i18n-map.json"))

    mapping = {}
    try:
        if os.path.exists(map_path):
            with open(map_path, "r", encoding="utf-8") as f:
                mapping = json.load(f)
    except Exception:
        # Be resilient: never break a build because of mapping issues.
        mapping = {}

    app.env._i18n_map_cache = mapping
    return mapping


def _get_other_docname(app, lang: str, other_lang: str, pagename: str) -> str:
    mapping = _load_i18n_map(app)

    # Supported formats:
    # - {"pl:foo/bar": "en:baz/qux", "en:baz/qux": "pl:foo/bar"}  (recommended)
    # - {"foo/bar": "baz/qux"}                                   (legacy/simple)
    key = f"{lang}:{pagename}"
    mapped = mapping.get(key) or mapping.get(pagename)
    if not mapped:
        return pagename

    if isinstance(mapped, str):
        if ":" in mapped:
            maybe_lang, rest = mapped.split(":", 1)
            if maybe_lang in ("pl", "en"):
                return rest
        return mapped

    return pagename


def add_i18n_context(app, pagename, templatename, context, doctree):
    lang = app.config.language or "en"
    other_lang = "en" if lang == "pl" else "pl"

    site_baseurl = _site_baseurl(app)
    lang_baseurl = _lang_baseurl(site_baseurl, lang)
    other_lang_baseurl = _lang_baseurl(site_baseurl, other_lang)

    canonical_url = _docname_to_url(lang_baseurl, pagename)
    other_docname = _get_other_docname(app, lang, other_lang, pagename)
    other_url = _docname_to_url(other_lang_baseurl, other_docname)

    context["canonical_url"] = canonical_url
    context["hreflang_links"] = [
        (lang, canonical_url),
        (other_lang, other_url),
        ("x-default", site_baseurl),
    ]
    context["lang_switch_url"] = other_url
    context["lang_switch_lang"] = other_lang


def setup(app):
    app.connect("html-page-context", add_i18n_context)

    app.set_translator('html', CustomHTMLTranslator)
    app.set_translator('epub', CustomHTMLTranslator)
    app.set_translator('singlehtml', CustomHTMLTranslator)
    app.set_translator('latex', CustomLatexTranslator)
