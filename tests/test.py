# ------
# cyclop example, to test it, just add in FILE_TO_WATCH Array(in cyclop.sh) this command :
#
# ["./tests/test.py"]="python ./tests/test.py"
# So it will look like this : declare -A FILE_TO_WATCH=( ["./tests/test.py"]="python ./tests/test.py" )
# ------

def helloWorld():
    print("Hello World !")

helloWorld()