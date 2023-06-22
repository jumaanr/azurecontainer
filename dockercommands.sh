#-------------------------[ Docker Installation ]-----------------------------#
#Setting up docker in Linux machine , here its an Ubuntu VM
# https://docs.docker.com/engine/install/ubuntu/

#System Pre-requisties
cat /etc/*release*
#un-install any older versions if exists
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done
#update apt package index
sudo apt-get update

#Three methods of installation
# 1) Install using apt repository
# 2) Install using package
# 3) Install using a convinience script

# Install using a convinience script
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh ./get-docker.sh --dry-run #you can remove the dry-run argument to run actually

#check the version of docker
docker --version
docker version #with more information

#check using docker run imgsrc: https://hub.docker.com/r/docker/whalesay
sudo docker run docker/whalesay cowsay Hello-World!

#-------------------------[ Docker Commands Basic ]-----------------------------#


#------ Docker Run Commands---------

docker run nginx    #runs an docker nginx container, if the image is not available locally it will pull the image from dockerhub, same image will be reused
docker run  --name webapp nginx:1.14-alpine  # define a custom name for container
docker run redis:4.0  #specify a tag which is a specific version of redis image, if not specified the default tag = latest applied

docker ps           #list all the running containers and basic information about them, container ID and name is shown
docker ps -a        # show all running, stopped, terminated(Exited) containers
docker ps -aq       #list only container ids

docker stop containerIDorName # you can give container ID or name. to stop a running contianer, can give multiple container name/ids with seperated by space
docker stop $(docker ps -aq) # stop all containers at once

docker rm containerIDorName #remove container to reclaim disk space , you can specify multiple containers with IDs
docker rm container1 container2
docker rm containerIDorName # remove stopped or exited contianers permanently, should print the name back
docker rm $(docker ps -aq) #remove all containers at once

# Containers are not meant to run operating system, containers are meant to run specific task or process i.e webserver , db server
# Once the task completes it exits , therefore following container stops immediately goes to exited state
docker run ubuntu

#-------- Command Execution ----------#
docker run ubuntu sleep 5 # Execute a command when we run a container
docker exec ContainerName cat /etc/hosts # Execute a command in a running container

docker run -it centos bash # automatically log into docker container as it runs

#---- Attach & Detach ---------------
docker run kodekloud/simple-webapp  #container is a simple webapp, this is in attached mode. It means the console is attached to the standard out of the docker container
docker run -d kodekloud/simple-webapp # run the container in detached mode, if image is un official kodekloud/simple-webapp it will be like this
docker attach a043d # re attach the console to container , give container ID (first few charrachters alone)

#-------- Images------------------#
docker images       # see a list of images
docker rmi ImageName # remove an image that no longer plan to use, ensure no containers are using that image. Stop, delete dependant instances
docker rmi $(docker images -aq) #remove all images
docker pull ImageName # Only download/pull the image

docker history ImageName #show how the image is build and sizes

#--------- Docker Run -------------#

# Run-STDIN interactively input standard input
docker run -it kodekloud/simple-prompt-docker  
#if the application run in the container requires sort of an input from user , you can bring interactive mode above and get the stanadard input attached to terminal

# Port Mapping 
docker run -p <externalPort_hostEnd>:<internalPort_containerEnd>  kodekloud/webapp # externalPort_hostEnd this is port users access calling docker host's IP address
docker run -p 80:5000 kodekloud/webapp #you cannot map to the same port more than once

#Volume Mapping
docker run -v <directory_dockerHost>:<directory_insideContainer>  mysql #This method helps to persist data
docker run -v /opt/datadir:/var/lib/mysql mysql 

#---- Get comprehensive information about a container--------
docker inspect <containerName|containerID> # Returns all details in json format , state, mounts, config and network settings
docker inspect blissful_hopper

docker logs <containerName|containerID> #get logs of a container that ran in background
docker logs blissful_hopper

#--------- Building Custom Docker Images using Docker File -------------#
docker build Dockerfile -t mummshad/my-custom-app  #build your own image using Dockerfile , -t for tag name | this will create an image locally in your system
docker build . #see the various steps involved and the result of each task
$ docker build -t webapp-color . #At the end of the command, we used the "." (dot) symbol which indicates for the current directory, so you need to run this command from within the directory that has the Dockerfile.

docker login #login to your user account before you publish
docker push mummshad/my-custom-app  #make it available in public docker registry, <accountName>/<ImageName>
#Alpine images are in general smaller images


docker run -p 8282:8080 webapp-color
docker run python:3.6 cat /etc/*release*

#------- ENV variables--------#
docker run -e APP_COLOR=blue simple-webapp-color
# you can pass a value to an environment vairable like above

# to check if a docker image configured with an enviornment varaible
docker inspect blissful_hopper # under config section you can see 'ENV' configured

#----Commands vs Entrypoints-#
docker  run  --entry-point   sleep2.0   ubuntu-sleeper 10 #overried the command at startup, here ENTRYPOINT ["sleep"] but we want to change it during runtime as sleep2.0

#---------- Docker Compose -----------------------
docker compose up #create and start containers

#----------Linking two contianers together----------

$ docker run -d --name=vote -p 5000:80   --link  nameofContainer:nameofHost   voting-app  #

#link is a command line option which can be used to link two containers together






