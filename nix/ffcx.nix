{ buildPythonPackage
, fetchFromGitHub
, ps
, blas
, setuptools
, numpy
, pybind11
, scikit-build-core
, cmake
, pathspec
, pyproject-metadata
, ufl
, basix
}:

buildPythonPackage rec {

  pname = "ffcx";
  version = "0.8.0";

  src = fetchFromGitHub {
    owner = "FEniCS";
    repo = "ffcx";
    rev = "v0.8.0";
    hash = "sha256-zo+mGXUvxvqW76f2z8p24GV3Ln3jegB0WAplgqNPSqk=";
  };

  format = "pyproject";

  nativeBuildInputs = [
    ps
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
    basix
  ];

  dontUseCmakeConfigure = true;
}
