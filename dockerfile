FROM maven:3.9.9-eclipse-temurin-17 AS builder
COPY . /spring-pet
WORKDIR /spring-pet
RUN mvn package

FROM  eclipse-temurin:17.0.12_7-jre AS runner
COPY from=builder --chown=ubuntu /spring-pet/target/spring-petclinic-3.3.0-SNAPSHOT.jar /app/spring-petclinic.jar/
USER ubuntu
WORKDIR /app
EXPOSE 8080
CMD [ "java","-jar","spring-pet.jar" ]
