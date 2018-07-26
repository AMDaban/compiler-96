CUR_PATH=`pwd`

CUR_DIR=${PWD##*/}
while [ $CUR_DIR != "compiler-96" ]
do
    cd ..
    CUR_DIR=${PWD##*/}
done

sudo cp PA5/grader.pl class/assignments/PA5

cd class/assignments/PA5
sudo perl grader.pl
python3 grader.py
cd $CUR_PATH
