//#ifndef __SYSPARA_H_INCLUDE 
//#define __SYSPARA_H_INCLUDE

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <limits.h>
#include "mkl.h"
#include "/home/tsumoto/lib/xhplot.h"

#define NN 4
#define BUF 100
#define NUM 60

//#define R 8314.472		// J/mmol/K
//#define F 96485.33771638995	// C/mol
//#define T 310.0		// K
#define R 8314.0	// J/mol/K
#define F 96485.0	// C/mmol
#define T 298.0		// K (25 degree)
//#define T 310.0		// K (37 degree)

#define VNMAX 400*5+1
#define dvm 5

struct varstruct {

    int datas;
    int line_wid[NUM];
	
	int n;
    double vm,vm_base,vm_start;

	// An invariant constant
	double RTonF,RTon2F;

	// Cell tupe
	int celltype;

	// channel number
	int cnumber;

	// Ion Valences 
	double zna,zk,zca;

	// Intracellular/Extracellular ion concentrations
	double ki,ko;

	// Q10
	double Q10,Tf;	
	// Reversal potential
	//double Ena,Ek,Eks,Eca;
			
	// Extracellular ion concentrations
	//double nao,ko,cao,ki;

	// Currnt
	double Erev;

	// IKr conductance modulation
	double gkr_rate;

	// test variable
	double dt,dvdt[NN];
	// Sttimulus parameters
	double BCL;  // Base cycle length = stimulus period
	int beat; // Number of stimulus

    int m;
    int l;

    double x0[NUM][NN];
    double tsign[NUM];
    double tend[NUM];
	double pulse_end_time;

    int pflag;
    int write, graph;
    int write0;
    int half;
	int vs;

} var;

// Fast and Late sodium currnets
struct inastruct {

	double Gna_fast,fast;
	double *Tmss,*Ttaum,*Thss,*Ttauh,*Tjss,*Ttauj;
	double mss,taum,hss,tauh,jss,tauj;

} ina;

// Rapid activating potassium current (Ikr)
struct ikrstruct {

	double ik,Gkr,rategkr,rate;
	double xr,xrss,tauxr_fast,tauxr_slow,Axr_fast,Axr_slow,rkr;
	double *Txrss,*Ttauxr_fast,*Ttauxr_slow,*TAxr_fast;
	double *Trkr;
	double xiss,tauxi,tauxi_dep,tauxi_rep;

} ikr;
