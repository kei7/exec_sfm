編集するファイルはsetup.txtの中身のみ

以下例

MVGBUILDMAIN="/home/repos/openMVG_build" #openMVGをビルドしたディレクトリ,プロジェクトごとに固定
MVSBUILDMAIN="/home/repos/openMVS_build/bin" #openMVSをビルドしたディレクトリ,プロジェクトごとに固定
MVGEXEC="software/SfM" #openMVG内の相対パス。いじらない
MVGRELEASE="Linux-x86_64-RELEASE" #openMVG内の相対パス。いじらない
MAKEMODEL_NAME="exec_model" #ファイル生成に使うファイル名,他のファイルと名前が被らないようにする
IMGDIRPATH="/mnt/Omer/Project/04.ExTRaMapping/ModelData/Data/" #形状推定用の画像データの保存先,プロジェクトごとに固定
IMGOUTPATH="/mnt/Omer/Project/04.ExTRaMapping/ModelData/ReconstructResult" #形状推定結果の保存先,プロジェクトごとに固定

IMGDIRNAME="20190821-2" #形状データのディレクトリ名,再構成データのターゲットフォルダを書く
TYPE="Experiment" #Experiment とTESTでデータの種類を分けている
DATE="20190827" #再構成データの保存日
SHOTDATE="20190821" #画像データの撮影日
