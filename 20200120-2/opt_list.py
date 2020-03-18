import pyexiv2
import glob
import os,sys,re

TARGET_DIR = "/home/repos/openMVG_build/software/SfM/input/{0}/opt".format(sys.argv[2])
REFDIR = "{0}/install/install/".format(sys.argv[1])
if __name__=="__main__":

    ## smart phone

    filesOPTA = sorted(glob.glob(os.path.join(TARGET_DIR,"OPTA*.jpg")))
    filesOPTB = sorted(glob.glob(os.path.join(TARGET_DIR,"OPTB*.jpg")))
    filesOPTC = sorted(glob.glob(os.path.join(TARGET_DIR,"OPTC*.jpg")))
    files1 = sorted(glob.glob(os.path.join(REFDIR,"bS*.jpg")))
    fi1 = files1[0]
    meta1 = pyexiv2.ImageMetadata(fi1)
    meta1.read()
    #for i,fi in enumerate(filesOPTA):
    #    data = pyexiv2.ImageMetadata(fi)
    #    data.read()
    #    data["Exif.Image.Model"] = "SA4-512A"
    #    data["Exif.Photo.FocalLength"] = meta1["Exif.Photo.FocalLength"].value
    #    data["Exif.Photo.PixelXDimension"] = 512
    #    data["Exif.Photo.PixelYDimension"] = 512
    #    data.write()
    #for i,fi in enumerate(filesOPTB):
    #    data = pyexiv2.ImageMetadata(fi)
    #    data.read()
    #    data["Exif.Image.Model"] = "SA4-512B"
    #    data["Exif.Photo.FocalLength"] = meta1["Exif.Photo.FocalLength"].value
    #    data["Exif.Photo.PixelXDimension"] = 512
    #    data["Exif.Photo.PixelYDimension"] = 512
    #    data.write()
    #for i,fi in enumerate(filesOPTC):
    #    data = pyexiv2.ImageMetadata(fi)
    #    data.read()
    #    data["Exif.Image.Model"] = "Mini-512C"
    #    data["Exif.Photo.FocalLength"] = meta1["Exif.Photo.FocalLength"].value
    #    data["Exif.Photo.PixelXDimension"] = 512
    #    data["Exif.Photo.PixelYDimension"] = 512
    #    data.write()
    files = sorted(glob.glob(os.path.join(TARGET_DIR,"OPTA*.jpg")))
    str_ = '\n'.join(files)
    with open("./opt_list.txt", 'wt') as f:
        f.write(str_)
    files_ = []
    for i,file in enumerate(files):
        files_.append(file[-10:-4])
    str_ = "\n".join(files_)
    with open("./opt_list_new.txt","wt") as f:
        f.write(str_)
