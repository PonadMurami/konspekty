import sphinx.writers.html
import sphinx.writers.latex
import json
import os

BaseTranslatorHtml = sphinx.writers.html.HTMLTranslator
BaseTranslatorLatex = sphinx.writers.latex.LaTeXTranslator

SUPPORTED_LANGUAGES = ['pl', 'en', 'es', 'pt', 'fr']


def _normalize_lang_code(lang: str) -> str:
    """Map Sphinx locale codes to the repository language slugs."""
    normalized = (lang or "en").lower().replace("-", "_")
    if normalized in SUPPORTED_LANGUAGES:
        return normalized

    base_lang = normalized.split("_", 1)[0]
    if base_lang in SUPPORTED_LANGUAGES:
        return base_lang

    return normalized

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
        self.body.append('\\mynobreakpar\n\\begin{flushright}\n')
        self.body.append(r'\textemdash\ ')


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
    """
    Load the i18n map.
    Returns a dictionary mapping "lang:pagename" to the full entry object.
    e.g. "pl:foo/bar" -> {"id": "...", "pl": "foo/bar", "en": "..."}
    """
    # Cache on env across pages within a build.
    cached = getattr(app.env, "_i18n_map_cache", None)
    if cached is not None:
        return cached

    # Default: repo-root relative to confdir (zrodla_pl/ or zrodla_en/)
    map_path = os.environ.get("I18N_MAP_FILE")
    if not map_path:
        map_path = os.path.abspath(os.path.join(app.confdir, "..", "i18n-map.json"))

    lookup = {}
    try:
        if os.path.exists(map_path):
            with open(map_path, "r", encoding="utf-8") as f:
                entries = json.load(f)
                
            # Allow for both list (new format) and dict (old format, fallback)
            if isinstance(entries, list):
                for entry in entries:
                    for lang in SUPPORTED_LANGUAGES:
                        if lang in entry:
                            key = f"{lang}:{entry[lang]}"
                            lookup[key] = entry
            elif isinstance(entries, dict):
                # Legacy format fallback
                for key, val in entries.items():
                    # Create a dummy entry for lookup
                    # key "pl:foo" -> val "en:bar"
                    # We can't easily reconstruct the full object but we can try basic mapping
                    lookup[key] = {"_legacy_target": val}

    except Exception:
        # Be resilient: never break a build because of mapping issues.
        lookup = {}

    app.env._i18n_map_cache = lookup
    return lookup


def _get_docname_for_lang(app, current_lang: str, target_lang: str, pagename: str) -> str:
    mapping = _load_i18n_map(app)
    key = f"{_normalize_lang_code(current_lang)}:{pagename}"
    
    entry = mapping.get(key)
    if not entry:
        return pagename

    # Handle legacy format
    if "_legacy_target" in entry:
        # This is limited to 2 languages usually, not robust for 5
        # But we assume migration script was run.
        return pagename

    if target_lang in entry:
        return entry[target_lang]
    
    return pagename


def add_i18n_context(app, pagename, templatename, context, doctree):
    current_lang = _normalize_lang_code(app.config.language or "en")
    
    site_baseurl = _site_baseurl(app)
    current_lang_baseurl = _lang_baseurl(site_baseurl, current_lang)
    canonical_url = _docname_to_url(current_lang_baseurl, pagename)

    context["canonical_url"] = canonical_url
    
    hreflang_links = []
    lang_switch_urls = {}

    # Add x-default (landing page)
    hreflang_links.append(("x-default", site_baseurl))

    for lang in SUPPORTED_LANGUAGES:
        target_docname = _get_docname_for_lang(app, current_lang, lang, pagename)
        lang_baseurl = _lang_baseurl(site_baseurl, lang)
        url = _docname_to_url(lang_baseurl, target_docname)
        
        hreflang_links.append((lang, url))
        lang_switch_urls[lang] = url

    context["hreflang_links"] = hreflang_links
    context["lang_switch_urls"] = lang_switch_urls
    
    # Deprecated but kept for compatibility if needed (though we should update template)
    # Pick 'en' or 'pl' as the toggle target for old templates if they exist
    other_lang = "en" if current_lang == "pl" else "pl"
    context["lang_switch_url"] = lang_switch_urls.get(other_lang, site_baseurl)
    context["lang_switch_lang"] = other_lang


def setup(app):
    app.connect("html-page-context", add_i18n_context)

    app.set_translator('html', CustomHTMLTranslator)
    app.set_translator('epub', CustomHTMLTranslator)
    app.set_translator('singlehtml', CustomHTMLTranslator)
    app.set_translator('latex', CustomLatexTranslator)
