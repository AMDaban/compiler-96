CUR_PATH=`pwd`

CUR_DIR=${PWD##*/}
while [ $CUR_DIR != "compiler-96" ]
do
    cd ..
    CUR_DIR=${PWD##*/}
done

sudo cp PA3/cool.y class/assignments/PA3
sudo cp PA3/README class/assignments/PA3
sudo cp PA3/good.cl class/assignments/PA3
sudo cp PA3/bad.cl class/assignments/PA3

cd class/assignments/PA3
sudo make parser
cd $CUR_PATH