FROM tensorflow/tensorflow:latest-gpu
MAINTAINER Daniel Petti

# Install dependencies.
RUN apt-get update
RUN apt-get install -y libjpeg8-dev libtiff5-dev libjasper-dev libpng12-dev \
    libgtk2.0-dev libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
    libatlas-base-dev gfortran libhdf5-serial-dev
RUN apt-get install -y python2.7-dev python-pip
RUN apt-get install -y wget cmake git
# Install packages for tracking.
RUN apt-get install -y python-liblinear python-matplotlib

RUN pip install numpy scipy

# Download and extract OpenCV.
RUN wget -O opencv.tar.gz https://github.com/opencv/opencv/archive/3.2.0.tar.gz
RUN mkdir opencv && tar -xvf opencv.tar.gz -C opencv --strip-components=1
RUN wget -O opencv_contrib.tar.gz \
    https://github.com/opencv/opencv_contrib/archive/3.2.0-rc.tar.gz
RUN mkdir opencv_contrib && tar -xvf opencv_contrib.tar.gz -C opencv_contrib \
    --strip-components=1

# Build opencv.
RUN cd opencv && mkdir build
RUN cd opencv/build && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D WITH_CUDA=ON \
    -D ENABLE_FAST_MATH=1 \
    -D CUDA_FAST_MATH=1 \
    -D WITH_CUBLAS=1 \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
    ..
RUN cd opencv/build && make -j32
RUN cd opencv/build && make -j32 install
RUN ldconfig
