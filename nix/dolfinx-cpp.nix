{ stdenv
, fetchFromGitHub
, blas
, cmake
, mpi
, pugixml
, boost
, ufl
, basix
, ffcx
, pkg-config
, hdf5-mpi
, scotch
, petsc
, adios2
}:

stdenv.mkDerivation rec {

    pname = "dolfinx";
    version = "0.8.0";

    src = fetchFromGitHub {
        owner = "FEniCS";
        repo = "dolfinx";
        rev = "v0.8.0";
        hash = "sha256-DYnzl7WI600KuC79ponzuJzr13BucDuRoIdm+U1nxX0=";
    };

    sourceRoot = "${src.name}/cpp";

    nativeBuildInputs = [
        cmake
    ];

    buildInputs = [
        blas
        mpi
        pugixml
        boost
        pkg-config
        hdf5-mpi
        scotch
    ];

    propagatedBuildInputs = [
        ufl
        basix
        ffcx
        petsc
        adios2
    ];

    cmakeFlags = [
        "-DDOLFINX_SKIP_BUILD_TESTS=TRUE"
    ];

    patches = [
        ./dolfinx.pc.in.patch
    ];
}
