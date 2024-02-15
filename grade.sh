CPATH='.;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

if [ -f "student-submission/ListExamples.java" ]
then
    echo "File found"
else
    SUBMISSION_FILEPATH=$(find student-submission -type f -name "ListExamples.java")
    if [ "$SUBMISSION_FILEPATH" == "" ]
    then
        echo "File ListExamples.java not found!"
        exit 1
    fi

    cp $SUBMISSION_FILEPATH student-submission/
fi

cp student-submission/ListExamples.java grading-area/
cp TestListExamples.java grading-area/
cp -r lib grading-area/

cd grading-area
javac -cp $CPATH *.java

if [ $? -ne 0 ]
then
    echo "Compilation error!"
    exit 1
fi

echo "Program compiled successfully!"

# echo $(java -cp $CPATH org.junit.runner.JUnitCore TestListExamples)
OUTPUT=$(java -cp $CPATH org.junit.runner.JUnitCore TestListExamples | tail -2 | head -1)
OK=$(echo "$OUTPUT" | awk '{print $1}')
if [ "$OK" == "OK" ]
then
    echo "All tests passed! Grade = 100%"
else
    TESTS=$(echo "$OUTPUT" | awk -F',| ' '{print $3}')
    FAILURES=$(echo "$OUTPUT" | awk -F',| ' '{print $7}')
    PASSES=$(( $TESTS - $FAILURES ))
    echo "$FAILURES test(s) failed! Grade = $PASSES/$TESTS"
fi


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
