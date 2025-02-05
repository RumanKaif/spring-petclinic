FROM maven:3.9.9-eclipse-temurin-17 AS build
COPY . /spc
WORKDIR /spc
RUN mvn package

FROM  eclipse-temurin:17-alpine
LABEL project="SPC"
LABEL author="RumanKaif"
ARG USERNAME=spc
RUN adduser -D -h /apps -s /bin/sh ${USERNAME}
USER ${USERNAME}
COPY --from=build --chown=${USERNAME}:${USERNAME} /spc/target/spring-petclinic-3.3.0-SNAPSHOT.jar /apps/spring-petclinic-3.3.0-SNAPSHOT.jar
WORKDIR /apps
EXPOSE 8080
CMD [ "java","-jar","spring-petclinic-3.3.0-SNAPSHOT.jar" ]
