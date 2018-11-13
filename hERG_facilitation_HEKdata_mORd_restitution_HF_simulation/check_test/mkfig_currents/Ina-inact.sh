#!/bin/sh
# PL-gnu.sh

#cat ../control/s2_860/data.out | awk '{print $1-2000,$3}' > cont0.dat
#cat ../without_0.52175/s2_860/data.out | awk '{print $1-2000,$3}' > cont1.dat
#cat ../with_0.43334/s2_860/data.out | awk '{print $1-2000,$3}' > cont2.dat

cat ../control/s2_860/data.out | awk '{print $1-2000,((1.0-(1.0/(1.0 + 0.15/(0.05*(1.0-$33)/(1.0+0.0015/$41)+$33))))*(0.99*$5+0.01*$6)*$7+(1.0/(1.0 + 0.15/(0.05*(1.0-$33)/(1.0+0.0015/$41)+$33)))*(0.99*$5+0.01*$8)*$9)}' > cont.dat
cat ../without_0.52175/s2_860/data.out | awk '{print $1-2000,((1.0-(1.0/(1.0 + 0.15/(0.05*(1.0-$33)/(1.0+0.0015/$41)+$33))))*(0.99*$5+0.01*$6)*$7+(1.0/(1.0 + 0.15/(0.05*(1.0-$33)/(1.0+0.0015/$41)+$33)))*(0.99*$5+0.01*$8)*$9)}' > without.dat
cat ../with_0.43334/s2_860/data.out | awk '{print $1-2000,((1.0-(1.0/(1.0 + 0.15/(0.05*(1.0-$33)/(1.0+0.0015/$41)+$33))))*(0.99*$5+0.01*$6)*$7+(1.0/(1.0 + 0.15/(0.05*(1.0-$33)/(1.0+0.0015/$41)+$33)))*(0.99*$5+0.01*$8)*$9)}' > with.dat

#cat s2_267/data.out | awk '{print $1-1000,$4*$4*$4}' > c267-2.dat
#cat s2_266/data.out | awk '{print $1-1000,$4*$4*$4}' > c266-2.dat
#cat s2_265/data.out | awk '{print $1-1000,$4*$4*$4}' > c265-2.dat


gnuplot << EOM
#set term postscript eps color "Arial" 25
set term postscript eps enhanced "Arial" 25 color
set output "inaf_h.eps"

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
set style line 6 lt 2 linecolor 2 lw 2
set style line 7 lt 2 linecolor 7 lw 2
set style line 8 lt 7 lw 3
set style line 9 pt 8 ps 3

set xrange [-50:1550]
set yrange [-0.05:1.05]
set tics out scale 2.5
set xtics 0,500
set mxtics 1
set ytics 0,0.5
#set mytics 2

set border 3
set xtics nomirror
set ytics nomirror

#set size 1.2,1.1 
set size 0.9,1.0 
set origin 0.0,0.0

set xlabel "Time (s)"
set ylabel "INaf,I (a.u.)"

plot \
	"with.dat" using 1:2 title "" linestyle 3,\
	"without.dat" using 1:2 title "" linestyle 2,\
	"cont.dat" using 1:2 title "" linestyle 1

quit
EOM
#test -f PL.$$ && rm PL.$$ 
if test "$DISPLAY" != ""
then i=`ps -U $USER | grep gv | egrep -v grep | awk '{print $1}' -`
 if test "$i" != ""
 then kill -1 $i
 else gv -scale=1 inaf_h.eps &
 fi
fi
