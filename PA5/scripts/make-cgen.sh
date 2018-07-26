CUR_PATH=`pwd`

CUR_DIR=${PWD##*/}
while [ $CUR_DIR != "compiler-96" ]
do
    cd ..
    CUR_DIR=${PWD##*/}
done

sudo cp PA5/cgen.h class/assignments/PA5
sudo cp PA5/cgen.cc class/assignments/PA5
sudo cp PA5/cool-tree.handcode.h class/assignments/PA5
sudo cp PA5/grader.pl class/assignments/PA5
sudo cp PA5/grader.py class/assignments/PA5

cd class/assignments/PA5
sudo make cgen
cd $CUR_PATH
