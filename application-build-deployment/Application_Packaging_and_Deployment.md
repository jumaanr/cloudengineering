
# Java, NodeJS, and Python Application Packaging and Deployment

## Java Application Packaging and Deployment

### Install Specific Java Version via Source Package (Version 20)

```sh
sudo curl https://download.oracle.com/java/20/archive/jdk-20.0.2_linux-x64_bin.tar.gz --output /opt/openjdk-20_linux-x64_bin.tar.gz # Download binaries
sudo tar -xvf openjdk-20_linux-x64_bin.tar.gz # Extract the archive
/opt/jdk-20.0.2/bin/java --version # Check version

export PATH=/opt/jdk-20.0.2/bin:$PATH # Export the executable directory to $PATH
# Note: You can do export PATH=$PATH:/opt/jdk-20/bin, here you append the java bin directory to the end of $PATH variable. However, if existing Java version already installed, since that version is mentioned in $PATH, that earlier version would take precedence over this. Explained here: https://jumaanscloudjourney.blogspot.com/2024/07/about-path-variable-when-exporting.html
source ~/.bashrc # Reload the configuration 
java --version
```

### Running a Java Application

```sh
javac MyClass.java # This would generate a .class file which contains bytecode, i.e., MyClass.class 
java MyClass # This would run the class file (bytecode) in JVM and execute in machine code
java -cp /opt/app/ MyClass # If the Class file located at a certain location
```

### Create an Archive (.jar File) Contains List of Class Files

```sh
jar cf MyApp.jar MyClass.class Service.class Lib.class ... # This would generate a file called MyApp.jar
```

### Enter the Value for Main-Class Property Inside the Manifests File

```plaintext
Manifest-Version: 1.0
Created-By: 1.8.0_2024 (Private Build)
Main-Class: My-Class 
```

```sh
java -jar MyApp.jar # This would run the application archived inside the .jar file
```

### Generate Documentation

```sh
javadoc -d doc MyClass.java
```

### Build Tool: Apache ANT

```sh
sudo yum install ant # Install ANT
/opt/ant/build.xml # This is the location where Build Configuration file will be installed

# Place your .java (MyClass.java) files inside src directory or else you have to mention the source directory of .java with necessary permissions
# Update the build.xml configuration file
# Once updated the ant configuration file run following command
ant # This would just execute the config file and perform the tasks mentioned in Ant configuration file (Compile, Doc, Jar)
ant compile jar # Select a few specific tasks to execute from the configuration file
```

### Build Tool: Maven

```sh
sudo yum install maven
cd /opt/maven # Deploy your project directory here
/opt/maven/myapp/pom.xml # Place the pom.xml file inside the project directory
sudo mvn package # To build with maven: compile and package with maven
```

### Run and Test a Jar File Mentioning the Class Path

```sh
java -cp /opt/maven/my-app/target/my-app-1.0-SNAPSHOT.jar com.mycompany.app.App
```

## NodeJS Application Packaging and Deployment

### Install NodeJS

```sh
sudo yum install nodejs # Install nodejs
```

### Running a NodeJS Application

```sh
node -v # Check version
node MyApp.js
```

### NPM - NodeJS Package Manager (This is not a Build Tool)

```sh
npm -v # Check the npm version. Remember this could be different from the nodejs version
npm search package_name # Search for a package
npm install package_name # Once you identified the package, install it using this command
# When you install a package, it will be stored in ./node_modules/package_name/ {Inside the present working directory}
# The code is located inside the ./node_modules/package_name/lib directory

./package.json # List down the dependencies and metadata of application
/node_modules/package_name/package.json # List down the dependencies of package/modules
./node_modules/package_name/lib # Application code of the package is located here

# Please look at the nodejs directory in this project. The newproj_package.json shows an example package.json file created for new project. Other package.json is the npm file modules package.json file.
```

### How to Import a Package and Call Functions of It

```javascript
// app.js
var file = require("file");
file.mkdirs("/tmp/dir1")
```

### Check the List of Paths NodeJS Looks at When Importing Packages

```sh
node -e "console.log(module.paths)"
```

### Install a Module to be Available Globally

```sh
npm install package_name -g
```

### Built-In and External Modules Locations

```sh
ls /usr/lib/node_modules/npm/node_modules # Place where Built-In modules located
ls /usr/lib/node_modules/ # Place where external modules located (globally)
```

### Checkout How a NodeJS App is Written into a Dockerfile

## Python Application Packaging and Deployment

### Install Python Versions

```sh
sudo apt install python3.8 # In Debian/Ubuntu
yum install python38 # Install Python 3.8 version on CentOS/RHEL
yum install python2 # Install Python2 version on CentOS/RHEL

python2 -V # Check version of Python2
python3 -V # Check version of Python3
python -V # Check installed Python version, whatever installed first will give answer
```

### Running Python Application

```sh
python2 myapp.py # Version 2
python3 myapp.py # Version 3 # Check the main.py
```

### Install Packages Using PIP

```sh
pip2 -V # Check the python2 version of pip2 
pip3 -V # Check the pip3 version that comes with python3
pip -V # Check the current pip version, whatever installed first will give answer
# When you install Python, it installed PIP automatically.

pip install package_name # Install a package using pip
pip install package_1 package_2 # Install multiple packages
pip install -r requirements.txt # Install list of packages (bulk installation) mentioned in requirements file. 
# Check the requirements.txt file, if you haven't specified the version, pip will install the latest version
```

### Check Package Information Using PIP

```sh
pip show package_name # Give information about installed package, such as version, name and location and more details
pip list # List down the installed packages
```

### Flask - Popular Web Framework for Python

### Locations That PIP Installs Packages

```sh
# Python packages are installed in this location: /usr/libZ/pythonX.Y/site-packages/package-name  (X=2,3: Y=minor version: Z=64 for 64bit packages, none)
python2 -c "import sys; print(sys.path)" # Check the path where python looks to find the packages
# By printing sys.path you can see what locations python looks when importing a package
# This is a command that is useful to identify cause of any package related issue
# If its not able to find, you may have installed to the wrong version of python or in a different location 
```

### Upgrade and Uninstall Packages

```sh
pip install package_name --upgrade # Upgrade the package
pip uninstall package_name # Uninstall a package
```

### Other Package Managers

#### easy_install

```sh
# This will setuptools to archive the python code into .egg extension file (app.egg).
# This is something similar to .jar file in Java
# Then use easy_install to install the app, you don't need to unpack the .egg file
easy_install install package_name
```

#### wheels

```sh
# This will setuptools to archive the python code into .whl extension file (app.whl)
# Here you need to unpack the .whl package first and install the package
pip install app.whl
```
