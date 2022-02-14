FROM maven:3.6.3 as maven

WORKDIR /usr/src/app
COPY . /usr/src/app
RUN chmod -Rf 755 .
RUN mvn clean package

FROM tomcat:8.5-jdk15-openjdk-oracle
ARG TOMCAT_FILE_PATH=/docker 
	
#Data & Config - Persistent Mount Point
ENV APP_DATA_FOLDER=/var/lib/demoopenshift
ENV SAMPLE_APP_CONFIG=${APP_DATA_FOLDER}/config/
	
ENV CATALINA_OPTS="-Xms1024m -Xmx4096m -XX:MetaspaceSize=512m -XX:MaxMetaspaceSize=512m -Xss512k"

#Move over the War file from previous build step
WORKDIR /usr/local/tomcat/webapps/
COPY --from=maven /usr/src/app/target/demoApp-1.0.0.war /usr/local/tomcat/webapps/ROOT.war

COPY ${TOMCAT_FILE_PATH}/* ${CATALINA_HOME}/conf/

WORKDIR $APP_DATA_FOLDER

EXPOSE 8080
ENTRYPOINT ["catalina.sh", "run"]
