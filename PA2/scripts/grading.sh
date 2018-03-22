CUR_PATH=`pwd`

CUR_DIR=${PWD##*/}
while [ $CUR_DIR != "compiler-96" ]
do
    cd ..
    CUR_DIR=${PWD##*/}
done

sudo cp PA2/scripts/grader.perl class/assignments/PA2

cd class/assignments/PA2
sudo perl grader.perl
cd $CUR_PATH
