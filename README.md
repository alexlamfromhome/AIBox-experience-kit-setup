# AI Box Experience Kit Setup

This repo captures information for setting up Edge AI Box using the AI Box Experience Kit based on 
[link](https://networkbuilders.intel.com/solutionslibrary/network-and-edge-reference-system-architectures-on-premises-edge-ai-box-quick-start-guide)

## Prerequisite
* Ubuntu 22.04
* No Docker installed
  
## Download experience kit setup
```
./download-AIBox-experience-kit.sh v23.10
sudo reboot
```

## Build AI Box Base container
```
cd /opt/intel/base_container/dockerfile
./build_base.sh
```

## Build AI Box Base Devel container
```
cd /opt/intel/base_container/dockerfile
./build_base_devel.sh
```

## Build AI Box DLStreamer container
```
cd /opt/intel/base_container/dockerfile
./build_dlstreamer.sh
```

## Build AI Box OpenCV/FFMpeg container
```
cd /opt/intel/base_container/dockerfile
./build_opencv_ffmpeg.sh
```



