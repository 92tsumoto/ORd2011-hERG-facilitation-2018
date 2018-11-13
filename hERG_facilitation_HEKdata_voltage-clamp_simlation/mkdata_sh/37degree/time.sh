#!/bin/sh
# PL-gnu.sh
m=1024

cat m100mV.out | awk '{print $1/1000,$7*1000}' > m100.dat
cat m90mV.out | awk '{print $1/1000,$7*1000}' > m90.dat
cat m80mV.out | awk '{print $1/1000,$7*1000}' > m80.dat
cat m70mV.out | awk '{print $1/1000,$7*1000}' > m70.dat
cat m60mV.out | awk '{print $1/1000,$7*1000}' > m60.dat
cat m50mV.out | awk '{print $1/1000,$7*1000}' > m50.dat
cat m40mV.out | awk '{print $1/1000,$7*1000}' > m40.dat
cat m30mV.out | awk '{print $1/1000,$7*1000}' > m30.dat
cat m20mV.out | awk '{print $1/1000,$7*1000}' > m20.dat
cat m10mV.out | awk '{print $1/1000,$7*1000}' > m10.dat
cat 0mV.out | awk '{print $1/1000,$7*1000}' > 0.dat
cat 10mV.out | awk '{print $1/1000,$7*1000}' > 10.dat
cat 20mV.out | awk '{print $1/1000,$7*1000}' > 20.dat
cat 30mV.out | awk '{print $1/1000,$7*1000}' > 30.dat
cat 40mV.out | awk '{print $1/1000,$7*1000}' > 40.dat
cat 50mV.out | awk '{print $1/1000,$7*1000}' > 50.dat
cat 60mV.out | awk '{print $1/1000,$7*1000}' > 60.dat

gnuplot << EOM
#set term postscript eps color "Arial" 25
set term postscript eps enhanced "Times" 25 color
set output "time.eps"

set key right top

set lmargin 10
set bmargin 5
set rmargin 10
set tmargin 5

#set size square

#set title "Ikr"

set style data lines
set style line 1 lt 2 linecolor 7 lw 4
set style line 2 lt 2 linecolor 1 lw 4
set style line 3 lt 2 linecolor 2 lw 4
set style line 4 lt 2 linecolor 3 lw 4
set style line 5 lt 2 linecolor 5 lw 4
set style line 6 lt 2 linecolor 4 lw 4
set style line 7 lt 2 linecolor 7 lw 4
set style line 8 lt 7 lw 3
set style line 9 pt 8 ps 3

set xrange [0:7.5]
set yrange [-100:1000]
set tics out scale 3
set xtics 0,3
set mxtics 1
set ytics 0,500
set mytics 1

#set yzeroaxis 
#set xzeroaxis 

set border 3
set xtics nomirror
set ytics nomirror

set size 1.4,1.6 
set origin 0.0,0.0

set xlabel "time (ms)"
set ylabel "I "
#set title "{/Symbol g}=176.0 pS, n=60"

plot \
	"m80.dat" using 1:2 title "" linestyle 2,\
	"m70.dat" using 1:2 title "" linestyle 3,\
	"m60.dat" using 1:2 title "" linestyle 4,\
	"m50.dat" using 1:2 title "" linestyle 5,\
	"m40.dat" using 1:2 title "" linestyle 3,\
	"m30.dat" using 1:2 title "" linestyle 1,\
	"m20.dat" using 1:2 title "-20mv" linestyle 4,\
	"m10.dat" using 1:2 title "-10mv" linestyle 1,\
	"0.dat" using 1:2 title "0mv" linestyle 1,\
	"10.dat" using 1:2 title "10mv" linestyle 2,\
	"20.dat" using 1:2 title "20mv" linestyle 6,\
	"30.dat" using 1:2 title "" linestyle 5,\
	"40.dat" using 1:2 title "" linestyle 4,\
	"50.dat" using 1:2 title "" linestyle 3,\
	"60.dat" using 1:2 title "" linestyle 2

quit
EOM
#test -f PL.$$ && rm PL.$$ 
if test "$DISPLAY" != ""
then i=`ps -U $USER | grep gv | egrep -v grep | awk '{print $1}' -`
 if test "$i" != ""
 then kill -1 $i
 else gv -scale=1 time.eps &
 fi
fi

