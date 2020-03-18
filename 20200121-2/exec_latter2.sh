#!/bin/bash

##please edit setup file
#MVGBUILDMAIN="/home/repos/openMVG_build"
#MVSBUILDMAIN="/home/repos/openMVS_build/bin"
#MVGEXEC="software/SfM"
#MVGRELEASE="Linux-x86_64-RELEASE"
##
#MAKEMODEL_NAME="exec_model"
#IMGDIRPATH="/mnt/Omer/Project/04.ExTRaMapping/ModelData/Data/"
#TYPE="Experiment"
#IMGOUTPATH="/mnt/Omer/Project/04.ExTRaMapping/ModelData"
#IMGDIRNAME="190522-1_clf"
#SHOTDATE="190522-1_clf"
#DATE="20190807"
##setup
. ./setup.txt
##file preparation
if [ -d ${MVGBUILDMAIN}/${MVGEXEC}/input ];then
  echo "directory exists"
else
  mkdir ${MVGBUILDMAIN}/${MVGEXEC}/input
fi
#cp ./model.py.in ./make_model.py.in
#cat ./model.py.in | sed -e "s#@OPENMVG_SOFTWARE_SFM_BUILD_DIR@#/home/repos/openMVG_build/Linux-x86_64-RELEASE#g" -e "s#@OPENMVG_SOFTWARE_SFM_SRC_DIR@#/home/repos/openMVG/src/software/SfM#g" -e "s#@IMGSRC@#${IMGDIRNAME}#g" > ./${MAKEMODEL_NAME}.py
#mv ./${MAKEMODEL_NAME}.py ${MVGBUILDMAIN}/${MVGEXEC}/
cat ./model3.py.in | sed -e "s#@OPENMVG_SOFTWARE_SFM_BUILD_DIR@#/home/repos/openMVG_0120_build/Linux-x86_64-RELEASE#g" -e "s#@OPENMVG_SOFTWARE_SFM_SRC_DIR@#/home/repos/openMVG/src/software/SfM#g" -e "s#@IMGSRC@#${IMGDIRNAME}#g" > ./${MAKEMODEL_NAME}3.py
mv ./${MAKEMODEL_NAME}3.py ${MVGBUILDMAIN}/${MVGEXEC}/
#3dmorph image copy
#cp -r ${IMGDIRPATH}/${TYPE}/3dmorph/${SHOTDATE}/morph/${IMGDIRNAME} ${MVGBUILDMAIN}/${MVGEXEC}/input/
#high speed camera image copy

#cp ${IMGDIRPATH}/${TYPE}/optical/${SHOTDATE}/pose/*.jpg ${MVGBUILDMAIN}/${MVGEXEC}/input/${IMGDIRNAME}/images
#camera image sensor width copy
#cp -i ./sensor_width_database.txt /home/repos/openMVG/src/openMVG/exif/sensor_width_database/

#change exif

#python ./chexif.py

#cp -r ${MVGBUILDMAIN}/${MVGEXEC}/input/${IMGDIRNAME} ${MVSBUILDMAIN}/undistorted_images/

###################
######execute######
###################

#python ${MVGBUILDMAIN}/${MVGEXEC}/${MAKEMODEL_NAME}.py
cp ./sfm_data.json ${MVGBUILDMAIN}/${MVGEXEC}/input/${IMGDIRNAME}/out/matches/
python ${MVGBUILDMAIN}/${MVGEXEC}/${MAKEMODEL_NAME}3.py
# data export
${MVGBUILDMAIN}/${MVGRELEASE}/openMVG_main_openMVG2openMVS -i ${MVGBUILDMAIN}/${MVGEXEC}/input/${IMGDIRNAME}/out/reconstruction_sequential/sfm_data.bin -o ${MVGBUILDMAIN}/${MVGEXEC}/input/${IMGDIRNAME}/out/reconstruction_sequential/scene.mvs
#openmvs change data
#${MVSBUILDMAIN}/DensifyPointCloud ${MVGBUILDMAIN}/${MVGEXEC}/input/${IMGDIRNAME}/out/reconstruction_sequential/scene.mvs
#mesh reconstruction
#${MVSBUILDMAIN}/ReconstructMesh ${MVGBUILDMAIN}/${MVGEXEC}/input/${IMGDIRNAME}/out/reconstruction_sequential/scene_dense.mvs
#texturemesh
#${MVSBUILDMAIN}/TextureMesh ${MVGBUILDMAIN}/${MVGEXEC}/input/${IMGDIRNAME}/out/reconstruction_sequential/scene_dense_mesh.mvs

#copy output
#mkdir -p /home/repos/install/install/${IMGDIRNAME}/out_0121
#cp -r ${MVGBUILDMAIN}/${MVGEXEC}/input/${IMGDIRNAME}/out/* ${IMGOUTPATH}/${TYPE}/${SHOTDATE}/${DATE}/${IMGDIRNAME}

cp -r ${MVGBUILDMAIN}/${MVGEXEC}/input/${IMGDIRNAME}/out/* /home/repos/install/install/${IMGDIRNAME}/out_0121/
