
#<Instruction> <Argument>

#OS is Ubuntu,must start FROM instruction
FROM Ubuntu

# Update apt repo, RUN instruct docker to run a particular command on those base images
RUN apt-get update

#Install dependancies using pip
RUN apt-get install python
  
#Install Python dependancies using pip
RUN pip install flask
RUN pip install flask-mysql

#Copy source code to /opt folder, COPY copies files from the local system to docker image | "." denotes current location
COPY . /opt/source-code

#Run the webserver using "flask" command
#ENTRYPOINT allows to specify a command that will be run when the image run as a container
ENTRYPOINT FLASK_APP=/opt/source-code/app.py flask run

