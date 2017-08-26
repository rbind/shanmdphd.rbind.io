sed -e '1,3d' < ~/shanmdphd/cv/README.md > README.txt
cat cv.yaml README.txt > cv.md
# dos2unix.exe cv.md #http://www.theunixschool.com/2011/03/different-ways-to-delete-m-character-in.html
