fullname=$(basename "$1")
name="${fullname%.*}"

mkdir build
echo "var ${name}Compiled=`solc --optimize --combined-json abi,bin $1`" > "./build/$name.js"
