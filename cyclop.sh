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
SEE_LOGS="0"

###
# The logger method
###
logger()
{
    if [ "$SEE_LOGS" = "1" ] # "0" for the oppossite
    then
        echo $1
    fi
}

###
# This method check if a key is available in an array
###
array_key_exists()
{
    local _array_name="$1"
    local _key="$2"
    local _cmd='echo ${!'$_array_name'[@]}'
    local _array_keys=($(eval $_cmd))
    local _key_exists=$(echo " ${_array_keys[@]} " | grep " $_key " &>/dev/null; echo $?)
    [[ "$_key_exists" = "0" ]] && return 0 || return 1
}

###
# The execute command
###
execute_cmd()
{
    clear
    echo "[+] ------------------------------------------------------------"
    echo "[+] Cyclop detected Changes on '$2'"
    echo "[+] BASH VERSION: [${BASH_VERSION}.]"
    echo "[+] WATCHING: [$3]"
    echo "[+] MD5SUM-FILE: '$(md5sum $2)'"
    echo "[+] COMMAND: '$1'"

    IFS='&&' read -ra command_list <<< "$1"
    echo ""
    echo "[+] ------------------------------------------------------------"
    for command in "${command_list[@]}"; do
        $command
    done
    echo ""
    echo "[+] ------------------------------------------------------------"
}



#####
# Main body of script starts here
#####
if [ "$1" = "f" ]; then

    # We run the import of the table
    declare -A FILE_TO_WATCH=$2

    echo "[+] Cyclop is Watching [${!FILE_TO_WATCH[@]}]"
    sum1=""
    while true
    do
        sleep 1
        for file in ${!FILE_TO_WATCH[@]}
        do
            sum2="$(md5sum "$file")"
            logger "[+] $sum2"
            if [ "$sum1" != "$sum2" ];
            then
                # We execute the command here,
                # we pass the command and the file
                execute_cmd "${FILE_TO_WATCH[$file]}" $file $file
                sum1="$(md5sum "$file")"
                logger "[+] $sum1"
            fi
        done
    done
elif [ "$1" = "e" ]; then # extension list, the logic here is to save in an associativ array the list of all file with a specific extensions,
                            # and thier checkSum then looping throught them and execute a specific command when things changes

    # We run the import of the table
    DIRECTORY_TO_WATCH=$2 # For example './tests/'
    EXTENSIONS_TO_WATCH=$3  # For example 'js py rb'
    COMMAND_TO_EXECUTE=$4 # For example 'echo "Cyclop works"'

    echo "[+] Cyclop is Watching file with extensions : [${EXTENSIONS_TO_WATCH[@]}] in ${DIRECTORY_TO_WATCH}"
    declare -A ARRAY_SUM=()

    # We loop all over the extension
    for ext in ${EXTENSIONS_TO_WATCH[@]}
    do
        SUB_DIR_PATCH_LIST=('*.' '*/*.' '*/*/*.' '*/*/*/*.' '*/*/*/*/*.' '*/*/*/*/*/*.' \
        '*/*/*/*/*/*/*.' '*/*/*/*/*/*/*/*.' '*/*/*/*/*/*/*/*/*.' '*/*/*/*/*/*/*/*/*/*.' \
        '*/*/*/*/*/*/*/*/*/*/*.' '*/*/*/*/*/*/*/*/*/*/*/*.' '*/*/*/*/*/*/*/*/*/*/*/*/*.' \
        '*/*/*/*/*/*/*/*/*/*/*/*/*/*.' '*/*/*/*/*/*/*/*/*/*/*/*/*/*/*.' '*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*.')
        for ext_p in ${SUB_DIR_PATCH_LIST[@]}
        do
            # We loop all over the file with the extension provided
            for file_ext in "${DIRECTORY_TO_WATCH}$ext_p$ext"
            do
                for file_ext_elt in ${file_ext}
                do
                    if test -f "$file_ext_elt"; then
                        if [[ "$(array_key_exists 'ARRAY_SUM' $file_ext_elt; echo $?)" = "1" ]]; then
                            ARRAY_SUM[$file_ext_elt]=""
                            logger ">>>> File added to array: $file_ext_elt"
                        fi
                    fi
                done
            done
        done
    done

    # Now, the infinite loop !
    while true
    do
        sleep 1
        for file_ext_elt in ${!ARRAY_SUM[@]}
        do
            file_sum="$(md5sum ${file_ext_elt})"
            if [ "${ARRAY_SUM[$file_ext_elt]}" != "${file_sum}" ]; then
                ARRAY_SUM["$file_ext_elt"]="${file_sum}"

                # We execute the command here,
                # we pass the command and the file
                execute_cmd "${COMMAND_TO_EXECUTE}" $file_ext_elt "${EXTENSIONS_TO_WATCH[@]}"
                break
            fi
        done
    done
else
    echo 'Bad parameters provided, have a look at the documentation (e or f) need to be provided!'
fi