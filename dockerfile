FROM maven:3.9.9-eclipse-temurin-17 AS builder
COPY . /spc
WORKDIR /spc
RUN mvn package

FROM  eclipse-temurin:17.0.12_7-jre AS runner
LABEL project="SPC"
LABEL author="RumanKaif"
COPY --from=builder --chown=${USERNAME}:${USERNAME} /spc/target/spring-petclinic-3.4.0-SNAPSHOT.jar /app/spring-petclinic.jar
ARG ${USERNAME}=spc
RUN adduser -D -h /apps -s /bin/sh ${USERNAME}
USER ${USERNAME}
WORKDIR /app
EXPOSE 8080
CMD [ "java","-jar","spring-petclinic.jar" ]
