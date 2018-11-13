#include "syspara.h"

void data_out(FILE *fp2, double t, double u[])
{

	fprintf(fp2,"%e %e %e %e %e %e %e %e %e %e %e %e %e\n",t,var.vm,ikr.ik,ikr.without,ikr.with,u[0],u[1],u[2],u[3],ikr.xr,ikr.rkr,ikr.xr2,ikr.rkr2);

}

