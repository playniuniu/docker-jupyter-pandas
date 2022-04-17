FROM alpine:edge
LABEL maintainer="playniuniu@gmail.com"

ENV PACKAGES curl openssl python3 py3-pip py3-numpy py3-scipy py3-pandas py3-scikit-learn py3-matplotlib py3-pillow jupyter-notebook
ENV PIP_PACKAGE openpyxl xlrd pandas_ta pandas-datareader seaborn bokeh plotly jupyterlab

RUN apk add --no-cache --update ${PACKAGES} \
    && pip3 --no-cache-dir install -U pip setuptools wheel\
    && pip3 --no-cache-dir install ${PIP_PACKAGE} \
    && rm -rf /var/cache/apk/* \
    && rm -rf /root/.cache/pip/* \
    && mkdir /root/.jupyter

COPY jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py

VOLUME /opt/
EXPOSE 8888

CMD ["jupyter", "lab"]
