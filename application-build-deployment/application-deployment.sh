#!/bin/bash

#--------- Java Application Packaging and Deployment ----------#

# Install specific java version via source package ( version 20)

sudo curl https://download.oracle.com/java/20/archive/jdk-20.0.2_linux-x64_bin.tar.gz --output /opt/openjdk-20_linux-x64_bin.tar.gz #download binaries
sudo tar -xvf openjdk-20_linux-x64_bin.tar.gz #extract the archive
/opt/jdk-20.0.2/bin/java --version #check version

export PATH=/opt/jdk-20.0.2/bin:$PATH #Export the executable directory to $PATH , so you dont have to mention the path all the time
#Note : You can do export PATH=$PATH:/opt/jdk-20/bin  , here you append the java bin directroy to the end of $PATH variable. However, if existing Java version already installed , since
# that version is mentioned in $PATH, that earlier version would take precendance over this. Explained here: https://jumaanscloudjourney.blogspot.com/2024/07/about-path-variable-when-exporting.html
source ~/.bashrc #  reload the configuration 
java --version

# Running a Java application
javac MyClass.java # this would generate a .class file which contains bytecode, ie : MyClass.class 
java MyClass # this would run the class file (bytecode) in JVM and execute in machine code
java -cp /opt/app/ MyClass # if the Class file located at a certain location

# Create an archive (.jar file) contains list of class files
jar cf MyApp.jar MyClass.class Service.class Lib.class ... # This would generate a file called MyApp.jar

# Enter the value for Main-Class property inside the Manifests file located at (META-INF/MANIFESTS.MF) to specify the entry point ( Where program starts)
Manifest-Version: 1.0
Created-By: 1.8.0_2024 (Private Build)
Main-Class: My-Class 

java -jar MyApp.jar # this would run the application archived inside the .jar file

# generate documentation 
javadoc -d doc MyClass.java

## Build Tool : Apache ANT ##

sudo yum install ant # Install ANT
/opt/ant/build.xml # This is the location where Build Configuration file will be installed

# Place your .java ( MyClass.java ) files inside src directory or else you have to mention the source directory of .java with necessary permissions
# Update the buld.xml configuration file
#Once updated the ant configuration file run following command
ant # This would just execute the conifg file and perform the tasks mentioned in Ant configuraiton file ( Compile , Doc , Jar)
ant compile jar # select a few specific task or takss to execute from the configuraiton file

## Build Tool : Maven ##
sudo yum install maven
cd /opt/maven # deploy your project directory here
/opt/maven/myapp/pom.xml # place the pom.xml file inside the project directory
sudo mvn package # to build with maven : compile and package with maven

# Run and test a Jar file mentioning the class path
java -cp /opt/maven/my-app/target/my-app-1.0-SNAPSHOT.jar com.mycompany.app.App

#--------- NodeJS Application Packaging and Deployment --------#

#--------- Python Application Packaging and Deployment ----------#