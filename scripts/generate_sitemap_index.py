import os
import sys
from datetime import datetime, timezone


def _xml_escape(s: str) -> str:
    return (
        s.replace("&", "&amp;")
        .replace("<", "&lt;")
        .replace(">", "&gt;")
        .replace('"', "&quot;")
        .replace("'", "&apos;")
    )


def main() -> int:
    if len(sys.argv) != 3:
        print("Usage: generate_sitemap_index.py <output_html_dir> <site_baseurl>", file=sys.stderr)
        return 2

    out_dir = sys.argv[1]
    site_baseurl = sys.argv[2].rstrip("/") + "/"

    now = datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")
    sitemaps = [
        ("pl", site_baseurl + "pl/sitemap.xml"),
        ("en", site_baseurl + "en/sitemap.xml"),
    ]

    os.makedirs(out_dir, exist_ok=True)

    # sitemap index is commonly served from /sitemap.xml
    out_path = os.path.join(out_dir, "sitemap.xml")
    with open(out_path, "w", encoding="utf-8", newline="\n") as f:
        f.write("<?xml version='1.0' encoding='utf-8'?>\n")
        f.write('<sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n')
        for _lang, loc in sitemaps:
            f.write("  <sitemap>\n")
            f.write(f"    <loc>{_xml_escape(loc)}</loc>\n")
            f.write(f"    <lastmod>{now}</lastmod>\n")
            f.write("  </sitemap>\n")
        f.write("</sitemapindex>\n")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())

