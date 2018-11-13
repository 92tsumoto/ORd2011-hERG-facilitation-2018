#!/bin/sh
# PL-gnu.sh
m=1024

cat control/data.out | awk '{print $1/1000,$3}' > cont.dat
cat without/data.out | awk '{print $1/1000,$3}' > without.dat
cat with/data.out | awk '{print $1/1000,$3}' > with.dat

gnuplot << EOM
#set term postscript eps color "Arial" 25
set term postscript eps enhanced "Times" 25 color
set output "APclamp_time.eps"

set key right top

set lmargin 10
set bmargin 5
set rmargin 10
set tmargin 5

#set size square

#set title "Ikr"

set style data lines
set style line 1 lt 2 linecolor 7 lw 1
set style line 2 lt 2 linecolor 2 lw 1
set style line 3 lt 2 linecolor 1 lw 1
set style line 4 lt 2 linecolor 3 lw 1
set style line 5 lt 2 linecolor 5 lw 1
set style line 6 lt 2 linecolor 4 lw 1
set style line 7 lt 2 linecolor 7 lw 1
set style line 8 lt 7 lw 3
set style line 9 pt 8 ps 3

set xrange [0.0:0.8]
set yrange [-0.1:1.2]
set tics out scale 3
set xtics 0,0.2
set mxtics 1
set ytics 0,0.5
set mytics 1

#set yzeroaxis 
#set xzeroaxis 

set border 3
set xtics nomirror
set ytics nomirror

set size 1.1,1.05 
set origin 0.0,0.0

set xlabel "time (ms)"
set ylabel "I (nA)"
#set title "{/Symbol g}=176.0 pS, n=60"

plot \
	"cont.dat" using 1:2 title "" linestyle 1,\
	"with.dat" using 1:2 title "" linestyle 3,\
	"without.dat" using 1:2 title "" linestyle 2

quit
EOM
#test -f PL.$$ && rm PL.$$ 
if test "$DISPLAY" != ""
then i=`ps -U $USER | grep gv | egrep -v grep | awk '{print $1}' -`
 if test "$i" != ""
 then kill -1 $i
 else gv -scale=1 APclamp_time.eps &
 fi
fi
