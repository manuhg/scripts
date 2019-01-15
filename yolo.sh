!/bin/sh
!yolov2_tiny_weights="https://pjreddie.com/media/files/yolov2-tiny.weights"
!yolov2_tiny_cfg='https://raw.githubusercontent.com/pjreddie/darknet/master/cfg/yolov2-tiny.cfg'
!git clone https://github.com/pjreddie/darknet.git
!mv -v darknet/* ./
!sed -i  's/GPU=0/GPU=1/g' Makefile
!sed -i  's/CUDNN=0/CUDNN=1/g' Makefile
!make -j4
!wget https://www.hublot.com/images/News_2018/match_for_solidarity_gallery_13.jpg -O input_image.jpg
!wget $yolov2_tiny_weights
!wget $yolov2_tiny_cfg
!./darknet detect yolov2-tiny.cfg yolov2-tiny.weights input_image