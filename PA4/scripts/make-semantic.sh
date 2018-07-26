CUR_PATH=`pwd`

CUR_DIR=${PWD##*/}
while [ $CUR_DIR != "compiler-96" ]
do
    cd ..
    CUR_DIR=${PWD##*/}
done

sudo cp PA4/semant.h class/assignments/PA4
sudo cp PA4/semant.cc class/assignments/PA4
sudo cp PA4/cool-tree.h class/assignments/PA4
sudo cp PA4/README class/assignments/PA4
sudo cp PA4/good.cl class/assignments/PA4
sudo cp PA4/bad.cl class/assignments/PA4

cd class/assignments/PA4
sudo make semant
cd $CUR_PATH