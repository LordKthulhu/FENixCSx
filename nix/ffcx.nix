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
  version = "0.7.0";

  src = fetchFromGitHub {
    owner = "FEniCS";
    repo = "ffcx";
    rev = "v0.7.0";
    hash = "sha256-xJDJMNkhqf8yFE6v9m9nBCBVPxFqlrfz30oPFEorQa0=";
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
