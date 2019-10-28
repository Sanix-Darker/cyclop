#!/bin/bash
#
#  / ___\ \ / / ___| |   / _ \|  _ \
# | |    \ V / |   | |  | | | | |_) |
# | |___  | || |___| |__| |_| |  __/
#  \____| |_| \____|_____\___/|_|
#  -----------------------------------
# A Watcher script that execute any command specified when a file change
# Made By Sanix-darker
#

# Some methods
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

array_key_exists()
{
    local _array_name="$1"
    local _key="$2"
    local _cmd='echo ${!'$_array_name'[@]}'
    local _array_keys=($(eval $_cmd))
    local _key_exists=$(echo " ${_array_keys[@]} " | grep " $_key " &>/dev/null; echo $?)
    [[ "$_key_exists" = "0" ]] && return 0 || return 1
}

execute_cmd()
{
    #clear
    echo "[+] Cyclop detected Changes on $2--------"
    echo "[+] Bash version: ${BASH_VERSION}."
    echo "[+] Command: '$1'"

    IFS='&&' read -ra command_list <<< "$1"
    echo ""
    echo "[+] --------------------------------------------------"
    for command in "${command_list[@]}"; do
        $command
    done
    echo "[+] --------------------------------------------------"
}

break_loop_if_a_file_allready_changed()
{
    # We will Break the loop if a file in the list is allready change
    if ["$1"="1"]; then
        break
    fi
}


if [ "$1" = "f" ];
then

    # We run the import of the table
    declare -A FILE_TO_WATCH=$2
    #
    # or multiple watching at the same time
    #
    # declare -A FILE_TO_WATCH=(["./tests/test.rb"]="ruby ./tests/test.rb" ["./tests/test.js"]="node ./tests/test.js" ["./tests/test.py"]="python ./tests/test.py")

    ###
    # Main body of script starts here
    ###
    echo "[+] cyclop is Watching [${!FILE_TO_WATCH[@]}]"
    sum1=""
    while true
    do
        for file in ${!FILE_TO_WATCH[@]}
        do
            sum2="$(md5sum "$file")"
            logger "[+] $sum2"
            if [ "$sum1" != "$sum2" ];
            then
                # We execute the command here,
                # we pass the command and the file
                execute_cmd "${FILE_TO_WATCH[$file]}" $file

                sum1="$(md5sum "$file")"
                logger "[+] $sum1"
            fi
        done
    done
# extension list, the logic here is to save in an associativ array the list of all file with a specific extensions,
# and thier checkSum then looping throught them and execute a specific command when things changes
elif [ "$1" = "e" ];
then
    # We run the import of the table
    # declare -A EXTENSIONS_TO_WATCH=$2
    DIRECTORY_TO_WATCH=$2 # For example './tests/'
    EXTENSIONS_TO_WATCH=(js py rb)  # =$3
    COMMAND_TO_EXECUTE='cat test.txt' # =$3

    echo "[+] Cyclop is Watching file with extensions : [${EXTENSIONS_TO_WATCH[@]}] in ${DIRECTORY_TO_WATCH}"
    declare -A ARRAY_SUM
    while true
    do
        sleep 5
        BREAK_IF_CHANGE="0" # This parameter will tell if we need to break the loop, when a file change
        # We loop all over the extension
        for ext in ${EXTENSIONS_TO_WATCH[@]}
        do

            # break_loop_if_a_file_allready_changed "$BREAK_IF_CHANGE"

            # We loop all over the file with the extension provided
            for file_ext in "${DIRECTORY_TO_WATCH}*.$ext"
            do

                for file_ext_elt in ${file_ext}
                do
                    echo $file_ext_elt
                    echo "$file_sum"
                    file_sum="$(md5sum ${file_ext_elt})"
                    if [[ "$(array_key_exists 'ARRAY_SUM' 'file_ext_elt'; echo $?)" = "1" ]]; then
                        $ARRAY_SUM[$file_ext_elt]=$file_ext_elt
                        echo "File added"
                    else
                        if [ ${ARRAY_SUM[$file_ext_elt]}!=$file_sum ]; then
                            echo "Something changed on $file_ext_elt"
                        fi
                    fi

                    # if [ $sum["'${file_ext_elt}'"]!="'$file_sum'" ];
                    # then
                    #     # We execute the command here,
                    #     # we pass the command and the file
                    #     execute_cmd "${COMMAND_TO_EXECUTE}" "(js py rb)"
                    #     BREAK_IF_CHANGE="1"
                    # fi

                    echo "sun: $ARRAY_SUM"

                done
                # for file_ext_elt in $file_ext

                #     # if [ $sum["'${file_ext_elt}'"]!="'$file_sum'" ];
                #     # then
                #     #     # We execute the command here,
                #     #     # we pass the command and the file
                #     #     execute_cmd "${COMMAND_TO_EXECUTE}" "(js py rb)"
                #     #     BREAK_IF_CHANGE="1"
                #     # fi

                #     # break_loop_if_a_file_allready_changed "$BREAK_IF_CHANGE"
                #     echo "loop"
                # done

                # break_loop_if_a_file_allready_changed "$BREAK_IF_CHANGE"
            done
        done
    done

    echo "This feature not ready yet !"
    sleep 1
else
    echo 'Bad parameters provided, have a look at the documentation !'
fi