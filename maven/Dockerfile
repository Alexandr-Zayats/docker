#FROM openjdk:8-jre
FROM maven:latest

COPY allure-2.0.1.tgz /

RUN apt-get update \
    && apt-get -y install tar git \
    && tar -xvf /allure-2.0.1.tgz \
    && chmod -R +x /allure-2.0.1/bin

VOLUME ["/allure-results"]
VOLUME ["/allure-report"]

ADD keys/ /root/.ssh
ADD _data/ /root/.m2
RUN chmod 600 /root/.ssh/*

WORKDIR /allure-2.0.1/bin
