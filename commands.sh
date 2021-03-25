function create(){
    DIRECTORY=/Users/ismaeel/Documents/Code

    if [ $# -eq 0 ]
    then
        echo "No arguments supplied"
        return
    fi
    cd $DIRECTORY
    gh repo create $1 -y --public
    cd $1
    touch README.md
    echo \# $1 >> README.md 
    git add .
    git commit -m "Initial commit"
    git push -u origin master
    code .
}