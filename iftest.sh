if [ "$2" = "--private" ]
then
    echo private
elif [ "$2" = "--local" ]
then
    echo not making one
else
    echo public
fi