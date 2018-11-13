#!/bin/sh
# PL-gnu.sh

cat s2_500/data.out | awk '{print $1-2000,$3}' > c500.dat
cat s2_502/data.out | awk '{print $1-2000,$3}' > c502.dat
cat s2_504/data.out | awk '{print $1-2000,$3}' > c504.dat
cat s2_506/data.out | awk '{print $1-2000,$3}' > c506.dat
cat s2_508/data.out | awk '{print $1-2000,$3}' > c508.dat
cat s2_510/data.out | awk '{print $1-2000,$3}' > c510.dat

gnuplot << EOM
#set term postscript eps color "Arial" 25
set term postscript eps enhanced "Times" 25 color
set output "AP2.eps"

set key right top

set lmargin 10
set bmargin 5
set rmargin 10
set tmargin 5

#set size square

#set title "APs"

set style data lines
set style line 1 lt 2 linecolor 7 lw 2
set style line 2 lt 2 linecolor 1 lw 2
set style line 3 lt 2 linecolor 3 lw 2
set style line 4 lt 2 linecolor 5 lw 2
set style line 5 lt 2 linecolor 4 lw 2
set style line 6 lt 2 linecolor 1 lw 2
set style line 7 lt 2 linecolor 3 lw 2
set style line 8 lt 7 lw 3
set style line 9 pt 8 ps 3

set xrange [-50:1050]
set yrange [-100:60]
set tics out scale 2.5
set xtics 0,500
set mxtics 1
set ytics -90,30
#set mytics 2

set border 3
set xtics nomirror
set ytics nomirror

set size 1.2,1.1 
#set size 0.9,1.0 
set origin 0.0,0.0

set xlabel "Time (s)"
set ylabel "V_{m} (mV)"

plot \
	"c500.dat" using 1:2 title "500" linestyle 1,\
	"c502.dat" using 1:2 title "502" linestyle 2,\
	"c504.dat" using 1:2 title "504" linestyle 3,\
	"c506.dat" using 1:2 title "506" linestyle 4,\
	"c508.dat" using 1:2 title "508" linestyle 5,\
	"c510.dat" using 1:2 title "510" linestyle 6

quit
EOM
#test -f PL.$$ && rm PL.$$ 
if test "$DISPLAY" != ""
then i=`ps -U $USER | grep gv | egrep -v grep | awk '{print $1}' -`
 if test "$i" != ""
 then kill -1 $i
 else gv -scale=1 AP2.eps &
 fi
fi
