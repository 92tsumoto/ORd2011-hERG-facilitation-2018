#include "syspara.h"

void function(double x[],double f[],double t)
{

	int i;
	double fact,fdeact;
	double sact,sdeact;
	double conductance;
	double activation, inactivation;
	double fin,sin,dep,rep;
	
	// ORd original
	//ikr.xrss = 1.0/(1.0+exp(-(var.vm+8.337)/6.789));
	//ikr.tauxr_fast = 12.98 + 1.0/(0.3652*exp((var.vm-31.66)/3.869) + 4.123E-5*exp(-(var.vm-47.78)/20.38));
	//ikr.tauxr_slow = 1.865 + 1.0/(0.06629*exp((var.vm-34.70)/7.355) + 1.128E-5*exp(-(var.vm-29.74)/25.94));
	//ikr.Axr_fast = 1.0/(1.0+exp((var.vm+54.81)/38.21));
	//ikr.Axr_slow = 1.0 - ikr.Axr_fast;

	// Experimental data based activation curve
	ikr.xrss = 1.0/(1.0+exp(-(var.vm+10.75)/7.4));

	// experimental data based time constant function
	fact = 1400.0/(1.0+exp((var.vm+10.0)/13.8)); 
	fdeact = 1300.0/(1.0+exp(-(var.vm+55.0)/12.3));
	ikr.tauxr_fast = (fact+fdeact)-1300.0;

	// 2017.9.7
	//fact = 1000.0/(1.0+exp((var.vm+4.5)/13.0))+400.0/(1.0+exp((var.vm+3.0)/2.5)); 
	//fdeact = 1400.0/(1.0+exp(-(var.vm+53.0)/9.3));
	//ikr.tauxr_fast = (fact+fdeact)-1400.0;

	// 2017.9.22
	//fact = 1600.0/(1.0+exp((var.vm+6.5)/5.8))+400/(1+exp((var.vm-10)/15)); 
	//fdeact = 2000.0/(1.0+exp(-(var.vm+45.0)/15.3));
	//ikr.tauxr_fast = (fact+fdeact)-2000.0;

	// 2017.9.22 (ver.2)
	//fact = 1400.0/(1.0+exp((var.vm+3.5)/6.8))+200/(1+exp((var.vm-15)/15));
	//fdeact = 1600.0/(1.0+exp(-(var.vm+50.0)/15.3));
	//ikr.tauxr_fast = (fact+fdeact)-1600.0;

	// det (2017.8.3)
	//sact = 5000.0/(1.0+exp((var.vm+24.3)/11.0));
	//sdeact = 5000.0/(1.0+exp(-(var.vm+57.5)/8.0));
	// det (2017.9.7)
	sact = 5000.0/(1.0+exp((var.vm+22.8)/11.5))+2000/(1.0+exp((var.vm+25)/2.5));
	sdeact = 4000.0/(1.0+exp(-(var.vm+61.5)/5.))+3000/(1.0+exp(-(var.vm+54)/2.5));
	if(var.vm>-80){
		ikr.tauxr_slow = (sact+sdeact)-7000;
		//ikr.tauxr_slow = (sact+sdeact)-5000;
	} else {
		ikr.tauxr_slow = 2000+8000/(1+exp(-(var.vm+74.9)/10.2));
	}

	// defult (2017.8.1)
	//ikr.Axr_fast = 1.0/(1.0+exp((var.vm+45.8)/6.6));
	//ikr.Axr_fast = 0.8/(1.0+exp((var.vm+53.8)/6.6));
	//ikr.Axr_fast = 0.01;
	// estimate (2017.9.8)
	//ikr.Axr_fast = 0.06+0.94/(1.0+exp((var.vm+73.8)/15.6));
	// estimate (2017.9.8)
	//ikr.Axr_fast = 1.0/(1.0+exp((var.vm+70.8)/15.6));
	ikr.Axr_fast = 0.05+0.95/(1.0+exp((var.vm+73.4)/16.0));
	ikr.Axr_slow = 1.0 - ikr.Axr_fast;

	if(var.vm==-20.0){ikr.Axr_fast=0.;ikr.Axr_slow=1.0;}

	ikr.xr = ikr.Axr_fast*x[0] + ikr.Axr_slow*x[1];
	activation = ikr.xr;

	// Rkr: inactivation ORd original
	//	ikr.rkr = 1.0/(1.0+exp((var.vm+55.0)/75.0))*1.0/(1.0+exp((var.vm-10.0)/30.0));
	//候補１
	//ikr.rkr = 0.04+0.796/(1+exp((var.vm+19.8)/5.5))+0.165/(1+exp((var.vm-8.5)/16.0));
	//ikr.rkr = 0.04+0.796/(1.0+exp((var.vm+19.6)/5.0))+0.164/(1.0+exp((var.vm-10.5)/14.0));
	//ikr.rkr = 0.05+0.79/(1.0+exp((var.vm+19.6)/5.0))+0.16/(1.0+exp((var.vm-6.0)/12.0));
	//2017.9.22
	ikr.rkr = 0.04+0.79/(1.0+exp((var.vm+20.5)/5.4))+0.17/(1.0+exp((var.vm-7.0)/13.5));
		//ikr.rkr = 0.04+0.79/(1.0+exp((var.vm+0.5)/5.4))+0.17/(1.0+exp((var.vm-27.0)/13.5));
		//ikr.rkr = 0.8+0.2/(1.0+exp((var.vm+0.5)/5.4));
		//ikr.rkr = 1.0/(1.0+exp((var.vm-100)/20));
	// assuming inactivation variables
	//ikr.xiss = 0.12+0.88/(1.0+exp((var.vm+70.3)/27.0));
	ikr.xiss = 0.12+0.88/(1.0+exp((var.vm+60.3)/27.0));
	//ikr.xiss = 0.2+0.8/(1.0+exp((var.vm+40.0)/27.0));
	//ikr.tauxi_rep = 0.26*(0.58*exp((var.vm+130.0)/50.0)*3/(1.0+exp((var.vm-5.0)/25.0)));
	ikr.tauxi_rep = 0.24*(0.58*exp((var.vm+80.0)/40.0)*3/(1.0+exp((var.vm-10.0)/18.0)));
	ikr.tauxi_dep = ikr.tauxi_rep;

	//inactivation = x[2];
	//inactivation = 1.0;
	
	//using inactivation data
	if(var.vs==1){
		//inactivation = x[2];
		//inactivation = ikr.rkr;
		//inactivation = ikr.xiss;
		//inactivation = pow(ikr.xiss,1.5);
		dep=1.0;rep=0.0;
	} else if(var.vs==2){
		//inactivation = pow(ikr.xiss,1.5);
		//inactivation = ikr.xiss;
		//inactivation = ikr.rkr;
		//inactivation = 1.0;
		dep=0.0;rep=1.0;
	} else {
		inactivation = ikr.xiss;
	}

	conductance=ikr.Gkr*ikr.rategkr;
	//inactivation=(dep*ikr.rkr+rep*ikr.xiss);
	//inactivation=x[3]*(1.0/(1.0+exp((var.vm-30)/27)));
	//inactivation=x[3]*(0.32+0.68/(1.0+exp((var.vm-7)/20)));
	inactivation=ikr.xiss*(0.32+0.68/(1.0+exp((var.vm-7)/20)));

	ikr.ik = conductance*activation*inactivation*(var.vm-var.Erev);
	//ikr.ik = conductance*activation*inactivation*ikr.rkr*(var.vm-var.Erev);
	
	//printf("Gkr=%lf ikr=%lf\n",ikr.Gkr,ikr.ik);

	f[0] = var.Tf*((ikr.xrss - x[0])/ikr.tauxr_fast);
	f[1] = var.Tf*((ikr.xrss - x[1])/ikr.tauxr_slow);
	f[2] = var.Tf*((ikr.rkr  - x[2])/ikr.tauxi_dep);
	f[3] = var.Tf*((ikr.xiss - x[3])/ikr.tauxi_rep);

}
