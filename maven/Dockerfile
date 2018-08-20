#FROM openjdk:8-jre
FROM maven:latest
#FROM maven:alpine

ENV allure_version 2.6.0
COPY allure-${allure_version}.tgz /

RUN apt-get update \
#RUN apk --update add tar git jq curl docker \
    && apt-get -y install tar git jq curl apt-transport-https ca-certificates gnupg2 software-properties-common \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
    && apt-get -y update \
    && apt-get -y install docker-ce \
    && tar -xzvf /allure-${allure_version}.tgz \
    && mv allure-${allure_version} /allure \
    && chmod -R +x /allure/bin \
    && git config --global user.email "gitlab-ci@ciklum.com" \
    && git config --global user.name "Gitlab CI"

VOLUME ["/allure-results"]
VOLUME ["/allure-report"]

ADD keys/ /root/.ssh
ADD _data/ /root/.m2
RUN chmod 600 /root/.ssh/*

WORKDIR /allure/bin
