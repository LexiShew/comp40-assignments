#! /bin/sh
testFiles=$(ls ./tests/*.um)
echo $testFiles
for testFile in $testFiles ; do
    echo $testFile
    echo
    
    testName=$(echo $testFile | sed -E 's/(.*).um/\1/')
    testGT=$testName".1"
    testIn=$testName".0"
    testOut=$testName".out"
    if [ -f $testIn ] ; then
        um $testFile < $testIn > $testGT
    else 
        um $testFile > $testGT
    fi

    if [ -f $testGT ] ; then
        if [ -f $testIn ] ; then
            ./um $testFile < $testIn > $testOut
        else 
            ./um $testFile > $testOut
        fi
        diff $testGT $testOut
    else
        echo "$testName has no output!" 
    fi
done
echo