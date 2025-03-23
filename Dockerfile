FROM python:3.9-slim

WORKDIR /opt/app

RUN apt-get update && \
    apt-get install -y \
      python3-sphinx \
      nodejs \
      npm \
      make \
      texlive-latex-extra  \
      texlive-fonts-extra \
      latexmk  \
      texlive-lang-greek  \
      texlive-lang-polish  \
      wget  \
      pandoc \
      libopengl0 \
      libxcb-cursor0 \
      libxkbcommon-x11-0

RUN wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sh /dev/stdin
RUN pip install sphinx-sitemap
RUN npm install grunt &&  npm install -g grunt

CMD ["/bin/bash"]
