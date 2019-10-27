# Cyclope

## Introduction

While working recently, I had to deal with a slight problem, that of programming and executing the command each time to test my code and the changes I had just made. Admittedly, it's pretty tiring, so I searched everywhere on the web and I came across some great tools to do this like WatchMan from Facebook (HEAVY).
The "PROBLEM" with all these solutions made in "Rust", "Python", "Java" or even "C ++" is that I must first install an entire environment, or packages for others .... let's Serious, it's way too heavy!
I think to create a tool that does not require any dependence such as the name of Cyclops in shell form, executable by all computers having bash only (99% i guess lol).

## Requirements

- Any (By any, i mean any language required, any installation required, any package required, etc...)

## How it's work

The technique is quite simple in itself, I do a hash calculation, which allows me to detect that a modification was made in a file or not, if it is the case I execute the command for which it was configure, that's it!
Easy is not it?
The advantage with cyclops is that the use can be in another context, Example, I want to execute an X script if a Y.json file changes or update! Everything is configurable :-)


## how to use it

In cyclope.sh, you just need to configure the path of the file to watch and the command to do.

```shell
# We run the import of the table
declare -A FILE_TO_WATCH=(["./tests/test.js"]="node ./tests/test.js")
#
# or multiple watching at the same time
#
# declare -A FILE_TO_WATCH=(["./tests/test.rb"]="ruby ./tests/test.rb" ["./tests/test.js"]="node ./tests/test.js" ["./tests/test.py"]="python ./tests/test.py")
```

## Tests

You can perform some tests with all available programs in ./test/ by just replace or add :

```shell

# For C
declare -A FILE_TO_WATCH=( ["./tests/test.c"]="gcc ./tests/test.c && ./a.out" )

# For C++
declare -A FILE_TO_WATCH=( ["./tests/test.cpp"]="g++ ./tests/test.c && ./a.out" )

# For JAVA
declare -A FILE_TO_WATCH=( ["./tests/Test.java"]="javac ./tests/Test.java && cd tests && java Test && cd ../" )

# For JAVASCRIPT
declare -A FILE_TO_WATCH=( ["./tests/test.js"]="node ./tests/test.js" )

# For PYTHON
declare -A FILE_TO_WATCH=( ["./tests/test.py"]="python ./tests/test.py" )

# For RUBY
declare -A FILE_TO_WATCH=( ["./tests/test.rb"]="ruby ./tests/test.rb" )

# You can combinate or add more LUA, Go, etc...

```


## DEMO


## Author

- Sanix-darker