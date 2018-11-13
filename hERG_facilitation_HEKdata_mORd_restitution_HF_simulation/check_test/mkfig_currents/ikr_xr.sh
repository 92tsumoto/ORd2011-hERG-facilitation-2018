#!/bin/sh
# PL-gnu.sh

#cat ../control/s2_860/data.out | awk '{print $1-2000,$3}' > cont0.dat
#cat ../without_0.52175/s2_860/data.out | awk '{print $1-2000,$3}' > cont1.dat
#cat ../with_0.43334/s2_860/data.out | awk '{print $1-2000,$3}' > cont2.dat

cat ../control/s2_860/ikr_data.out | awk '{print ($1-2000),$5}' > cont0.dat
cat ../without_0.52175/s2_860/ikr_data.out | awk '{print ($1-2000),$5}' > cont1.dat
cat ../with_0.43334/s2_860/ikr_data.out | awk '{print ($1-2000),$5}' > cont2.dat
cat ../with_0.43334/s2_860/ikr_data.out | awk '{print ($1-2000),$6}' > cont3.dat

gnuplot << EOM
#set term postscript eps color "Arial" 25
set term postscript eps enhanced "Times" 25 color
set output "Ikr_xr.eps"

set key right top

set lmargin 10
set bmargin 5
set rmargin 10
set tmargin 5

#set size square

#set title "APs"

set style data lines
set style line 1 lt 2 linecolor 7 lw 2
set style line 2 lt 2 linecolor 2 lw 2
set style line 3 lt 2 linecolor 1 lw 2
set style line 4 lt 2 linecolor 5 lw 2
set style line 5 lt 2 linecolor 4 lw 2
set style line 6 lt 2 linecolor 1 lw 2
set style line 7 lt 2 linecolor 3 lw 2
set style line 8 lt 7 lw 3
set style line 9 pt 8 ps 3

set xrange [-50:1550]
set yrange [-0.05:1.05]
set tics out scale 2.5
set xtics 0,500
set mxtics 1
set ytics 0,0.5
set mytics 1

set border 3
set xtics nomirror
set ytics nomirror

#set size 1.2,1.0 
set size 0.9,1.0 
set origin 0.0,0.0

set xlabel "Time (s)"
set ylabel "Xr"

plot \
	"cont0.dat" using 1:2 title "" linestyle 1,\
	"cont1.dat" using 1:2 title "" linestyle 2,\
	"cont2.dat" using 1:2 title "" linestyle 3,\
	"cont3.dat" using 1:2 title "" linestyle 4

quit
EOM
#test -f PL.$$ && rm PL.$$ 
if test "$DISPLAY" != ""
then i=`ps -U $USER | grep gv | egrep -v grep | awk '{print $1}' -`
 if test "$i" != ""
 then kill -1 $i
 else gv -scale=1 Ikr_xr.eps &
 fi
fi
