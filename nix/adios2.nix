{
stdenv
, fetchFromGitHub
, cmake
, python3
, mpi
, hdf5-mpi
, perl
, pkg-config
, zlib
, bzip2
, bison
, flex
, mpi4py
, ps
}:

stdenv.mkDerivation rec {
    pname = "ADIOS2";
    version = "2.10.0";

    src = fetchFromGitHub {
        owner = "ornladios";
        repo = "ADIOS2";
        rev = "v${version}";
        hash = "sha256-khNxbQFM2yQ3k6tcidrhC4B8qNdFjV7lKB/XZBslqGA=";
    };

    nativeBuildInputs = [
        cmake
        ps
        perl
        mpi
        hdf5-mpi
        zlib
        bzip2
        bison
        flex
        pkg-config
        mpi4py
    ];

    propagatedBuildInputs = [
        python3
    ];

    cmakeFlags = [
        "-DADIOS2_USE_Python=TRUE"
        "-DADIOS2_INSTALL_GENERATE_CONFIG=OFF"
    ];
}
