FROM maven:3.9.9-eclipse-temurin-17 AS build
COPY . /spc
WORKDIR /spc
RUN mvn package

FROM gcr.io/distroless/java17-debian12
LABEL project="SPC"
LABEL author="RumanKaif"
USER nobody
COPY --from=build --chown=$nobody:$nobody /spc/target/spring-petclinic-3.3.0-SNAPSHOT.jar /apps/spring-petclinic-3.3.0-SNAPSHOT.jar
WORKDIR /apps
EXPOSE 8080
ENTRYPOINT [ "java","-jar" ]
CMD [ "spring-petclinic-3.3.0-SNAPSHOT.jar" ] 