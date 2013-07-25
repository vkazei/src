/**
@page typical Typical Usage
<p>
asg.x implements many use cases. The parameter choices described in
this section constitute a typical use case. We describe a large number
of additional use cases in the \ref alternate section.
<p>

The parameter file <a href="../../include/typical.par">typical.par</a> exemplifies
this use case, and illustrates some of the features of IWAVE's
parameter parser. For more information on parameter parsing, parallelism, and diagnostic output in IWAVE applications generally, see <a href="../../../iwave/doc/html/index.html">IWAVE Documentation</a>. For examples of various use cases, see the <a href="../../../iwave/demo/doc/html/index.html">IWAVE Demo Package</a>.

<p>
  <ul>
  <li>Required parameter
  <p>
    <ul>
    <li> datafile = [string] - filename for SU/SEGY trace output, name of
    existing file containing SEGY traces (with no EBCIDIC/reel header
    section). Recording geometry taken from trace headers of datafile. 
    <i>In particular, source location info (sx, sy, selev) taken from 
    datafile, not from source file (see below), which (if provided) 
    supplies only pulse shape information.</i>
    Data segments of traces overwritten with computed samples, for
    traces whose source and receiver locations lie in the computational
    grid.</li>
    </li>
    </ul>
  <p>
  <li>Optional parameters 
<p>
  [Those stated without defaults are required for this use case.]
    <ul>
    <li> Material parameters. 
<p>
      <ul>
      <li>velocity = [string] - name of RSF header file for sound (p-) velocity </li>
      <li>density  = [string] or rho = [string] [Default: homogeneous, 1000 kg/m^3] - 
          name of RSF header file for material density - if this keyword omitted, 
          default constant value is applied throughout grid</li>
      </ul>
    <p>
    IWAVE apps expect material parameters and other
    grid functions to be stored in RSF format files. For the basics on
    RSF, see
    http://www.reproducibility.org/wiki/Guide_to_RSF_file_format IWAVE
    defines a few useful extensions to the basic RSF format. Extra keywords 
    define the physical significance of the grid axis (is the fastest
    axis z or x or y?) and parameter value scaling. See <a href="../../../grid/doc/html/index.html">the IWAVE grid package documentation</a> for
    information on the IWAVE extensions to the RSF format. 
<p>
    IWAVE imposes
    one limitation on hypercubical grids, defined by RSF attributes: all 
    grid points on the primal grid (compressional velocity, bulk modulus, 
    pressure) must be of the form (i*dx, j*dy, k*dz) (for the 3D case). 
    Otherwise put, the origin of the physical coordinate system must belong 
    to the extension of the pressure grid to all of Euclidean space. 
    The proper functioning of various sampling and resampling functions in 
    IWAVE depends on this assumption. Therefore, for example, if dx=10, 
    then all pressure grid x-coordinates must be multiples of 10.
<p>
    Note: velocity RSF data structure defines the grid of the pressure
    and bulk modulus fields. The grids for the (particle) velocity
    components and buoyancies are obtained by shifting this grid by a
    half-step in each coordinate direction. The spatial dimension of the
    simulation is that defined by the velocity (pressure, bulk modulus)
    grid, i.e. the greatest int dim (between 1 and 3 inclusive) for
    which the RSF parameter ndim is greater than 1, and the spatial
    steps used in the simulation are the dk, k=1,...,dim. The density
    domain defined by the density RSF data structure may differ from the
    velocity domain, but the density is assumed to have the same
    grid steps (d's), and the code does not test this assumption.
    The density reciprocal (buoyancy) is interpolated linearly onto the
    shifted particle velocity grids, and extrapolated as constant, first
    in y, then in x, then in z, if necessary.
    </li>
<p>
    <li>Spatial interpolation order for sampling (traces) and adjoint 
    sampling (source)
<p>
      <ul>
      <li>sampord   = [int] [Default = 0]. Valid options are 0 
      (greatest-integer sampling), 1 (multilinear sampling)
      </li>
      </ul>
<p>
    NOTE: the "greatest integer" option extracts (or inserts, for the
    adjoint case) the sample at the gridpoint whose coordinates are
    closest and less than those of the nominal sample point. Thus
    sampling the pressure field in the row of grid cells immediately
    inside (i.e. with greater normal coordinate) of a zero-pressure
    reflecting boundary will produce zero samples, and inserting a
    source point using the simple isotropic point source option in
    this layer will also produce zero energy input. Note that this
    occurs when z=0 defines the reflecting boundary, the simulation
    domain is in z>0, and the source or receiver z-coordinate is less
    than the spatial step in z. To obtain nontrivial results with
    sources and/or receivers in the first row of grid cells inside of
    a reflecting boundary, always use multilinear sampling
    (sampord=1).
    </li>
    <p>
    <li> Simple isotropic point source representation
    <p>
      <ul>
      <li>
      srctype   = point</li>
      <li>
      source    = [string] name of SU file from which to read target
      propagating pulse (only the first trace will be read).<br> <b>NB:</b>
        <ol>
        <li> the data from this file will be interpolated onto the 
        computational time grid, via a cubic spline algorithm. Thus 
        the time step specified in the source trace does not
        have to be the same as the time step of the data traces, 
        and both are generally different from the internal time step 
        of the simulation.</li>
        <li> The source is inserted into the spatial grid <i>at the location 
	defined by the datafile</i>, using adjoint interpolation of order 
        sampord (see above - either chop or linear): 
        the source trace header words 
        (sx, sy, selev) define location <i>relative</i> to the
        source point as defined in the datafile. </li>
        </ol>
      </li>
      <li> 
      refvel    = [float] [Default = 1.5 m/ms] velocity in hypothetical
      homogeneous fluid </li>
      <li>
      refbou    = [float] [Default = 0.001 m^3/kg] buoyancy in hypothetical
      homogeneous fluid</li>
      <li>
      refdist   = [float] [Default = 1000 m] distance from source in
      hypothetical homogeneous fluid.</li>
      </ul>
<p>
    Discrete spatial delta multiplied by a source wavelet (time
    function). This naive representation of a point isotropic radiator
    is only moderately accurate, but suffices for many purposes: it
    gives pressure field RMS errors of (at most) a few percent when
    other sources of error are properly controlled. Scaled so that in 3D
    the propagating wave matches the specified wavelet in reduced
    time, for a specified propagation velocity and buoyancy and at
    a specified distance from the source. The discrete spatial delta is
    represented by adjoint interpolation.
    </li>
    <p>
    <li>
    Finite difference scheme
      <ul>            
      <li>
      cmax = [float] [Default = CMAX_DEF - see asg/include/defaults.h ] 
      maximum permitted compressional velocity. Input velocity or bulk 
      modulus checked against this limit or corresponding bulk modulus 
      limit, error returned violated at any grid point. In this use case, 
      NOT used to compute time step. Never used to verify stability - see
      \ref asgnotes for information on stable time stepping. </li>
      <li>
      cmin = [float] [Default = CMIN_DEF - see asg/include/defaults.h ] 
      minimum permitted compressional velocity. Input velocity or bulk 
      modulus checked against this limit or corresponding bulk modulus 
      limit, error returned if violated at any grid point. Functions 
      exclusively as a sanity check on the input parameters in this 
      implementation. Since simulation spatial grid is directly specified, 
      not used to verify any von N. GP/WL accuracy criterion or the like. 
      </li>
      <li> 
      dmax = [float] [Default = DMAX_DEF - see asg/include/defaults.h ]
      maximum permitted density. Input density or buoyancy checked against
      this limit or corresponding buoyancy limit, error returned if violated
      at any grid point. Sanity check only.
      </li>
      <li>
      dmin = [float] [Default = DMIN_DEF - see asg/include/defaults.h ]
      minimum permitted density. Input density or buoyancy checked against
      this limit or corresponding buoyancy limit, error returned if violated
      at any grid point. Sanity check only.      
      </li>
      <li> 
      cfl = [float] fractional CFL number, 0 < cfl < 1 [Default=CFL_DEF, 
      see asg/include/defaults.h] Maximum permitted time step, as fraction 
      of stable time step for (2,2) scheme. Computed by method described
      in Gustafsson and Wahlund, SIAM J. Sci. Comp. 26 (2004), pp. 272-293. 
      This (2,2) time step is at most equal to the step produced by von 
      Neumann plane wave analysis (i.e. dt < min(dx)/(sqrt(dim)*cmax)), 
      but can be substantially smaller if the density varies rapidly. 
      Default value for cfl selected to ensure stability for all schemes 
      in the currently implemented family (2-2 through 2-12, 1-3D). More 
      conservative choices may result in less grid dispersion for higher
      order schemes.</li>
      <li>
      scheme_phys, scheme_npml = [string], [string]
      [Defaults = 24, 24] - encodes time and space orders,within families
      of schemes. Schemes may be specified independently for physical
      domain (scheme_phys) and PML layers (scheme_npml). Valid choices are
        <ul>
        <li>
        22: 2nd order in space and time </li>
        <li>
        24: 2nd order in time, 4th order in space (default choice) </li>
        <li>
        210: 2nd order in time, 10th order in space (3D only)</li>
        <li>
        2k: 2nd order in time, 2kth order in space, 1 <= k <= 7</li>  
        </ul>
      For the 2k choice, the half-orders k_phys, k_npml must also be 
      specified - legal values are 1,2,...7. NOTE: in release 1.0
      (November 2009), the 2D 210 scheme is not functional - calling it will
      result in an error code being returned. The 1D and 3D versions of 210
      are completely functional, on the other hand. To obtain 10th order (or
      any other order higher than 4) in 2D space, use the 2k construction.</li>
      <li>
      k_phys, k_npml = [int], [int] - half-orders in space for (2,2k)
      scheme. Valid range = 1 through 7. Required if scheme_phys 
      or scheme_npml = 2k, no effect
      otherwise.  NOTE: 22, 24, and 210 schemes are inlined, whereas 2k
      schemes employ an internal loop over the stencil. Thus for example
      210 tends to be up to 2x faster than 2k with k=5.  NOTE: it is NOT
      NECESSARY to use the same orders in the interior and in the pml
      layers. A high order scheme in the physical can be used in
      combination with the 22 scheme in the pml layers for example, for
      some small boost in speed</li>
      <li>
      PML layers descriptors: construction of PML layers depends on 
        <ul>
        <li>
        fpeak = [float] [Default=0.01KHz] nominal central frequency for
        wavefield, used only to calibrate thickness of PML layers. As with
        cmin, no role in accuracy control.</li>
        <li>
        npml_ampl = [float], [Default = 10.3616], - damping factor in
        absorbing layers</li>
        <li>
        Thicknesses of left and right absorbing layers along each axis, in
        wavelengths at nominal peak frequency (fpeak) and maximum velocity
        (cmax). For example, to specify free surface at z=0, absorbing
        conditions at all other boundaries, in a 2D simulation, reasonable
        choices would be nl1=0.0, nr1=0.5, nl2=0.5, nr2=0.5 (assuming that z
        is axis 1 and x is axis 2). Parameters are:
          <ul> 
          <li>nl1,nr1 = [float], [float] [Defaults = 0.0, 0.0], for axis 1;</li>
          <li>nl2,nr2 = [float], [float] [Defaults = 0.0, 0.0], for axis 2;</li>
          <li>nl3,nr3 = [float], [float] [Defaults = 0.0, 0.0], for axis 3.</li> 
          </ul>
        </li>
        </ul>
      </li>
      </ul>
<p>
  </li>
  </ul>

</ul>

*/
