FROM python:3.12-alpine

WORKDIR /app

COPY ./requirements.txt /app
COPY ./transaction /app

RUN apk update --quiet  && \
    pip install -r requirements.txt

COPY . /app


ENTRYPOINT [ "python3" ]