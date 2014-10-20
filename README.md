googlemap-batch-downloader
==========================

This is a bash script using webkit2png to batch download the google satlite maps. 
As long as providing the proper geo information, it can download multiple super high resolution images from googlemaps. 
This script will allow you to collect data efficiently to practice image stiching or other computer vision / image processing algorithms.

Currently this script will only run under Linux-like environment, python Qt and webkit must be installed, please check the pre-requisities of the webkit2png module.

With the default configuration, this script will download the entrie Canberra's satlite map.

The webkit2png (https://github.com/adamn/python-webkit2png) is used, the original author is Roland Tapken <roland@dau-sicher.de>.
