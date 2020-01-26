FROM ubuntu:18.04
ENV PYTHONUNBUFFERED 1
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y python3 python3-pip

# 日本語フォントとpdf出力に必要なライブラリをインストール
RUN apt-get install -y fonts-noto-cjk
RUN apt install -y texlive texlive-latex-extra texlive-xetex texlive-lang-japanese pandoc
RUN apt install -y nodejs npm

# ついでにグラフ出力もできるようにmatplotlibをインストール
RUN pip3 install jupyterlab matplotlib
RUN mkdir /src
ADD src/ /src

# .base.tplxを利用
RUN mkdir -p ~/texmf/tex/latex/local/
RUN cp /src/.jalinebreak.tplx ~/texmf/tex/latex/local/jalinebreak.tplx
RUN cp /src/.base.tplx /usr/local/lib/python3.6/dist-packages/nbconvert/templates/latex/base.tplx
