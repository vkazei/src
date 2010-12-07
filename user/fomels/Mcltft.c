/* Complex local time-frequency transform. */
/*
  Copyright (C) 2010 University of Texas at Austin
  
  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version.
  
  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.
  
  You should have received a copy of the GNU General Public License
  along with this program; if not, write to the Free Software
  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/
#include <rsf.h>

#include <math.h>

#include "cmultidivn.h"

int main(int argc, char* argv[])
{
    bool inv, verb;
    int i1, n1, iw, nw, i2, n2, rect, niter, n12;
    char *label;
    float t, d1, w, w0, dw;
    sf_complex *trace, *kbsc, *sscc=NULL;
    sf_file in, out, basis;
   
    sf_init(argc,argv);
    in = sf_input("in");
    out = sf_output("out");

    if (SF_COMPLEX != sf_gettype(in)) sf_error("Need complex input");

    if (!sf_histint(in,"n1",&n1)) sf_error("No n1= in input");
    if (!sf_histfloat(in,"d1",&d1)) d1=1.;
    label = sf_histstring(in,"label1");

    if (!sf_getbool("inv",&inv)) inv=false;
    /* if y, do inverse transform */

    if (!sf_getbool("verb",&verb)) verb = false;
    /* verbosity flag */

    if (NULL != sf_getstring("basis")) {
	basis = sf_output("basis");
    } else {
	basis = NULL;
    }

    if (!inv) {
	if (!sf_getint("nw",&nw)) nw = kiss_fft_next_fast_size(n1);
	/* number of frequencies */
	    
	if (!sf_getfloat("dw",&dw)) dw = 1./(nw*d1);
	/* frequency step */

	if (!sf_getfloat("w0",&w0)) w0=-0.5/d1;
	/* first frequency */

	n2 = sf_leftsize(in,1);
	sf_shiftdim(in, out, 2);

	sf_putint(out,"n2",nw);
	sf_putfloat(out,"d2",dw);
	sf_putfloat(out,"o2",w0);

	if (NULL != label && !sf_fft_label(2,label,out)) 
	    sf_putstring(out,"label2","Wavenumber");
	sf_fft_unit(2,sf_histstring(in,"unit1"),out);

	if (!sf_getint("rect",&rect)) rect=10;
	/* smoothing radius */
	if (!sf_getint("niter",&niter)) niter=100;
	/* number of inversion iterations */
    } else {
	n2 = sf_leftsize(in,2);

	if (!sf_histint(in,"n2",&nw)) sf_error("No n2= in input");
	if (!sf_histfloat(in,"d2",&dw)) sf_error("No d2= in input");
	if (!sf_histfloat(in,"o2",&w0)) sf_error("No o2= in input");

	sf_unshiftdim(in, out, 2);
    }

    if (NULL != basis) {
	sf_shiftdim(in, basis, 2);
	sf_putint(basis,"n2",nw);
	sf_putfloat(basis,"d2",dw);
	sf_putfloat(basis,"o2",w0);
	if (NULL != label && !sf_fft_label(2,label,basis)) 
	    sf_putstring(basis,"label2","Wavenumber");
	sf_fft_unit(2,sf_histstring(in,"unit1"),out);
    }
	
    n12 = n1*nw;
    dw *= 2.*SF_PI;
    w0 *= 2.*SF_PI;

    trace = sf_complexalloc(n1);
    kbsc = sf_complexalloc(n12);
    sscc = sf_complexalloc(n12);
    
    /* basis functions */
    for (iw=0; iw < nw; iw++) {
        w = w0 + iw*dw;

	for (i1=0; i1 < n1; i1++) {
	    t = i1*d1;

	    kbsc[iw*n1+i1] = sf_cmplx(cosf(w*t),sinf(w*t));
	}
    }

    if (NULL != basis) {
	sf_complexwrite(kbsc,n12,basis);
    }

    if (!inv) cmultidivn_init(nw, 1, n1, &n1, &rect, kbsc, verb && (n2 < 500)); 

    for (i2=0; i2 < n2; i2++) {
	sf_warning("slice %d of %d;",i2+1,n2);

	if (!inv) {
	    cmultidivn (trace,sscc,niter);
	    sf_complexwrite(sscc,n12,out);
	} else {
	    for (i1=0; i1 < n1; i1++) {
		trace[i1] = sf_cmplx(0.,0.);
	    }
	    sf_complexread(sscc,n12,in);
	    for (iw=0; iw < nw; iw++) {
		for (i1=0; i1 < n1; i1++) {
#ifdef SF_HAS_COMPLEX_H
		    trace[i1] += sscc[iw*n1+i1]*conjf(kbsc[iw*n1+i1]);
#else
		    trace[i1] = sf_cadd(trace[i1],
					sf_cmul(sscc[iw*n1+i1],
						conjf(kbsc[iw*n1+i1])));
#endif
		}
	    }
	    sf_complexwrite(trace,n1,out);
	}
    }
    sf_warning(".");

    exit(0);
}

