import os
import sys


HTML = """<!doctype html>
<html class="no-js" lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Ponad Murami – Konspekty</title>
    <meta name="robots" content="index,follow" />

    <link rel="alternate" hreflang="pl" href="./pl/" />
    <link rel="alternate" hreflang="en" href="./en/" />
    <link rel="alternate" hreflang="es" href="./es/" />
    <link rel="alternate" hreflang="pt" href="./pt/" />
    <link rel="alternate" hreflang="fr" href="./fr/" />
    <link rel="alternate" hreflang="x-default" href="./" />

    <!-- Typography + color palette inspired by sphinx_rtd_theme -->
    <link rel="stylesheet" href="./pl/_static/css/fonts.css" type="text/css" />
    <link rel="stylesheet" href="./pl/_static/css/theme.css" type="text/css" />
    <link rel="shortcut icon" href="./pl/_static/favicon.ico" />

    <style>
      /* Keep it simple: centered logo + two language buttons. */
      :root {
        --pm-accent: #2980b9; /* RTD blue */
        --pm-bg: #edf0f2;     /* RTD body background */
        --pm-text: #404040;   /* RTD text */
        --pm-card: #ffffff;
        --pm-border: #e1e4e5;
      }

      html, body { height: 100%; }
      body {
        margin: 0;
        background: radial-gradient(1200px 600px at 50% 20%, rgba(41,128,185,0.14), rgba(41,128,185,0.0) 60%),
                    var(--pm-bg);
        color: var(--pm-text);
      }

      .pm-wrap {
        min-height: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 28px 18px;
      }

      .pm-card {
        width: 100%;
        max-width: 520px;
        background: var(--pm-card);
        border: 1px solid var(--pm-border);
        border-radius: 12px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
        padding: 34px 30px 26px;
        text-align: center;
      }

      .pm-logo-badge {
        width: 132px;
        height: 132px;
        margin: 0 auto 14px;
        border-radius: 999px;
        background: var(--pm-accent);
        display: flex;
        align-items: center;
        justify-content: center;
        box-shadow: 0 10px 18px rgba(41, 128, 185, 0.22);
      }
      .pm-logo {
        width: 92px;
        height: auto;
        display: block;
      }

      .pm-title {
        margin: 0 0 8px;
        font-size: 22px;
        line-height: 1.25;
      }

      .pm-subtitle {
        margin: 0 0 18px;
        opacity: 0.85;
        font-size: 15px;
        line-height: 1.5;
      }

      .pm-actions {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 12px;
        margin-top: 8px;
      }

      a.pm-btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        padding: 10px 14px;
        border-radius: 8px;
        font-weight: 700;
        text-decoration: none;
        border: 1px solid rgba(0, 0, 0, 0.1);
        background: #f3f6f6; /* RTD neutral */
        color: #404040;
        border-color: var(--pm-border);
      }
      a.pm-btn:hover { background: #e5ebeb; }

      /* Highlight Polish as primary, others secondary/equal */
      a.pm-btn.primary {
        background: var(--pm-accent);
        color: #fff;
        border-color: rgba(0, 0, 0, 0.12);
        grid-column: span 2; /* Make the main one full width if we want, or just let it flow */
      }
      a.pm-btn.primary:hover { background: #2e8ece; }

      .pm-footer {
        margin-top: 18px;
        font-size: 12px;
        opacity: 0.7;
      }

      @media (max-width: 420px) {
        .pm-actions { grid-template-columns: 1fr; }
        a.pm-btn.primary { grid-column: span 1; }
        .pm-card { padding: 28px 22px 22px; }
      }
    </style>
  </head>
  <body>
    <main class="pm-wrap" role="main">
      <section class="pm-card" aria-label="Language selection">
        <div class="pm-logo-badge" aria-hidden="true">
          <img class="pm-logo" src="./pl/_static/logo.svg" alt="" />
        </div>
        <h1 class="pm-title">Konspekty spotkań</h1>
        <p class="pm-subtitle">Wybierz język / Choose language</p>

        <div class="pm-actions">
          <a class="pm-btn primary" href="./pl/" lang="pl">Polski</a>
          <a class="pm-btn" href="./en/" lang="en">English</a>
          <a class="pm-btn" href="./es/" lang="es">Español</a>
          <a class="pm-btn" href="./pt/" lang="pt">Português</a>
          <a class="pm-btn" href="./fr/" lang="fr">Français</a>
        </div>

        <div class="pm-footer">Diakonia Ponad Murami</div>
      </section>
    </main>
  </body>
</html>
"""


def main() -> int:
    if len(sys.argv) != 2:
        print("Usage: generate_landing.py <output_html_dir>", file=sys.stderr)
        return 2
    out_dir = sys.argv[1]
    os.makedirs(out_dir, exist_ok=True)
    out_path = os.path.join(out_dir, "index.html")
    with open(out_path, "w", encoding="utf-8", newline="\n") as f:
        f.write(HTML)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
