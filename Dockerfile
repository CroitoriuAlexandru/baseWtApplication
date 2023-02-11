FROM ubuntu:latest as wt

# install necesary tools
RUN apt-get update && apt-get install -y \
    git \
    cmake \
    build-essential \
    libboost-all-dev \
    zeroc-ice-all-dev

# Build step
RUN git clone https://github.com/emweb/wt.git wt && \
    cd wt/ && \
    mkdir build && \ 
    cd build/ && \
    cmake ../ && \
    make && \
    make install 

# copy wt lib from usr/local/lib to usr'lib
RUN cp /usr/local/lib/libwt*.so.* /usr/lib/

RUN git clone https://github.com/CroitoriuAlexandru/baseWtApplication.git && \
    cd baseWtApplication && \
    make

# #################### Deployment image starts here ####################

# Final image to run the application
FROM ubuntu:latest

# application dependencie libraries
RUN apt-get update && apt-get install -y \
    zeroc-ice-all-dev

# import Wt from the builder image and the app.exe
COPY --from=wt /usr/lib/libwt*.so.* /usr/lib/
copy --from=wt /usr/include/boost/* /usr/include/boost/
copy --from=wt /usr/lib/x86_64-linux-gnu/libboost* /usr/lib/x86_64-linux-gnu/

copy --from=builder /resources/* /application/resources
copy --from=builder /baseWtApplication/myApp /application/

CMD ./myApp docroot . --http-address 0.0.0.0 --http-port 9090

EXPOSE 9090
