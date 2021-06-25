function create(){
    if [ $# -eq 0 ]
    then
        echo "No arguments supplied"
        return
    fi
    DIRECTORY=/Users/ismaeel/Code
    GIT_IGNORE=".vscode/\n*.env"

    cd "$DIRECTORY"

    if [ "$2" = "--private" ]
    then
        gh repo create "$1" -y --private
    else
        gh repo create "$1" -y --public
    fi
    cd "$1"
    touch README.md
    echo \# "$1" >> README.md 
    echo "$GIT_IGNORE" >> .gitignore
    git add .
    git commit -m "Initial commit"
    git push -u origin master
    code .
}

function remove(){
    if [ $# -eq 0 ]
    then
        echo "No arguments supplied"
        return
    fi
    DIRECTORY=/Users/ismaeel/Code
    GH_USERNAME="IsmaeelAkram"
    
    cd $DIRECTORY
    sudo rm -rf "$1"
    echo "Removed local directory. You're gonna have to delete the repo yourself."
    echo "https://github.com/$GH_USERNAME/$1/settings"
}

function creategit(){
    if [ $# -eq 0 ]
    then
        echo "No arguments supplied"
        return
    fi
    DIRECTORY=/Users/ismaeel/Code
    PYTHON_SCRIPT_DIR=/Users/ismaeel/Code/NewProjectAutomation
    GIT_IP=10.0.0.3
    GIT_IGNORE="*.env"

    python3 "$PYTHON_SCRIPT_DIR"/repo.py create "$1"

    cd $DIRECTORY
    mkdir "$1"
    cd "$1"
    touch README.md
    echo \# "$1" >> README.md 
    echo $GIT_IGNORE >> .gitignore
    git init
    git add .
    git commit -m "Initial commit"
    git remote add origin git@"$GIT_IP":/srv/git/"$1".git
    git push -u origin master
    code .
}

function removegit(){
    if [ $# -eq 0 ]
    then
        echo "No arguments supplied"
        return
    fi
    DIRECTORY=/Users/ismaeel/Code
    PYTHON_SCRIPT_DIR=/Users/ismaeel/Code/NewProjectAutomation

    python3 "$PYTHON_SCRIPT_DIR"/repo.py remove "$1"
    sudo rm -rf DIRECTORY/"$1"
}