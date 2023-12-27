{ buildPythonPackage
, fetchPypi
, mpi
, numpy
, petsc
, slepc
, cython
, petsc4py
, system
}:

buildPythonPackage rec {
  pname = "slepc4py";
  version = "${slepc.version}";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-2otqeqr15El7iWsuR4xC3Z3k+zHak+spQYG+o7tgx2c=";
  };

  nativeBuildInputs = [
    mpi
  ];

  buildInputs = [
    petsc
    slepc
    cython
  ];

  propagatedBuildInputs = [
    numpy
    petsc4py
  ];

  PETSC_DIR = "${petsc}";
  SLEPC_DIR = "${slepc}";
  PETSC_ARCH = "${system}";

  doCheck = false;

}
