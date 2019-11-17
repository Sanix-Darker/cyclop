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
######
logger()
{
    if [ "$SEE_LOGS" = "1" ];then # "0" for the oppossite
        echo $1
    fi
}


###
# The Checksum method
######
checkSum()
{
    value=""
    # We check the system, then we compute the md5Sum
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        value=$(md5sum $1)
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        value=$(md5 $1)
    elif [[ "$OSTYPE" == "cygwin" ]]; then
        # POSIX compatibility layer and Linux environment emulation for Windows
        value=$(md5sum $1)
    elif [[ "$OSTYPE" == "msys" ]]; then
        # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
        value=$(FCIV -md5 -sha1 $1)
    elif [[ "$OSTYPE" == "win32" ]]; then
        # I'm not sure this can happen.
        value=$(FCIV -md5 -sha1 $1)
    elif [[ "$OSTYPE" == "freebsd"* ]]; then
        value=$(md5sum $1)
    else
        # Unknown.
        echo "Unknown System"
        value="$(md5sum $1)"
    fi
    echo $value
}


###
# This method check if a key is available in an array
######
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
######
execute_cmd()
{
    clear
    echo "[+] ------------------------------------------------------------"
    echo "[+] CYCLOP: BASH VERSION: [${BASH_VERSION}.], OS: [${OSTYPE}], WATCHING: [$3]"
    echo "[+] CHANGES DETECTED ON: '$2', MD5SUM-FILE: '"$(checkSum $2)"'"
    echo "[+] COMMAND: '$1'"
    IFS='&&' read -ra command_list <<< "$1"
    echo "[+] ------------------------------------------------------------"
    for command in "${command_list[@]}"; do
        $command
    done
    echo "[+] ------------------------------------------------------------"
}


# ----------

#####
# Main body of script starts here
######
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
            sum2=$(checkSum $file)
            logger "[+] $sum2"
            if [ "$sum1" != "$sum2" ];
            then
                # We execute the command here,
                # we pass the command and the file
                execute_cmd "${FILE_TO_WATCH[$file]}" $file $file
                sum1=$(checkSum $file)
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
        '*/*/*/*/*/*/*.' '*/*/*/*/*/*/*/*.' '*/*/*/*/*/*/*/*/*.' '*/*/*/*/*/*/*/*/*/*.' )
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
            file_sum=$(checkSum ${file_ext_elt})
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
    echo 'Bad parameters provided, have a look at the README DOCUMENTATION (with parameters e or f) need to be provided!'
fi