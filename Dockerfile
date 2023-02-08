# Use the latest version of Ubuntu as the base image
FROM ubuntu:latest

# Set up an environment variable for the maintainer
ENV MAINTAINER="Croitoriu Alexandru Dan"

# Run updates and install the necessary packages for an interactive terminal
RUN apt-get update && apt-get install -y \
    curl \
    git \
    nano \
    cmake \
    build-essential \
    libboost-all-dev \
    zeroc-ice-all-dev

RUN git clone https://github.com/emweb/wt.git wt && \
    cd wt/ && \
    mkdir build && \ 
    cd build/ && \
    cmake ../ && \
    make && \
    make install 

# Start nginx when the container starts
CMD ["nginx", "-g", "daemon off;"]

RUN export LD_LIBRARY_PATH=/usr/local/lib

# Expose the default port for the application
EXPOSE 9090
