
#include "syspara.h"

void val_consts(FILE *fp1)
{
	int i,w;
	double v_old,dvdt,dvdt_new;

	// Cell Geometry */

	// Q10
		var.Q10 = 3.0;

	// Ion Valences
		var.zna = 1.0;  // Na valence
		var.zk = 1.0;   // K valence
		var.zca = 2.0;  // Ca valence

	// invariant constant
		var.RTonF = R*T/F;
		var.RTon2F = R*T/(var.zca*F);

	// Intracellular/Extracellular Concentrations
		//var.nao = 140.0;     // Initial Bulk Medium Na (mM)
		//var.ki = 140.0;     // Intracellular K concentration (mM)
		//var.ko = 5.4;       // Extracellular K concentration (mM)
		//var.cao = 1.8;     // Initial Bulk Medium Ca (mM)

		var.Erev = var.RTonF*log(var.ko/var.ki); // x[17] = [K]i, x[22] = [K]o
		printf("reversal = %lf\n",var.Erev);

		ikr.rategkr = sqrt(var.ko/5.4);

		if(var.celltype == 0){ // Endo
			ikr.Gkr = 0.046*var.gkr_rate;
		} else if(var.celltype == 1){ // Mid
			ikr.Gkr = 0.8*0.046*var.gkr_rate;
		} else if(var.celltype == 2){ // Epi
		 	ikr.Gkr = 1.3*0.046*var.gkr_rate;
		}

	// Temperture
		//var.Tf = pow(3,((T-273)-25.0)/100);
		var.Tf = pow(3,((T-273)-25.0)/10.0);
		printf("temperture factor = %lf\n",var.Tf);

	// Drug
		//var.drug_conc = 100; // (nM)
		//var.drug_conc = 0; // (nM)
		var.ic50 = 145.0; // (nM)
		var.ec50 = 92.8; // (nM)
		var.hill = 1.15;
		var.ehill = 1.50;

}

