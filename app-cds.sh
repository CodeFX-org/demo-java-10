#!/bin/sh
set -e

export java=/opt/jdk-10/bin/java

echo "--- RUN WITHOUT CDS ---"
time $java -jar app-cds/java-10.jar

echo "--- RUN WITH CDS ---"
echo " > create archive for default JDK classes"
sudo $java -Xshare:dump
echo " > use default archive"
time $java -Xshare:on -jar app-cds/java-10.jar
echo " > non-archived classes"
$java -Xlog:class+load -Xshare:on -jar app-cds/java-10.jar | grep -v "shared objects file"

echo "--- RUN WITH APPLICATION CDS ---"
echo " > record used classes"
$java -XX:+UseAppCDS -XX:DumpLoadedClassList=app-cds/classes.lst \
	 -jar app-cds/java-10.jar

echo " > create archive for recorded classes"
$java -XX:+UseAppCDS -Xshare:dump \
	-XX:SharedClassListFile=app-cds/classes.lst \
	-XX:SharedArchiveFile=app-cds/app.jsa \
	--class-path app-cds/java-10.jar

echo " > use created archive and log non-archived classes"
$java -Xlog:class+load \
	-XX:+UseAppCDS -Xshare:on -XX:SharedArchiveFile=app-cds/app.jsa \
	-jar app-cds/java-10.jar \
| grep -v "shared objects file"
