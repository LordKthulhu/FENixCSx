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
        perl
        mpi
        hdf5-mpi
        zlib
        bzip2
        bison
        flex
        pkg-config
    ];

    propagatedBuildInputs = [
        python3
    ];

    # cmakeFlags = [
    #     "-DADIOS2_USE_Python=TRUE"
    # ];
}
