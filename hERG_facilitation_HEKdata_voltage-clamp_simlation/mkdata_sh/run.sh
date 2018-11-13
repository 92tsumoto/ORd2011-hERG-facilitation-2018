#!/bin/sh
# PL-gnu.sh
m=1024

sed -e '14s/-80/-100/g' in > m100in
./HERG m100in
mv data.out m100mV.out

sed -e '14s/-80/-90/g' in > m90in
./HERG m90in
mv data.out m90mV.out

sed -e '14s/-80/-80/g' in > m80in
./HERG m80in
mv data.out m80mV.out

sed -e '14s/-80/-70/g' in > m70in
./HERG m70in
mv data.out m70mV.out

sed -e '14s/-80/-60/g' in > m60in
./HERG m60in
mv data.out m60mV.out

sed -e '14s/-80/-50/g' in > m50in
./HERG m50in
mv data.out m50mV.out

sed -e '14s/-80/-40/g' in > m40in
./HERG m40in
mv data.out m40mV.out

sed -e '14s/-80/-30/g' in > m30in
./HERG m30in
mv data.out m30mV.out

sed -e '14s/-80/-20/g' in > m20in
./HERG m20in
mv data.out m20mV.out

sed -e '14s/-80/-10/g' in > m10in
./HERG m10in
mv data.out m10mV.out

sed -e '14s/-80/0/g' in > p0in
./HERG p0in
mv data.out 0mV.out

sed -e '14s/-80/10/g' in > p10in
./HERG p10in
mv data.out 10mV.out

sed -e '14s/-80/20/g' in > p20in
./HERG p20in
mv data.out 20mV.out

sed -e '14s/-80/30/g' in > p30in
./HERG p30in
mv data.out 30mV.out

sed -e '14s/-80/40/g' in > p40in
./HERG p40in
mv data.out 40mV.out

sed -e '14s/-80/50/g' in > p50in
./HERG p50in
mv data.out 50mV.out

sed -e '14s/-80/60/g' in > p60in
./HERG p60in
mv data.out 60mV.out


