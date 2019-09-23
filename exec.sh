#!/bin/bash


##please edit setup file##

##setup
. ./setup.txt
##file preparation
if [ -d ${MVGBUILDMAIN}/${MVGEXEC}/input ];then
  echo "directory exists"
else
  mkdir ${MVGBUILDMAIN}/${MVGEXEC}/input
fi

cat ./model.py.in | sed -e "s#@OPENMVG_SOFTWARE_SFM_BUILD_DIR@#/home/repos/openMVG_build/Linux-x86_64-RELEASE#g" -e "s#@OPENMVG_SOFTWARE_SFM_SRC_DIR@#/home/repos/openMVG/src/software/SfM#g" -e "s#@IMGSRC@#${IMGDIRNAME}#g" > ./${MAKEMODEL_NAME}.py
mv ./${MAKEMODEL_NAME}.py ${MVGBUILDMAIN}/${MVGEXEC}/

#3dmorph image copy
cp -r ${IMGDIRPATH}/${TYPE}/3dmorph/${SHOTDATE}/morph/${IMGDIRNAME} ${MVGBUILDMAIN}/${MVGEXEC}/input/

#high speed camera image copy
cp ${IMGDIRPATH}/${TYPE}/optical/${SHOTDATE}/${PATH_OPTDATA}/*.jpg ${MVGBUILDMAIN}/${MVGEXEC}/input/${IMGDIRNAME}/images

#camera image sensor width copy
cp -i ./sensor_width_camera_database.txt /home/repos/openMVG/src/openMVG/exif/sensor_width_database/

#change exif
python ./chexif.py ${IMGREFPATH} ${IMGDIRNAME}

cp -r ${MVGBUILDMAIN}/${MVGEXEC}/input/${IMGDIRNAME} ${MVSBUILDMAIN}/undistorted_images/

###################
######execute######
###################

python ${MVGBUILDMAIN}/${MVGEXEC}/${MAKEMODEL_NAME}.py

# data export
${MVGBUILDMAIN}/${MVGRELEASE}/openMVG_main_openMVG2openMVS -i ${MVGBUILDMAIN}/${MVGEXEC}/input/${IMGDIRNAME}/out/reconstruction_sequential/sfm_data.bin -o ${MVGBUILDMAIN}/${MVGEXEC}/input/${IMGDIRNAME}/out/reconstruction_sequential/scene.mvs

#openmvs change data
${MVSBUILDMAIN}/DensifyPointCloud ${MVGBUILDMAIN}/${MVGEXEC}/input/${IMGDIRNAME}/out/reconstruction_sequential/scene.mvs

#mesh reconstruction
${MVSBUILDMAIN}/ReconstructMesh ${MVGBUILDMAIN}/${MVGEXEC}/input/${IMGDIRNAME}/out/reconstruction_sequential/scene_dense.mvs

#texturemesh
${MVSBUILDMAIN}/TextureMesh ${MVGBUILDMAIN}/${MVGEXEC}/input/${IMGDIRNAME}/out/reconstruction_sequential/scene_dense_mesh.mvs

#copy output
mkdir -p ${IMGOUTPATH}/${TYPE}/${SHOTDATE}/${DATE}/${IMGDIRNAME}
cp -r ${MVGBUILDMAIN}/${MVGEXEC}/input/${IMGDIRNAME}/out/* ${IMGOUTPATH}/${TYPE}/${SHOTDATE}/${DATE}/${IMGDIRNAME}
