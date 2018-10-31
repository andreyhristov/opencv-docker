# docker build --build-arg OPENCV_VERSION=3.3.1 -t andreyhristov/opencv:3.3.1-aarch64 --target=base .

FROM resin/aarch64-ubuntu:xenial as base
ARG OPENCV_VERSION=3.3.1

RUN [ "cross-build-start" ]

RUN apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y \
	wget file \
	cmake \
	build-essential \
	autoconf \
	less \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

RUN echo $OPENCV_VERSION


RUN wget https://github.com/opencv/opencv/archive/$OPENCV_VERSION.tar.gz -O opencv$OPENCV_VERSION.tar.gz \
	&& tar zxvf opencv$OPENCV_VERSION.tar.gz \
	&& mkdir opencv-build \ 
	&& cd opencv-build \
	&& cmake ../opencv-$OPENCV_VERSION \
	&& make -j2 \
	&& make install

RUN [ "cross-build-end" ]

FROM resin/aarch64-ubuntu:xenial

COPY --from=base /usr/local/bin/opencv* /usr/local/bin/
#installs libs but also pkgconfig/opencv.pc
COPY --from=base /usr/local/lib/ /usr/local/lib/
COPY --from=base /usr/local/share/ /usr/local/share/
COPY --from=base /usr/local/include/ /usr/local/include/
