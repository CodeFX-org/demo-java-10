#!/bin/sh
set -e

if ! [ -e app-cds/java-10.jar ]
then
	printf "Building Maven project, so JAR is available...\n"
    mvn install
fi

export java=/opt/jdk-10/bin/java

printf "\n--- RUN WITHOUT CDS ---\n\n"
time $java -jar app-cds/java-10.jar

printf "\n--- RUN WITH CDS ---\n"
printf "\n > create archive for default JDK classes\n"
sudo $java -Xshare:dump
printf "\n > use default archive\n"
time $java -Xshare:on -jar app-cds/java-10.jar
printf "\n > non-archived classes\n"
$java -Xshare:on \
	-Xlog:class+load \
	-jar app-cds/java-10.jar \
| grep -v "shared objects file"

printf "\n--- RUN WITH APPLICATION CDS ---\n"
printf "\n > record used classes\n"
$java \
	-XX:+UseAppCDS \
	-XX:DumpLoadedClassList=app-cds/classes.lst \
	-jar app-cds/java-10.jar

printf "\n > create archive for recorded classes\n"
$java \
	-XX:+UseAppCDS \
	-Xshare:dump \
	-XX:SharedClassListFile=app-cds/classes.lst \
	-XX:SharedArchiveFile=app-cds/app.jsa \
	--class-path app-cds/java-10.jar

printf "\n > use created archive and log non-archived classes\n"
$java \
	-XX:+UseAppCDS \
	-Xlog:class+load \
	-Xshare:on \
	-XX:SharedArchiveFile=app-cds/app.jsa \
	-jar app-cds/java-10.jar \
| grep -v "shared objects file"
