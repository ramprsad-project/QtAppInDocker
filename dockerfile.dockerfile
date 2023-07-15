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
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy the application files to the Docker image
COPY . /app
WORKDIR /app

# Run qmake to generate the Makefile
RUN qmake

# Build the project using make
RUN make

# Set the entry point for the Docker image
CMD ["./qtapp"]