#!/bin/sh
# PL-gnu.sh
m=1024

cat m100mV.out | awk '{print $1/1000,$7*1000}' > m100.dat
cat m90mV.out | awk '{print $1/1000,$7*1000}' > m90.dat
cat m80mV.out | awk '{print $1/1000,$7*1000}' > m80.dat
cat m70mV.out | awk '{print $1/1000,$7*1000}' > m70.dat
cat m60mV.out | awk '{print $1/1000,$7*1000}' > m60.dat
cat m50mV.out | awk '{print $1/1000,$7*1000}' > m50.dat
cat m40mV.out | awk '{print $1/1000,$7*1000*4.5}' > m40.dat
cat m30mV.out | awk '{print $1/1000,$7*1000*4.2}' > m30.dat
cat m20mV.out | awk '{print $1/1000,$7*1000*3.1}' > m20.dat
cat m10mV.out | awk '{print $1/1000,$7*1000*1.85}' > m10.dat
cat 0mV.out | awk '{print $1/1000,$7*1000*1.38}' > 0.dat
cat 10mV.out | awk '{print $1/1000,$7*1000*1.25}' > 10.dat
cat 20mV.out | awk '{print $1/1000,$7*1000}' > 20.dat
cat 30mV.out | awk '{print $1/1000,$7*1000}' > 30.dat
cat 40mV.out | awk '{print $1/1000,$7*1000}' > 40.dat
cat 50mV.out | awk '{print $1/1000,$7*1000}' > 50.dat
cat 60mV.out | awk '{print $1/1000,$7*1000}' > 60.dat

gnuplot << EOM
#set term postscript eps color "Arial" 25
set term postscript eps enhanced "Times" 25 color
set output "exp_time.eps"

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
set style line 3 lt 2 linecolor 3 lw 4
set style line 4 lt 2 linecolor 5 lw 4
set style line 5 lt 2 linecolor 4 lw 4
set style line 6 lt 2 linecolor 1 lw 4
set style line 7 lt 2 linecolor 3 lw 4
set style line 8 lt 7 lw 3
set style line 9 pt 8 ps 3

set xrange [0:7.5]
set yrange [-100:1000]
set tics out scale 3
set xtics 0,3
set mxtics 1
set ytics 0,200
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
	"../../HEK_experiments/sample_cell3/m80mv.dat" using 1:2 title "" linestyle 2,\
	"../../HEK_experiments/sample_cell3/m70mv.dat" using 1:2 title "" linestyle 3,\
	"../../HEK_experiments/sample_cell3/m60mv.dat" using 1:2 title "" linestyle 4,\
	"../../HEK_experiments/sample_cell3/m50mv.dat" using 1:2 title "" linestyle 5,\
	"../../HEK_experiments/sample_cell3/m40mv.dat" using 1:2 title "" linestyle 1,\
	"../../HEK_experiments/sample_cell3/m30mv.dat" using 1:2 title "" linestyle 2,\
	"../../HEK_experiments/sample_cell3/m20mv.dat" using 1:2 title "" linestyle 3,\
	"../../HEK_experiments/sample_cell3/m10mv.dat" using 1:2 title "" linestyle 4,\
	"../../HEK_experiments/sample_cell3/0mv.dat" using 1:2 title "" linestyle 5,\
	"../../HEK_experiments/sample_cell3/10mv.dat" using 1:2 title "" linestyle 1,\
	"../../HEK_experiments/sample_cell3/20mv.dat" using 1:2 title "" linestyle 2,\
	"../../HEK_experiments/sample_cell3/30mv.dat" using 1:2 title "" linestyle 3,\
	"../../HEK_experiments/sample_cell3/40mv.dat" using 1:2 title "" linestyle 4,\
	"../../HEK_experiments/sample_cell3/50mv.dat" using 1:2 title "" linestyle 5,\
	"../../HEK_experiments/sample_cell3/60mv.dat" using 1:2 title "" linestyle 1

quit
EOM
#test -f PL.$$ && rm PL.$$ 
if test "$DISPLAY" != ""
then i=`ps -U $USER | grep gv | egrep -v grep | awk '{print $1}' -`
 if test "$i" != ""
 then kill -1 $i
 else gv -scale=1 exp_time.eps &
 fi
fi
