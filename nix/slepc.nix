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
    petscInArchFolder = runCommand "petscInArchFolder" {} ''
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

    # strictDeps = true;
    nativeBuildInputs = [ python311 gfortran mpi openssh];
    buildInputs = [ blas lapack petscInArchFolder ];

    PETSC_DIR = "${petscInArchFolder}";
    PETSC_ARCH = "${system}";
    # SLEPC_DIR = "/private/tmp/nix-build-slepc-3.19.2.drv-3/slepc-3.19.2";

    postPatch = lib.optionalString stdenv.isDarwin ''
      substituteInPlace config/install.py \
        --replace /usr/bin/install_name_tool ${darwin.cctools}/bin/install_name_tool
    '';
    # patches = [
    #   ./slepc/petsc.py.patch
    #   ./slepc/gmakefile.patch
    #   ./slepc/makefile.patch
    # ];

    preConfigure = ''
      patchShebangs ./lib/slepc/bin
    '';

    configureScript = "python ./configure";

    preBuild = ''
       export SLEPC_DIR=$(pwd)
    '';

    enableParallelBuilding = true;
    doCheck = stdenv.hostPlatform == stdenv.buildPlatform;
    # doCheck = false;
}
