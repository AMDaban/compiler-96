CUR_PATH=`pwd`

CUR_DIR=${PWD##*/}
while [ $CUR_DIR != "compiler-96" ]
do
    cd ..
    CUR_DIR=${PWD##*/}
done

sudo cp PA2/cool.flex class/assignments/PA2
sudo cp PA2/README class/assignments/PA2
sudo cp PA2/test.cl class/assignments/PA2

cd class/assignments/PA2
sudo make lexer
cd $CUR_PATH