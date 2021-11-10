FROM openjdk:11
EXPOSE 8080
ADD target/drugstore_jen-0.0.1-SNAPSHOT.jar drugstore_jen-0.0.1-SNAPSHOT.jar
ENTRYPOINT ["java","-jar","/drugstore_jen-0.0.1-SNAPSHOT.jar"]
