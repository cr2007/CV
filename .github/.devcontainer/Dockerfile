FROM ubuntu:20.04

# non interactive frontend for locales
ENV DEBIAN_FRONTEND=noninteractive

# installing texlive and utils
RUN apt-get update && \
	apt-get -y install --no-install-recommends --fix-missing pandoc texlive texlive-latex-extra texlive-extra-utils texlive-fonts-extra texlive-bibtex-extra biber latexmk make git procps locales curl zsh && \
	rm -rf /var/lib/apt/lists/*

ENV LANGUAGE=en_US.UTF-8 LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
