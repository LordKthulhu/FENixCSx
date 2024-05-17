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
, runCommand
}:
let
    petscWithArchFolder = runCommand "petscInArchFolder" {} ''
        mkdir -p $out/${system}/
        cp -R ${petsc}/* $out/
        cp -R ${petsc}/* $out/${system}/
    '';
in
stdenv.mkDerivation rec {
    pname = "slepc";
    version = "3.19.2";

    src = fetchurl {
        url = "https://slepc.upv.es/download/distrib/slepc-${version}.tar.gz";
        sha256 = "sha256-yn7ZBnlZcfvjXwjuJRomuGpEQqGGCbh4y6AINcnWIDQ=";
    };

    nativeBuildInputs = [ python311 gfortran mpi openssh];
    buildInputs = [ blas lapack petscWithArchFolder ];

    PETSC_DIR = "${petscWithArchFolder}";
    PETSC_ARCH = "${system}";

    postPatch = lib.optionalString stdenv.isDarwin ''
      substituteInPlace config/install.py \
        --replace /usr/bin/install_name_tool ${darwin.cctools}/bin/install_name_tool
    '';

    preConfigure = ''
      patchShebangs ./lib/slepc/bin
    '';

    configureScript = "python ./configure";

    preBuild = ''
       export SLEPC_DIR=$(pwd)
    '';

    enableParallelBuilding = true;
    doCheck = false;
}
