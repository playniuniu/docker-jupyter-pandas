NAME=playniuniu/jupyter-pandas
VERSION=latest

build:
	docker buildx build --platform linux/amd64,linux/arm64 -t ${NAME}:${VERSION} --push .

.PHONY: build
