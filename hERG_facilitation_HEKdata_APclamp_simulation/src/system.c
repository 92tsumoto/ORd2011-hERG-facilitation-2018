#include "syspara.h"

void function(double x[],double f[],double t)
{

	int i;
	double fact,fdeact;
	double sact,sdeact;
	double fact2,fdeact2;
	double sact2,sdeact2;
	
	// Experimental data based activation curve
	if(var.mode==1){	// experimental based modified ORd 
		ikr.xrss = 1.0/(1.0+exp(-(var.vm+10.75)/7.4));

		// experimental data based time constant function
		fact = 1400.0/(1.0+exp((var.vm+10.0)/13.8)); 
		fdeact = 1300.0/(1.0+exp(-(var.vm+55.0)/12.3));
		ikr.tauxr_fast = (fact+fdeact)-1300.0;

		sact = 5000.0/(1.0+exp((var.vm+22.8)/11.5))+2000/(1.0+exp((var.vm+25)/2.5));
		sdeact = 4000.0/(1.0+exp(-(var.vm+61.5)/5.))+3000/(1.0+exp(-(var.vm+54)/2.5));
		if(var.vm>-80){
			ikr.tauxr_slow = (sact+sdeact)-7000;
		} else {
			ikr.tauxr_slow = 2000+8000/(1+exp(-(var.vm+74.9)/10.2));
		}

		ikr.Axr_fast = 0.05+0.95/(1.0+exp((var.vm+73.4)/16.0));
		ikr.Axr_slow = 1.0 - ikr.Axr_fast;
		ikr.xr = ikr.Axr_fast*x[0] + ikr.Axr_slow*x[1];

		ikr.rkr = (0.12+0.88/(1.0+exp((var.vm+60.3)/27.0)))*(0.32+0.68/(1.0+exp((var.vm-7)/20)));
	} else if(var.mode==0){ // original ORd
		ikr.xrss = 1.0/(1.0+exp(-(var.vm+8.337)/6.789));
		ikr.tauxr_fast = 12.98 + 1.0/(0.3652*exp((var.vm-31.66)/3.869) + 4.123E-5*exp(-(var.vm-47.78)/20.38));
		ikr.tauxr_slow = 1.865 + 1.0/(0.06629*exp((var.vm-34.70)/7.355) + 1.128E-5*exp(-(var.vm-29.74)/25.94));
		ikr.Axr_fast = 1.0/(1.0+exp((var.vm+54.81)/38.21));
		ikr.Axr_slow = 1.0 - ikr.Axr_fast;
		ikr.xr = ikr.Axr_fast*x[0] + ikr.Axr_slow*x[1];
		
		ikr.rkr = 1.0/(1.0+exp((var.vm+55.0)/75.0))*1.0/(1.0+exp((var.vm-10.0)/30.0));
	}

// facilitation component
	if(var.mode == 1){
		// Experimental data based activation curve
		ikr.xrss2 = 1.0/(1.0+exp(-(var.vm+37.2)/7.7));

		fact2 = 1400.0/(1.0+exp((var.vm+10.0)/13.8)); 
		fdeact2 = 1300.0/(1.0+exp(-(var.vm+55.0)/12.3));
		ikr.tauxr_fast2 = (fact2+fdeact2)-1300.0;

		sact2 = 5000.0/(1.0+exp((var.vm+22.8)/11.5))+2000/(1.0+exp((var.vm+25)/2.5));
		sdeact2 = 4000.0/(1.0+exp(-(var.vm+61.5)/5.))+3000/(1.0+exp(-(var.vm+54)/2.5));
		if(var.vm>-80){
			ikr.tauxr_slow2 = (sact+sdeact)-7000;
		} else {
			ikr.tauxr_slow2 = 2000+8000/(1+exp(-(var.vm+74.9)/10.2));
		}

		ikr.Axr_fast2 = 0.05+0.95/(1.0+exp((var.vm+73.4)/16.0));
		ikr.Axr_slow2 = 1.0 - ikr.Axr_fast2;
		ikr.xr2 = ikr.Axr_fast2*x[2] + ikr.Axr_slow2*x[3];

		ikr.rkr2 = (0.12+0.88/(1.0+exp((var.vm+60.3)/27.0)))*(0.32+0.68/(1.0+exp((var.vm-7)/20)));

	} else if(var.mode == 0) { // original ORd model
		ikr.xrss2 = 1.0/(1.0+exp(-(var.vm+34.787)/6.789));
		ikr.tauxr_fast2 = 12.98 + 1.0/(0.3652*exp((var.vm-31.66)/3.869) + 4.123E-5*exp(-(var.vm-47.78)/20.38));
		ikr.tauxr_slow2 = 1.865 + 1.0/(0.06629*exp((var.vm-34.70)/7.355) + 1.128E-5*exp(-(var.vm-29.74)/25.94));
		ikr.Axr_fast2 = 1.0/(1.0+exp((var.vm+54.81)/38.21));
		ikr.Axr_slow2 = 1.0 - ikr.Axr_fast;
		ikr.xr2 = ikr.Axr_fast2*x[0] + ikr.Axr_slow2*x[1];
		
		ikr.rkr2 = 1.0/(1.0+exp((var.vm+55.0)/75.0))*1.0/(1.0+exp((var.vm-10.0)/30.0));
	}


// Drug effects
	// unaffected fraction (without facilitation)
	var.normal_block = 1/(1+pow((var.drug_conc/var.ic50),var.hill));

	// affected fraction (with facilitation)
	var.fraction_facil = 1/(1+pow((var.drug_conc/var.ec50),var.ehill));


	if(var.drug_type == 0){
	// IKr current without facilitation
	ikr.without = var.normal_block*ikr.Gkr*ikr.rategkr*ikr.xr*ikr.rkr*(var.vm-var.Erev);
	ikr.with = 0.0;
	} else if(var.drug_type == 1){
	// IKr current with facilitation
	ikr.without = var.normal_block*var.fraction_facil*ikr.Gkr*ikr.rategkr*ikr.xr*ikr.rkr*(var.vm-var.Erev);
	ikr.with = var.normal_block*(1.0-var.fraction_facil)*ikr.Gkr*ikr.rategkr*ikr.xr2*ikr.rkr2*(var.vm-var.Erev);
	}

	ikr.ik = ikr.with+ikr.without;

	printf("%lf %lf\n",var.vm,ikr.ik);

	f[0] = var.Tf*((ikr.xrss - x[0])/ikr.tauxr_fast);
	f[1] = var.Tf*((ikr.xrss - x[1])/ikr.tauxr_slow);
	f[2] = var.Tf*((ikr.xrss2 - x[2])/ikr.tauxr_fast2);
	f[3] = var.Tf*((ikr.xrss2 - x[3])/ikr.tauxr_slow2);

}
