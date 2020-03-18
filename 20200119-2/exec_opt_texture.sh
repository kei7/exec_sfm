#!/bin/bash
#optical texture for model
. ./setup.txt

cp -r /home/repos/install/install/${IMGDIRNAME}/opt ${MVGBUILDMAIN}/${MVGEXEC}/input/${IMGDIRNAME}/opt
python opt_list.py /home/repos ${IMGDIRNAME}

mkdir /home/repos/install/install/${IMGDIRNAME}/opt_out

cat opt_list.txt | while read line
do
  cp $line ${MVSBUILDMAIN}/undistorted_image/${IMGDIRNAME}/images/OPTA0000001.jpg
  ${MVSBUILDMAIN}/TextureMesh ${MVGBUILDMAIN}/${MVGEXEC}/input/${IMGDIRNAME}/out/reconstruction_sequential/scene_dense_mesh.mvs
  mv ${MVGBUILDMAIN}/${MVGEXEC}/input/${IMGDIRNAME}/out/reconstruction_sequential/scene_dense_mesh_texture.ply /home/repos/install/install/${IMGDIRNAME}/opt_out/scene_dense_mesh_texture_$line.ply
  mv ${MVGBUILDMAIN}/${MVGEXEC}/input/${IMGDIRNAME}/out/reconstruction_sequential/scene_dense_mesh_texture.png /home/repos/install/install/${IMGDIRNAME}/opt_out/scene_dense_mesh_texture_$line.png
done 
