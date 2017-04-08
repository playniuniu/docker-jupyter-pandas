FROM alpine:latest
MAINTAINER playniuniu@gmail.com

# ENV BUILD_ESSENTIAL make cmake gcc g++ linux-headers libxslt-dev libxml2-dev libc-dev zlib-dev musl-dev
ENV PACKAGES python3 libpng freetype libstdc++
ENV BUILD_ESSENTIAL make gcc g++ zlib-dev python3-dev libpng-dev freetype-dev
ENV PIP_PACKAGE matplotlib pandas jupyter

COPY jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py

RUN apk add --no-cache --update ${PACKAGES} ${BUILD_ESSENTIAL} \
    && ln -s /usr/include/locale.h /usr/include/xlocale.h \
    && python3 -m venv /env/ \
    && /env/bin/pip install --upgrade pip \
    && /env/bin/pip install numpy \
    && /env/bin/pip install ${PIP_PACKAGE} \
    && apk del ${BUILD_ESSENTIAL} \
    && rm -rf /var/cache/apk/* \
    && rm -rf /root/.cache/pip/*

VOLUME /opt/
EXPOSE 8888

CMD ["/env/bin/jupyter", "notebook", "--allow-root"]
