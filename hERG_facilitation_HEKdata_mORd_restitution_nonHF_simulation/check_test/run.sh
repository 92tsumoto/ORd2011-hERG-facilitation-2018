#!/bin/sh
# PL-gnu.sh
m=1024

sed -e '49s/400/400/g' in > 400in
mkdir s2_400
./ORd_restitution 400in
mv *.out s2_400/
mv 400in s2_400/

sed -e '49s/400/300/g' in > 300in
mkdir s2_300
./ORd_restitution 300in
mv *.out s2_300/
mv 300in s2_300/

sed -e '49s/400/290/g' in > 290in
mkdir s2_290
./ORd_restitution 290in
mv *.out s2_290/
mv 290in s2_290/

sed -e '49s/400/280/g' in > 280in
mkdir s2_280
./ORd_restitution 280in
mv *.out s2_280/
mv 280in s2_280/

sed -e '49s/400/270/g' in > 270in
mkdir s2_270
./ORd_restitution 270in
mv *.out s2_270/
mv 270in s2_270/

sed -e '49s/400/260/g' in > 260in
mkdir s2_260
./ORd_restitution 260in
mv *.out s2_260/
mv 260in s2_260/

sed -e '49s/400/250/g' in > 250in
mkdir s2_250
./ORd_restitution 250in
mv *.out s2_250/
mv 250in s2_250/

sed -e '49s/400/240/g' in > 240in
mkdir s2_240
./ORd_restitution 240in
mv *.out s2_240/
mv 240in s2_240/

