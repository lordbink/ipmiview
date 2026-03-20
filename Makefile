NAME = lordbink/ipmiview

.PHONY: all build

all: build

build:
	docker build --platform linux/amd64 --progress=plain --ulimit "nofile=1024:524288" -t $(NAME):latest --rm -f Dockerfile .

run:
	docker run --platform linux/amd64 -p 8080:8080 $(NAME):latest
