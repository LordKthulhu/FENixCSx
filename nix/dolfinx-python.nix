{ buildPythonPackage
, fetchFromGitHub
, setuptools
, numpy
, ufl
, basix
, ffcx
, dolfinx-cpp
, pybind11
, cmake
, ps
, mpi
, pugixml
, boost
, hdf5-mpi
, pkg-config
, petsc4py
, petsc
, cffi
, certifi
, zlib
}:

buildPythonPackage rec {
  pname = "dolfinx";
  version = "0.7.0";

  src = fetchFromGitHub {
    owner = "FEniCS";
    repo = "dolfinx";
    rev = "v${version}";
    hash = "sha256-G65mSk4wEVRvz+i+AQwCq80hzTAr/TREw/oCaLO8xu0=";
  };

  sourceRoot = "${src.name}/python";

  format = "pyproject";

  nativeBuildInputs = [
    cmake
    ps
  ];

  buildInputs = [
    basix
    dolfinx-cpp
    mpi
    pugixml
    boost
    hdf5-mpi
    pkg-config
  ];

  propagatedBuildInputs = [
    setuptools
    numpy
    pybind11
    petsc4py
    cffi
    certifi
    zlib
    ufl
    basix
    ffcx
    petsc
  ];

  dontUseCmakeConfigure = true;

}
