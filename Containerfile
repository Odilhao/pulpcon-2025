FROM node
ADD . /slidev

WORKDIR /slidev

RUN npx slidev slides.md