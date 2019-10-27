// ------
// Cyclope example, to test it, just add in FILE_TO_WATCH Array(in cyclope.sh) this command :
//
// ["./tests/test.js"]="node ./tests/test.js"
// So it will look like this : declare -A FILE_TO_WATCH=( ["./tests/test.js"]="node ./tests/test.js" )
// ------

helloWorld = () => {
    console.log("[+] Hello World on JS is amazing!");
    console.log("[+] WOW !!!")
}

helloWorld()