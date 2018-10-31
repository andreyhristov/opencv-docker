OpenCV Builder Container for AARCH64 (ARM64)
==========

To build a specific version, for example 3.3.1 execute:
```
docker build --build-arg OPENCV_VERSION=3.3.1 -t your_dockerhub_user/opencv:3.3.1-aarch64-base --target=base .
docker build --build-arg OPENCV_VERSION=3.3.1 -t your_dockerhub_user/opencv:3.3.1-aarch64 .
```
The first one will build only the first stage _base_ . The second command will execute the first stage, which will be satisfied from the cache and then the second stage. If there is a problem with the second stage the first one doesn't need to be re-run. If only the second command is run then if there is a problem with the second stage the first one needs to be completely re-run. And this takes REALLY quite a bunch of time (several hours) because of the qemu emulation.
