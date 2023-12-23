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
}:

stdenv.mkDerivation rec {

    pname = "dolfinx";
    version = "0.7.0";

    src = fetchFromGitHub {
        owner = "FEniCS";
        repo = "dolfinx";
        rev = "v0.7.0";
        hash = "sha256-G65mSk4wEVRvz+i+AQwCq80hzTAr/TREw/oCaLO8xu0=";
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
    ];

    cmakeFlags = [
        "-DDOLFINX_SKIP_BUILD_TESTS=TRUE"
    ];

    patches = [
        ./dolfinx.pc.in.patch
    ];
}
