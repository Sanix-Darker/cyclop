#!/bin/bash
#
#  / ___\ \ / / ___| |   / _ \|  _ \
# | |    \ V / |   | |  | | | | |_) |
# | |___  | || |___| |__| |_| |  __/
#  \____| |_| \____|_____\___/|_|
#  -----------------------------------
# A Watcher script that execute any command specified when a file change
# Made By Sanix-darker


if [ "$1" = "f" ];
then

    # We run the import of the table
    declare -A FILE_TO_WATCH=$2
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
    echo "[+] cyclop is Watching [${!FILE_TO_WATCH[@]}]"
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
                echo "[+] cyclop detected Changes on ${file}--------"

                # if [[ ${FILE_TO_WATCH[$file]} == *"&&"* ]]; then
                #     echo "It's there!"
                # fi
                # echo "[+] ${FILE_TO_WATCH[$file]}"
                # ${FILE_TO_WATCH[$file]}

                IFS='&&' read -ra command_list <<< "${FILE_TO_WATCH[$file]}"
                for command in "${command_list[@]}"; do
                    echo "[+] ${command}"
                    $command
                done

                sum1="$(md5sum "$file")"
                logger "[+] $sum1"
            fi
        done
    done

elif [ "$1" = "e" ]; # extension list
then
    sleep 1
else
    echo "Bad parameters provided !"
fi