#!/bin/sh
# PL-gnu.sh
m=1024

sed -e '49s/400/499/g' in > 499in
mkdir s2_499
./ORd_restitution 499in
mv *.out s2_499/
mv 499in s2_499/

sed -e '49s/400/501/g' in > 501in
mkdir s2_501
./ORd_restitution 501in
mv *.out s2_501/
mv 501in s2_501/


