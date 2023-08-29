ARG JAVA_VERSION
FROM openjdk:${JAVA_VERSION}-slim-bullseye
ARG VERSION
ENV EULA=true
ENV START_RAM_USAGE=500M
ENV MAX_RAM_USAGE=1G

ENV TZ=Asia/Tehran
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y && apt-get -y install cron supervisor curl nano vim net-tools iputils-ping build-essential cmake git libjson-c-dev libwebsockets-dev

# Import script files
WORKDIR /scripts
ADD ./scripts/start.sh .
ADD ./scripts/runserver.sh .
RUN chmod +x start.sh runserver.sh

# Build Spigot from its build tools
RUN mkdir /buildResult
WORKDIR /mcbuild

RUN curl -o BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar && \
    java -jar BuildTools.jar --rev ${VERSION} && \
    cp Spigot/Spigot-API/target/spigot-api* /buildResult/ && \
    cp spigot-*.jar /buildResult/spigot.jar && \
    rm -rf /mcbuild

WORKDIR /data

CMD /scripts/start.sh
