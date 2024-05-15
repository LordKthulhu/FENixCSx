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
, nanobind
}:

buildPythonPackage rec {

  pname = "basix";
  version = "v0.8.0";

  src = fetchFromGitHub {
    owner = "FEniCS";
    repo = "basix";
    rev = "v0.8.0";
    hash = "sha256-SfpuPYgrh/FyK0dAgXcwcRHUSg7uy+AWFbtLubswfFo=";
  };

  format = "pyproject";

  nativeBuildInputs = [
    ps
    ninja
    nanobind
  ];

  buildInputs = [
    blas
    nanobind
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
