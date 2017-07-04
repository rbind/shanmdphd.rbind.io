sed -e '1,3d' < ~/shanmdphd/cv/README.md > content/README.txt
cat content/cv.yaml content/README.txt > content/cv.md

