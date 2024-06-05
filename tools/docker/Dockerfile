FROM ubuntu:22.04

# filenames may contain accented letters
ENV LANG=C.UTF-8

RUN apt-get update && apt-get install --no-install-recommends -y \
	dos2unix \
	libgmp10 \
	nano \
	aspell \
	aspell-en \
	aspell-it \
	lmodern \
	latexmk \
	poppler-utils \
	texlive \
	texlive-extra-utils \
	texlive-lang-english \
	texlive-lang-italian \
	texlive-latex-extra \
	texlive-latex-recommended \
	texlive-luatex \
	texlive-pictures \
	texlive-fonts-extra\
	zip \
	&& rm -rf /var/lib/apt/lists/*
