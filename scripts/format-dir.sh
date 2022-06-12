#bash
#Recurses through the sub directories from run root and fmt the files.
find . \! -name .terrafor* \! -name modules -type d -exec terraform fmt {} \;