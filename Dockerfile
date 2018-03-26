FROM alpine:latest
LABEL maintainer="playniuniu@gmail.com"

ENV PACKAGES curl openssl python3 py3-lxml openblas libstdc++ libpng freetype
ENV BUILD_ESSENTIAL make gcc g++ python3-dev openblas-dev libpng-dev freetype-dev
ENV PIP_PACKAGE scipy matplotlib openpyxl xlrd pandas pandas-datareader scikit-learn seaborn statsmodels jupyter

COPY jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py

RUN apk add --no-cache --update ${PACKAGES} ${BUILD_ESSENTIAL} \
    && pip3 --no-cache-dir install -U pip \
    && pip3 --no-cache-dir install numpy \
    && pip3 --no-cache-dir install ${PIP_PACKAGE} \
    && apk del ${BUILD_ESSENTIAL} \
    && rm -rf /var/cache/apk/* \
    && rm -rf /root/.cache/pip/*

VOLUME /opt/
EXPOSE 8888

CMD ["jupyter", "notebook", "--allow-root"]