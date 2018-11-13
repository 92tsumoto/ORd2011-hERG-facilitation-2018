#!/bin/sh
# PL-gnu.sh
m=1024

cat m100mV.out | awk '{if(NR==4506) print}' | awk '{print -100,$7/1.04766}' > iv.dat
cat m90mV.out | awk '{if(NR==4506) print}' | awk '{print -90,$7/1.04766}' >> iv.dat
cat m80mV.out | awk '{if(NR==4506) print}' | awk '{print -80,$7/1.04766}' >> iv.dat
cat m70mV.out | awk '{if(NR==4506) print}' | awk '{print -70,$7/1.04766}' >> iv.dat
cat m60mV.out | awk '{if(NR==4506) print}' | awk '{print -60,$7/1.04766}' >> iv.dat
cat m50mV.out | awk '{if(NR==4506) print}' | awk '{print -50,$7/1.04766}' >> iv.dat
cat m40mV.out | awk '{if(NR==4506) print}' | awk '{print -40,$7/1.04766}' >> iv.dat
cat m30mV.out | awk '{if(NR==4506) print}' | awk '{print -30,$7/1.04766}' >> iv.dat
cat m20mV.out | awk '{if(NR==4506) print}' | awk '{print -20,$7/1.04766}' >> iv.dat
cat m10mV.out | awk '{if(NR==4506) print}' | awk '{print -10,$7/1.04766}' >> iv.dat
cat 0mV.out | awk '{if(NR==4506) print}' | awk '{print 0,$7/1.04766}' >> iv.dat
cat 10mV.out | awk '{if(NR==4506) print}' | awk '{print 10,$7/1.04766}' >> iv.dat
cat 20mV.out | awk '{if(NR==4506) print}' | awk '{print 20,$7/1.04766}' >> iv.dat
cat 30mV.out | awk '{if(NR==4506) print}' | awk '{print 30,$7/1.04766}' >> iv.dat
cat 40mV.out | awk '{if(NR==4506) print}' | awk '{print 40,$7/1.04766}' >> iv.dat
cat 50mV.out | awk '{if(NR==4506) print}' | awk '{print 50,$7/1.04766}' >> iv.dat
cat 60mV.out | awk '{if(NR==4506) print}' | awk '{print 60,$7/1.04766}' >> iv.dat

gnuplot << EOM
#set term postscript eps color "Arial" 25
set term postscript eps enhanced "Times" 25 color
set output "I-V_tail.eps"

set key left top

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
set style line 4 lt 1 linecolor 5 lw 4
set style line 5 lt 1 linecolor 4 lw 4
set style line 6 lt 2 linecolor 1 lw 4
set style line 7 lt 2 linecolor 3 lw 4
set style line 8 lt 7 lw 3
set style line 9 pt 8 ps 3

set xrange [-80:60]
set yrange [-0.05:1.05]
set tics out scale 2
set xtics -100,20
set mxtics 1
set ytics 0,0.5
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

f(x)=1.0/(1.0+exp(-(x+10.75)/7.415))
g(x)=1.0/(1.0+exp(-(x+8.337)/6.786))

plot \
	f(x) title "Exp based xss" linestyle 6,\
	g(x) title "ORd_{xrss}" linestyle 3,\
	"iv.dat" with point pt 7 ps 2.5 notitle,\
	"../../../HEK_experiments/hekdata_170607_tail" using 1:2:3 notitle with yerrorbars

quit
EOM
#test -f PL.$$ && rm PL.$$ 
if test "$DISPLAY" != ""
then i=`ps -U $USER | grep gv | egrep -v grep | awk '{print $1}' -`
 if test "$i" != ""
 then kill -1 $i
 else gv -scale=1 I-V_tail.eps &
 fi
fi
