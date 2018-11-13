#!/bin/sh
# PL-gnu.sh
m=1024

sed -e '49s/400/502/g' in > 502in
mkdir s2_502
./ORd_restitution 502in
mv *.out s2_502/
mv 502in s2_502/

sed -e '49s/400/504/g' in > 504in
mkdir s2_504
./ORd_restitution 504in
mv *.out s2_504/
mv 504in s2_504/

sed -e '49s/400/506/g' in > 506in
mkdir s2_506
./ORd_restitution 506in
mv *.out s2_506/
mv 506in s2_506/

sed -e '49s/400/508/g' in > 508in
mkdir s2_508
./ORd_restitution 508in
mv *.out s2_508/
mv 508in s2_508/


