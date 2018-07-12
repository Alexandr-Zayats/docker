#FROM openjdk:8-jre
FROM maven:latest

ENV allure_version 2.6.0
COPY allure-${allure_version}.tgz /

RUN apt-get update \
    && apt-get -y install tar git jq curl \
    && tar -xzvf /allure-${allure_version}.tgz \
    && mv allure-${allure_version} /allure \
    && chmod -R +x /allure/bin

VOLUME ["/allure-results"]
VOLUME ["/allure-report"]

ADD keys/ /root/.ssh
ADD _data/ /root/.m2
RUN chmod 600 /root/.ssh/*

WORKDIR /allure/bin
