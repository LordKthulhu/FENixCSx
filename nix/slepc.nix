{ stdenv
, lib
, darwin
, fetchurl
, blas
, lapack
, mpi
, python311
, gfortran
, openssh
, petsc
, system
}:

stdenv.mkDerivation rec {
    pname = "slepc";
    version = "3.19.2";

    src = fetchurl {
        url = "https://slepc.upv.es/download/distrib/slepc-${version}.tar.gz";
        sha256 = "sha256-yn7ZBnlZcfvjXwjuJRomuGpEQqGGCbh4y6AINcnWIDQ=";
    };

    mpiSupport = true;

    # strictDeps = true;
    nativeBuildInputs = [ python311 gfortran ]
      ++ lib.optional mpiSupport mpi
      ++ lib.optional (mpiSupport && mpi.pname == "openmpi") openssh
    ;
    buildInputs = [ blas lapack petsc ];

    PETSC_DIR = "${petsc}";

    prePatch = lib.optionalString stdenv.isDarwin ''
      substituteInPlace config/install.py \
        --replace /usr/bin/install_name_tool ${darwin.cctools}/bin/install_name_tool
    '';

    preConfigure = ''
      patchShebangs ./lib/slepc/bin
    '';

    configureScript = "python ./configure";

    enableParallelBuilding = true;
    doCheck = stdenv.hostPlatform == stdenv.buildPlatform;
}
