import pyexiv2
import glob
import os,sys

#SRC_DIR = "/mnt/Omer/Project/04.ExTRaMapping/ModelData/Data/1990522-1/"
#OUT_DIR = "/mnt/Omer/Project/04.ExTRaMapping/ModelData/Data/1990522-1/"
TARGET_DIR = "/home/repos/openMVG_0120_build/software/SfM/input/{0}/images".format(sys.argv[2])
#REFDIR = "/mnt/Omer/Project/13.3DReconstruct/Data/Test/3dmorph/20190821/dat"
REFDIR = "{0}/install/install/".format(sys.argv[1])
if __name__=="__main__":
    ## smart phone

    filesSO = sorted(glob.glob(os.path.join(TARGET_DIR,"H*.jpg")))
    filesOPTA = sorted(glob.glob(os.path.join(TARGET_DIR,"OPTA*.jpg")))
    filesOPTB = sorted(glob.glob(os.path.join(TARGET_DIR,"OPTB*.jpg")))
    filesOPTC = sorted(glob.glob(os.path.join(TARGET_DIR,"OPTC*.jpg")))
    files1 = sorted(glob.glob(os.path.join(REFDIR,"bS*.jpg")))
    fi1 = files1[0]
    meta1 = pyexiv2.ImageMetadata(fi1)
    meta1.read()
    for i,fi in enumerate(filesSO):
        data = pyexiv2.ImageMetadata(fi)
        data.read()
        data["Exif.Image.Model"] = "SO-01K"
        #data["Exif.Image.Orientation"] = meta1["Exif.Image.Orientation"].value
        #data["Exif.Image.XResolution"] = meta1["Exif.Image.XResolution"].value
        #data["Exif.Image.YResolution"] = meta1["Exif.Image.YResolution"].value
        #data["Exif.Image.ResolutionUnit"] = meta1["Exif.Image.ResolutionUnit"].value
        #data["Exif.Image.Software"] = meta1["Exif.Image.Software"].value
        #data["Exif.Image.YCbCrPositioning"] = meta1["Exif.Image.YCbCrPositioning"].value
        #data["Exif.Photo.FNumber"] = meta1["Exif.Photo.FNumber"].value
        data["Exif.Photo.FocalLength"] = meta1["Exif.Photo.FocalLength"].value
        data["Exif.Photo.PixelXDimension"] = 1920#meta1["Exif.Photo.PixelXDimension"]
        data["Exif.Photo.PixelYDimension"] = 1080#meta1["Exif.Photo.PixelYDimension"]
        #data["Exif.Photo.DigitalZoomRatio"] = meta1["Exif.Photo.DigitalZoomRatio"].value
        #data["Exif.Thumbnail.Compression"] = meta1["Exif.Thumbnail.Compression"].value
        #data["Exif.Thumbnail.Orientation"] = meta1["Exif.Thumbnail.Orientation"].value
        #data["Exif.Thumbnail.XResolution"] = meta1["Exif.Thumbnail.XResolution"].value
        #data["Exif.Thumbnail.YResolution"] = meta1["Exif.Thumbnail.YResolution"].value
        #data["Exif.Thumbnail.ResolutionUnit"] = meta1["Exif.Thumbnail.ResolutionUnit"].value
        data.write()
    #High speed camera metadata write
    for i,fi in enumerate(filesOPTA):
        data = pyexiv2.ImageMetadata(fi)
        data.read()
        #data["Exif.Image.Model"] = "SA4-512A"
        data["Exif.Image.Model"] = "Mini-512A"
        data["Exif.Photo.FocalLength"] = meta1["Exif.Photo.FocalLength"].value
        data["Exif.Photo.PixelXDimension"] = 512
        data["Exif.Photo.PixelYDimension"] = 512
        data.write()
    for i,fi in enumerate(filesOPTB):
        data = pyexiv2.ImageMetadata(fi)
        data.read()
        #data["Exif.Image.Model"] = "SA4-512B"
        data["Exif.Image.Model"] = "Mini-512B"
        data["Exif.Photo.FocalLength"] = meta1["Exif.Photo.FocalLength"].value
        data["Exif.Photo.PixelXDimension"] = 512
        data["Exif.Photo.PixelYDimension"] = 512
        data.write()
    for i,fi in enumerate(filesOPTC):
        data = pyexiv2.ImageMetadata(fi)
        data.read()
        data["Exif.Image.Model"] = "Mini-512C"
        data["Exif.Photo.FocalLength"] = meta1["Exif.Photo.FocalLength"].value
        data["Exif.Photo.PixelXDimension"] = 512
        data["Exif.Photo.PixelYDimension"] = 512
        data.write()
