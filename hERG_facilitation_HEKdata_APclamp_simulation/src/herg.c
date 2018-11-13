/* produced by Tsumoto. K 2008.10.27 */

#include <string.h>
#include <stdlib.h>
#include "syspara.h"

FILE *fopen(), *fpin, *fpin2, *fp0, *fp1, *fp2, *fp3;
FILE *fp4, *fp5, *fp6, *fp7, *fp8, *fp9;
int mode = 1;
int P = 2;
int beats = 1;

typedef double Number;

main(argc,argv)
int argc;
char **argv;
{
	int i,w;
	int ii=0;
	double x[NN];
	double t = 0.0,tt=0.0;
	double time=0.0;
	double h;
	double v_old[NN],dvdt[NN],dvdt_new[NN];
	double t_stok;
	char *tmpname,*tmppname;
	char cmd[BUFSIZ];
	double tend;

/* Action Potential Duration and Max. Info */

//int i; // Stimulation Counter

	tmpname = "temp";

	sprintf(cmd, "/usr/bin/cpp -P %s > %s", argv[1],tmpname);
	if(system(cmd) == -1){
		fprintf(stderr,"cannot open %s\n",argv[1]);
		exit(1);
	}
	if((fpin=fopen(tmpname,"r"))==NULL){
		fprintf(stderr,"cannot open %s\n",argv[1]);
		exit(1);
	}
	
	tmppname = "tempp";

	sprintf(cmd, "/usr/bin/cpp -P %s > %s", argv[2],tmppname);
	if(system(cmd) == -1){
		fprintf(stderr,"cannot open %s\n",argv[2]);
		exit(1);
	}
	if((fpin2=fopen(tmppname,"r"))==NULL){
		fprintf(stderr,"cannot open %s\n",argv[2]);
		exit(1);
	}

	if ((fp1 = fopen("para.out","w")) == NULL){
		printf("Can't open File\n");
		exit(1);
	}
	if ((fp2 = fopen("data.out","w")) == NULL){
		printf("Can't open File\n");
		exit(1);
	}
	if ((fp3 = fopen("ndata.out","w")) == NULL){
		printf("Can't open File\n");
		exit(1);
	}

	// parameter inputs
		input_para(fpin);

	if (var.write){
		if ((fp0 = fopen(argv[3],"w"))==NULL){
			fprintf(stderr, "%s cannot open.\n",argv[3]);
			exit(-1);
		}
	}

	xhplot(WINDOW, 700.0, 700.0, WHITE);
	xhplot(DIRECT, 0.0, 0.0, WHITE);

	for (ii = 0; ii < var.datas; ii++){
		long j;
		time = 0.0;
		tend = var.tend[ii];
		for (i = 0; i < NN; i++){ 
			x[i] = var.x0[ii][i];
		}

		xddp.line_wid = var.line_wid[ii];
		xhplot(LINEATT,0,0,WHITE);
		
		// initial values input.
		val_consts(fp1);
		printf("exit consts\n");
				
	// initial values input.
		initial_mem();
		printf("exit memory initialization\n");

		for(i=0;i<10400;i++){
			fscanf(fpin2,"%lf",&var.ap[i]);
			printf("%lf %lf\n",(double)i/10000,var.ap[i]);
		}
		printf("clamp voltage=%lf\n",var.vm_base);
		//exit(0);

	// Tablize exp functions.
	//	printf("start tablization\n");
	//	make_ExpTable();
	//	printf("finished tablization\n");

	// Initialization time
		//h = 1.0 / var.m;
		h = 1.0 / 10.0;
		h *= var.tsign[ii];

		time -= h;
		var.dt = h;
		var.beat = 0;

		ii = 0;
	
		for(var.beat=0;var.beat < beats; var.beat++){

			for (j = 0; j< 10400; j++){
				t = (double)j/10000.0;
				time += h;
				var.vm = var.ap[j];

				if (fabs(time) > tend &&  tend != 0.0) break;
				eular(NN,h,x,t);
				if (var.pflag) orbit(time);

				if (time>= 0.0){
					data_out(fp2,time,x);
				}
				
			}

			//draw_p(&mode,P,x,dvdt[0]);
			//mouse(&mode,x,dvdt[0]);
			if (fabs(time) > tend &&  tend != 0.0) break;

		}
	fclose(fp1);
	printf("[OK] file close fp1\n");
	fclose(fp2);
	printf("[OK] file close fp2\n");
	fclose(fp3);
	printf("[OK] file close fp3\n");
	closed_mem();
	printf("[OK] memory free \n");
	}
}

