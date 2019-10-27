#!/bin/bash
#
#  / ___\ \ / / ___| |   / _ \|  _ \| ____|
# | |    \ V / |   | |  | | | | |_) |  _|
# | |___  | || |___| |__| |_| |  __/| |___
#  \____| |_| \____|_____\___/|_|   |_____|
#  ----------------------------------------
# A Watcher script that execute any command specified when a file change
# Made By Sanix-darker


# We run the import of the table
declare -A FILE_TO_WATCH=(["./tests/test.cpp"]="g++ ./tests/test.cpp && ./a.out")
#
# or multiple watching at the same time
#
# declare -A FILE_TO_WATCH=(["./tests/test.rb"]="ruby ./tests/test.rb" ["./tests/test.js"]="node ./tests/test.js" ["./tests/test.py"]="python ./tests/test.py")


# We specify if we want to see logs or not
SEE_LOGS=0

###
# The logger method
###
logger()
{
    if [ $SEE_LOGS = 1 ]
    then
        echo $1
    fi
}

###
# Main body of script starts here
###
echo "[+] Cyclope is Watching [${!FILE_TO_WATCH[@]}]"
sum1=""
while true
do
    for file in ${!FILE_TO_WATCH[@]}
    do
        sleep 1
        sum2="$(md5sum "$file")"
        logger "[+] $sum2"
        if [ "$sum1" = "$sum2" ];
        then
            sleep 1
        else
            clear
            echo "[+] Cyclope detected Changes on ${file}--------"
            echo "[+] ${FILE_TO_WATCH[$file]}"
            ${FILE_TO_WATCH[$file]}

            sum1="$(md5sum "$file")"
            logger "[+] $sum1"
        fi
    done
done