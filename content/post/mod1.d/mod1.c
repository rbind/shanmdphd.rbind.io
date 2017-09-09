#include <math.h>
#define max(a,b) (((a)>(b))?(a):(b))
#define min(a,b) (((a)<(b))?(a):(b))
extern long dadt_counter;
extern double InfusionRate[99];
extern double *par_ptr;
extern double podo;
extern double tlast;

// prj-specific differential eqns
void RxODE_mod_mod1_dydt(unsigned int neq, double t, double *__zzStateVar__, double *__DDtStateVar__)
{
double
	C2,
	centr,
	V2,
	C3,
	peri,
	V3,
	depot,
	KA,
	CL,
	Q,
	eff,
	Kin,
	EC50,
	Kout;

	V2 = par_ptr[0];
	V3 = par_ptr[1];
	KA = par_ptr[2];
	CL = par_ptr[3];
	Q = par_ptr[4];
	Kin = par_ptr[5];
	EC50 = par_ptr[6];
	Kout = par_ptr[7];

	depot = __zzStateVar__[0];
	centr = __zzStateVar__[1];
	peri = __zzStateVar__[2];
	eff = __zzStateVar__[3];

	C2 = centr / V2;
	C3 = peri / V3;
	__DDtStateVar__[0] = InfusionRate[0] + - KA * depot;
	__DDtStateVar__[1] = InfusionRate[1] + KA * depot - CL * C2 - Q * C2 + Q * C3;
	__DDtStateVar__[2] = InfusionRate[2] + Q * C2 - Q * C3;
	__DDtStateVar__[3] = InfusionRate[3] + Kin *( 1 - C2 /( EC50 + C2)) - Kout * eff;
    dadt_counter++;
}

// prj-specific derived vars
void RxODE_mod_mod1_calc_lhs(double t, double *__zzStateVar__, double *lhs) {
double
	C2,
	centr,
	V2,
	C3,
	peri,
	V3,
	depot,
	KA,
	CL,
	Q,
	eff,
	Kin,
	EC50,
	Kout;

	V2 = par_ptr[0];
	V3 = par_ptr[1];
	KA = par_ptr[2];
	CL = par_ptr[3];
	Q = par_ptr[4];
	Kin = par_ptr[5];
	EC50 = par_ptr[6];
	Kout = par_ptr[7];

	depot = __zzStateVar__[0];
	centr = __zzStateVar__[1];
	peri = __zzStateVar__[2];
	eff = __zzStateVar__[3];

	C2 = centr / V2;
	C3 = peri / V3;

	lhs[0]=C2;
	lhs[1]=C3;
}
