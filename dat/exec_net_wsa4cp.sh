#!/bin/bash

##edit this
MAKEMODEL_NAME="make_model2"
IMGDIRPATH="/mnt/Omer/Project/04.ExTRaMapping/ModelData/Data/mod"
IMGOUTPATH="/mnt/Omer/Project/04.ExTRaMapping/ModelData"
IMGDIRNAME="190522-1_clf"
MVGBUILDMAIN="/home/repos/openMVG_build"
MVSBUILDMAIN="/home/repos/openMVS_build/bin"
MVGEXEC="software/SfM"
MVGRELEASE="Linux-x86_64-RELEASE"
DATE="20190807"

##file preparation
#mkdir ${MVGBUILDMAIN}/${MVGEXEC}/input
cp ./model.py.in ./make_model.py.in
cat ./model.py.in | sed -e "s#@OPENMVG_SOFTWARE_SFM_BUILD_DIR@#/home/repos/openMVG_build/Linux-x86_64-RELEASE#g" -e "s#@OPENMVG_SOFTWARE_SFM_SRC_DIR@#/home/repos/openMVG/src/software/SfM#g" -e "s#@IMGSRC@#${IMGDIRNAME}#g" > ./${MAKEMODEL_NAME}.py
mv ./${MAKEMODEL_NAME}.py ${MVGBUILDMAIN}/${MVGEXEC}/
cp -r ${IMGDIRPATH}/${IMGDIRNAME} ${MVGBUILDMAIN}/${MVGEXEC}/input/
cp -r ${IMGDIRPATH}/${IMGDIRNAME} ${MVSBUILDMAIN}/undistorted_images/
#execute
python ${MVGBUILDMAIN}/${MVGEXEC}/${MAKEMODEL_NAME}.py
# data export 
${MVGBUILDMAIN}/${MVGRELEASE}/openMVG_main_openMVG2openMVS -i ${MVGBUILDMAIN}/${MVGEXEC}/input/${IMGDIRNAME}/out/reconstruction_sequential/sfm_data.bin -o ${MVGBUILDMAIN}/${MVGEXEC}/input/${IMGDIRNAME}/out/reconstruction_sequential/scene.mvs
#openmvs change data
${MVSBUILDMAIN}/DensifyPointCloud ${MVGBUILDMAIN}/${MVGEXEC}/input/${IMGDIRNAME}/out/reconstruction_sequential/scene.mvs
#mesh reconstruction
${MVSBUILDMAIN}/ReconstructMesh ${MVGBUILDMAIN}/${MVGEXEC}/input/${IMGDIRNAME}/out/reconstruction_sequential/scene_dense.mvs 
#texturemesh
${MVSBUILDMAIN}/TextureMesh ${MVGBUILDMAIN}/${MVGEXEC}/input/${IMGDIRNAME}/out/reconstruction_sequential/scene_dense_mesh.mvs
mkdir ${IMGOUTPATH}/AnalysisResult/${DATE}/${IMGDIRNAME}
#cp ${MVGBUILDMAIN}/${MVGEXEC}/input/${IMGDIRNAME}/out/reconstruction_sequential/* ${IMGOUTPATH}/AnalysisResult/${IMGDIRNAME}/
cp -r ${MVGBUILDMAIN}/${MVGEXEC}/input/${IMGDIRNAME}/out/* ${IMGOUTPATH}/AnalysisResult/${DATE}/${IMGDIRNAME}/
