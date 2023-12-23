{ buildPythonPackage
, fetchFromGitHub
, ps
, ninja
, blas
, setuptools
, numpy
, pybind11
, scikit-build-core
, cmake
, pathspec
, pyproject-metadata
, ufl
}:

buildPythonPackage rec {

  pname = "basix";
  version = "v0.7.0.post0";

  src = fetchFromGitHub {
    owner = "FEniCS";
    repo = "basix";
    rev = "v0.7.0.post0";
    hash = "sha256-CiNQkq8wPSEdi3egYSY6z5C6PrOGmNJJvOBRbZArvsI=";
  };

  format = "pyproject";

  nativeBuildInputs = [
    ps
    ninja
  ];

  buildInputs = [
    blas
  ];

  propagatedBuildInputs = [
    setuptools
    numpy
    pybind11
    scikit-build-core
    cmake
    pathspec
    pyproject-metadata
    ufl
  ];

  dontUseCmakeConfigure = true;
}
