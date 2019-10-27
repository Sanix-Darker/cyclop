// ------
// Cyclope example, to test it, just add in FILE_TO_WATCH Array(in cyclope.sh) this command :
//
// ["./tests/Test.java"]="javac ./tests/Test.java && cd tests && java Test && cd ../"
// So it will look like this : declare -A FILE_TO_WATCH=( ["./tests/Test.java"]="javac ./tests/Test.java && cd tests && java Test && cd ../" )
// ------
class Test
{
    public static void main(String args[])
    {
        System.out.println("Hello, World on JAVA!");
    }
}