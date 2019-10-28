
<img src="./images/logo.png" width="130">

# Cyclop

## Introduction

While working recently, I had to deal with a slight problem, that of programming and executing the command each time to test my code and the changes I had just made. Admittedly, it's pretty tiring, so I searched everywhere on the web and I came across some great tools to do this like WatchMan from Facebook (by the way, too HEAVY :-( ).

The "PROBLEM" with all these solutions made in "Rust", "Python", "Java" or even "C ++" is that I must first install an entire environment, or packages for others .... let's Serious, it's way too heavy!

I think to create a tool that does not require any dependence such as the name of Cyclops in shell form, executable by all computers having bash only (99% i guess lol).

## Requirements

- **NOTHING** (By nothing, i mean, you don't need any language required, any installation required, any package required, etc...)

## How it's work

The technique is quite simple in itself, I do a hash calculation, which allows me to detect that a modification was made in a file or not, if it is the case I execute the command for which it was configure, that's it!
Easy is not it? :-)

The advantage with cyclops is that the use can be in another context, Example, I want to execute an X script if a Y.json file changes or update! Everything is configurable :-)


## How to use it


### Watch files

You need to use the `f` parameter to watch files, as follow :

This is how to use it :
`./cyclop.sh f '( ["./path/to/file/to/watch"]="command to execute when the file content will change" )'`

Some implementations examples:

```shell
# For C
./cyclop.sh f '( ["./tests/test.c"]="gcc ./tests/test.c && ./a.out" )'

# For C++
./cyclop.sh f '( ["./tests/test.cpp"]="g++ ./tests/test.cpp && ./a.out" )'

# For JAVA
./cyclop.sh f '( ["./tests/Test.java"]="javac ./tests/Test.java && cd tests && java Test && cd ../" )'

# For JAVASCRIPT
./cyclop.sh f '( ["./tests/test.js"]="node ./tests/test.js" )'

# For PYTHON
./cyclop.sh f '( ["./tests/test.py"]="python ./tests/test.py" )'

# For RUBY
./cyclop.sh f '( ["./tests/test.rb"]="ruby ./tests/test.rb" )'

# For Rust
./cyclop.sh f '(["./tests/test.rs"]="rustc ./tests/test.rs && ./test")'

# For LUA
./cyclop.sh f '(["./tests/test.lua"]="lua ./tests/test.lua")'

# For HASKELL
./cyclop.sh f '(["./tests/test.hs"]="runhaskell ./tests/test.hs")'

# For ERLANG
./cyclop.sh f '(["./tests/test.erl"]="erl -s ./tests/test.erl")'

# For GO
./cyclop.sh f '(["./tests/test.go"]="go run ./tests/test.go")'

# You can combinate or add more LUA, Go, etc...

# or multiple watching at the same time
#
./cyclop.sh f '(["./tests/test.rb"]="ruby ./tests/test.rb" ["./tests/test.js"]="node ./tests/test.js" ["./tests/test.py"]="python ./tests/test.py")'
```

### Watch extensions

You need to use the `e` parameter to watch extensions's files, as follow :

This is how to use it :
`./cyclop.sh e './path/to/the/project/dir/' 'extension1 extension2 extension3' 'your command'`

Some implementations examples:

```shell
# For PY (All python files)
./cyclop.sh e './tests/' 'py' 'echo "Changes detected on PY file"'

# For C, CPP (All c and cpp files)
./cyclop.sh e './tests/' 'c cpp' 'echo "Changes detected on C, CPP file"'

# For JS, RB, JAVA (Watch All javascript, ruby and java files)
./cyclop.sh e './tests/' 'js rb java' 'echo "Changes detected on JS, RB, JAVA file"'
```

### Some tests

After cloning, you can test this command :

##### Command

```shell
./cyclop.sh e './tests/' 'js py rb' 'echo [+] Changes detected,Cyclop is amazing !!!'
```

This command will watch all file changes with extensions(`.js`, `.py` and `.rb`) in `./tests/` directory, and then execute your command, in this case : `echo [+] Changes detected,Cyclop is amazing !!!` !

##### Output

<img src="./images/output.png" />


### SOME DEMOS

**Note**: Some of theese demo are not for the latest version, some output could have been changed/updated.

- With an interpreted language (JavaScript):
![Demo1](./images/demo.gif)


- With a compiled language (C++):
![Demo2](./images/demo2.gif)

This is a video of the test with Cyclop on VSCODE : [SEE THE VIDEO](https://www.youtube.com/watch?v=xF5nznQwhcg)


## IMPORTANT NOTES

My Bash version is `4.3.32` on my Linux system, i didn't test Cyclop in many versions.

Cyclop have been test on :

- [TESTED] Linux (Ubuntu distribution)
- [TESTED] MacOS
- [NOT-YET] WINDOWS (Not yet, but with a cygin or an interpreter command on bash it should work,  will work for a .bat version specially for windows developers)

## Author

- Sanix-darker