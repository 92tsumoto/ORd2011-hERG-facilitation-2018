#!/bin/sh
# PL-gnu.sh
m=1024

sed -e '49s/400/269/g' in > 269in
mkdir s2_269
./ORd_restitution 269in
mv *.out s2_269/
mv 269in s2_269/

sed -e '49s/400/268/g' in > 268in
mkdir s2_268
./ORd_restitution 268in
mv *.out s2_268/
mv 268in s2_268/

sed -e '49s/400/267/g' in > 267in
mkdir s2_267
./ORd_restitution 267in
mv *.out s2_267/
mv 267in s2_267/

sed -e '49s/400/266/g' in > 266in
mkdir s2_266
./ORd_restitution 266in
mv *.out s2_266/
mv 266in s2_266/

sed -e '49s/400/265/g' in > 265in
mkdir s2_265
./ORd_restitution 265in
mv *.out s2_265/
mv 265in s2_265/

sed -e '49s/400/264/g' in > 264in
mkdir s2_264
./ORd_restitution 264in
mv *.out s2_264/
mv 264in s2_264/

sed -e '49s/400/263/g' in > 263in
mkdir s2_263
./ORd_restitution 263in
mv *.out s2_263/
mv 263in s2_263/

sed -e '49s/400/262/g' in > 262in
mkdir s2_262
./ORd_restitution 262in
mv *.out s2_262/
mv 262in s2_262/

sed -e '49s/400/261/g' in > 261in
mkdir s2_261
./ORd_restitution 261in
mv *.out s2_261/
mv 261in s2_261/

