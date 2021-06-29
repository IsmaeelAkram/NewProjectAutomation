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