#!/bin/sh
# PL-gnu.sh

cat s2_499/data.out | awk '{print $1-2000,$3}' > c499.dat
cat s2_500/data.out | awk '{print $1-2000,$3}' > c500.dat
cat s2_501/data.out | awk '{print $1-2000,$3}' > c501.dat
cat s2_502/data.out | awk '{print $1-2000,$3}' > c502.dat

gnuplot << EOM
#set term postscript eps color "Arial" 25
set term postscript eps enhanced "Arial" 25 color
set output "AP3.eps"

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

set xrange [-50:1850]
set yrange [-100:60]
set tics out scale 2.5
set xtics 0,500
set mxtics 1
set ytics -90,30
#set mytics 2

set border 3
set xtics nomirror
set ytics nomirror

#set size 1.2,1.1 
set size 0.9,1.0 
set origin 0.0,0.0

set xlabel "Time (s)"
set ylabel "V_{m} (mV)"

plot \
	"c500.dat" using 1:2 title "500" linestyle 1,\
	"c501.dat" using 1:2 title "501" linestyle 2,\
	"c502.dat" using 1:2 title "502" linestyle 3

quit
EOM
#test -f PL.$$ && rm PL.$$ 
if test "$DISPLAY" != ""
then i=`ps -U $USER | grep gv | egrep -v grep | awk '{print $1}' -`
 if test "$i" != ""
 then kill -1 $i
 else gv -scale=1 AP3.eps &
 fi
fi
