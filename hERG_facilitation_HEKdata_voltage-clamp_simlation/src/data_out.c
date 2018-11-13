#include "syspara.h"

void data_out(FILE *fp2, double t, double u[])
{

	fprintf(fp2,"%e %e %e %e %e %e %e %e %e\n",t,var.vm,u[0],u[1],ikr.xr,ikr.rkr,ikr.ik,u[2],u[3]);

}

