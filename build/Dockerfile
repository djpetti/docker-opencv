FROM djpetti/docker-opencv-env:latest
MAINTAINER Daniel Petti

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
