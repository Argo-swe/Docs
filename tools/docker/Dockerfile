FROM ubuntu:16.04

# filenames may contain accented letters
ENV LANG=C.UTF-8

RUN apt-get update && apt-get install --no-install-recommends -y \
	dos2unix \
	libgmp10 \
	nano \
	zip \
	aspell \
	aspell-en \
	aspell-it \
	latexmk \
	latex-xcolor \
	lmodern \
	pgf \
	poppler-utils \
	texlive \
	texlive-extra-utils \
	texlive-lang-english \
	texlive-lang-italian \
	texlive-latex-extra \
	texlive-latex-recommended \
	&& rm -rf /var/lib/apt/lists/*
