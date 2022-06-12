#bash
#Recurses through the sub directories from run root and fmt the files.
for file in $(find . \! -name .terrafor* \! -name modules -type d)
do
    count=`find $file -maxdepth 1 -name *.tf -print 2>/dev/null | wc -l`
    if [ $count != 0 ]; then
        echo "Validating Directory ${file}"
        $(terraform validate $file)
    fi
done