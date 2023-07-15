# QtAppInDocker
Qt C++ Widget GUI application Run in linux enviornment using docker 

# 1. ERROR :

Authorization required, but no authorization protocol specified
qt.qpa.xcb: could not connect to display :0
qt.qpa.plugin: Could not load the Qt platform plugin "xcb" in "" even though it was found.
This application failed to start because no Qt platform plugin could be initialized. Reinstalling the application may fix this problem.

# SOLUTION:

### First give permission
    xhost +local:
### Then run the container
    docker run -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $XAUTHORITY:$XAUTHORITY -e XAUTHORITY=$XAUTHORITY your_image_name

----------------------------------------------------------------------------------------------------------------------------------------------
# 2. ERROR :

Not able to build the docker image

# SOLUTION :

    docker build -t <appname> -f <file location> .

----------------------------------------------------------------------------------------------------------------------------------------------

# 3. ERROR :

Not able to push docker image into Hub

# SOLUTION :

Create tag first
    docker Tag <appname> <username>/<appname>:<version>
    docekr push <username>/<appname>:<version>

----------------------------------------------------------------------------------------------------------------------------------------------

# 4. ERROR :

Not able create dockerfile

# SOLUTION :

Write the docker file like below:
```
# Use an official Ubuntu as the base image
FROM ubuntu:latest

# Set environment variables for noninteractive installation
ENV DEBIAN_FRONTEND=noninteractive

# Install required dependencies
RUN apt-get update && apt-get install -y \
    cmake \
    libprotobuf-dev \
    protobuf-compiler \
    qtbase5-dev \
    qt5-qmake \
    libqt5widgets5 \
    libqt5gui5 \
    libqt5core5a \
    libgl1-mesa-glx \
    && rm -rf /var/lib/apt/lists/*
   
# Set the environment variable : In some cases, the QT_X11_NO_MITSHM environment variable needs to be set to avoid certain issues related to shared memory.
ENV QT_X11_NO_MITSHM=1
   
# Copy the application files to the Docker image
COPY . /app
WORKDIR /app

# Run qmake to generate the Makefile
RUN qmake

# Build the project using make
RUN make

# Set the entry point for the Docker image
CMD ["./qtapp"]
```
