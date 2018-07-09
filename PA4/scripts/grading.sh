CUR_PATH=`pwd`

CUR_DIR=${PWD##*/}
while [ $CUR_DIR != "compiler-96" ]
do
    cd ..
    CUR_DIR=${PWD##*/}
done

sudo cp PA4/grader.pl class/assignments/PA4

cd class/assignments/PA4
sudo perl grader.pl
cd $CUR_PATH