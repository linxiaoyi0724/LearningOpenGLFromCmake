function main(){

    cd ../
    # rf -rm build
    mkdir build
    cd build/
    cmake .. -G "Visual Studio 15 2017 Win64"
}

main