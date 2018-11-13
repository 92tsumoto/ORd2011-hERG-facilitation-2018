#!/bin/sh
# PL-gnu.sh
m=1024

sed -e '49s/400/440/g' in > 440in
mkdir s2_440
./ORd_restitution 440in
mv *.out s2_440/
mv 440in s2_440/

sed -e '49s/400/450/g' in > 450in
mkdir s2_450
./ORd_restitution 450in
mv *.out s2_450/
mv 450in s2_450/

sed -e '49s/400/460/g' in > 460in
mkdir s2_460
./ORd_restitution 460in
mv *.out s2_460/
mv 460in s2_460/

sed -e '49s/400/470/g' in > 470in
mkdir s2_470
./ORd_restitution 470in
mv *.out s2_470/
mv 470in s2_470/

sed -e '49s/400/480/g' in > 480in
mkdir s2_480
./ORd_restitution 480in
mv *.out s2_480/
mv 480in s2_480/

sed -e '49s/400/490/g' in > 490in
mkdir s2_490
./ORd_restitution 490in
mv *.out s2_490/
mv 490in s2_490/

sed -e '49s/400/500/g' in > 500in
mkdir s2_500
./ORd_restitution 500in
mv *.out s2_500/
mv 500in s2_500/

sed -e '49s/400/510/g' in > 510in
mkdir s2_510
./ORd_restitution 510in
mv *.out s2_510/
mv 510in s2_510/

