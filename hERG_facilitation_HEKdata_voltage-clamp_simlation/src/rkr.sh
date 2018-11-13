#!/bin/sh
# PL-gnu.sh
m=1024

gnuplot << EOM
#set term postscript eps color "Arial" 25
set term postscript eps enhanced "Times" 25 color
set output "Rkr.eps"

set key right top

set lmargin 10
set bmargin 5
set rmargin 10
set tmargin 5

#set size square

#set title "Ikr"

set style data lines
set style line 1 lt 2 linecolor 3 lw 4
set style line 2 lt 2 linecolor 5 lw 4
set style line 3 lt 2 linecolor 7 lw 4
set style line 4 lt 2 linecolor 5 lw 4
set style line 5 lt 2 linecolor 4 lw 4
set style line 6 lt 2 linecolor 1 lw 4
set style line 7 lt 2 linecolor 3 lw 4
set style line 8 lt 7 lw 3
set style line 9 pt 8 ps 3

set xrange [-100:60]
set yrange [-0.05:1.05]
set tics out scale 2
set xtics -100,20
set mxtics 1
#set ytics 0,0.2
set mytics 1

set yzeroaxis 
set xzeroaxis 

set border 3
set xtics nomirror
set ytics nomirror

set size 1.2,1.5 
set origin 0.0,0.0

set xlabel "V (mV)"
set ylabel "Normalized current I"

f(x)=1.0/(1.0+exp((x+55.0)/75.0))*1.0/(1.0+exp((x-10.0)/30.0))
g(x)=0.04+0.796/(1+exp((x+19.8)/5.5))+0.164/(1+exp((x-8.5)/13.0))

plot \
	f(x) title "ORd R_{Kr}" linestyle 3,\
	g(x) title "HEK R_{Kr}" linestyle 6

quit
EOM
#test -f PL.$$ && rm PL.$$ 
if test "$DISPLAY" != ""
then i=`ps -U $USER | grep gv | egrep -v grep | awk '{print $1}' -`
 if test "$i" != ""
 then kill -1 $i
 else gv -scale=1 Rkr.eps &
 fi
fi
