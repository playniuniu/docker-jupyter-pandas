FROM alpine:edge
LABEL maintainer="playniuniu@gmail.com"

ENV PACKAGES curl openssl python3 py3-pip py3-numpy py3-scipy py3-pandas py3-matplotlib py3-pillow py3-lxml openblas libffi libzmq libgomp
ENV BUILD_ESSENTIAL alpine-sdk openblas-dev libffi-dev zeromq-dev
ENV PIP_PACKAGE openpyxl xlrd pandas_ta pandas-datareader scikit-learn statsmodels seaborn bokeh plotly jupyterlab

RUN apk add --no-cache --update ${PACKAGES} ${BUILD_ESSENTIAL} \
    && pip3 --no-cache-dir install -U pip setuptools wheel\
    && pip3 --no-cache-dir install ${PIP_PACKAGE} \
    && apk del ${BUILD_ESSENTIAL} \
    && rm -rf /var/cache/apk/* \
    && rm -rf /root/.cache/pip/* \
    && mkdir /root/.jupyter

COPY jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py

VOLUME /opt/
EXPOSE 8888

CMD ["jupyter", "lab"]
