FROM alpine:edge
MAINTAINER playniuniu@gmail.com

ENV PACKAGES curl openssl python3 openblas libstdc++ libpng freetype ttf-opensans
ENV BUILD_ESSENTIAL make gcc g++ python3-dev openblas-dev libpng-dev freetype-dev
ENV PIP_PACKAGE scipy matplotlib openpyxl xlrd pandas scikit-learn ipywidgets seaborn bokeh jupyter

COPY jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk add --no-cache --update ${PACKAGES} ${BUILD_ESSENTIAL} \
    && ln -s /usr/include/locale.h /usr/include/xlocale.h \
    && python3 -m venv /env/ \
    && /env/bin/pip install --upgrade pip \
    && /env/bin/pip install numpy \
    && /env/bin/pip install ${PIP_PACKAGE} \
    && /env/bin/jupyter nbextension enable --py --sys-prefix widgetsnbextension \
    && apk del ${BUILD_ESSENTIAL} \
    && rm -rf /var/cache/apk/* \
    && rm -rf /root/.cache/pip/*

VOLUME /opt/
EXPOSE 8888

CMD ["/env/bin/jupyter", "notebook", "--allow-root"]
