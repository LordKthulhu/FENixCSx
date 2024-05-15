{ buildPythonPackage
, fetchFromGitHub
, setuptools
, numpy
, pip
}:

buildPythonPackage {
  pname = "ufl";
  version = "2024.1.0";

  src = fetchFromGitHub {
    owner = "FEniCS";
    repo = "ufl";
    rev = "2024.1.0";
    hash = "sha256-vXVgD6PVvMVvyocbRFQd7ca91MHwv32W+6TxDQm1y6M=";
  };

  format = "pyproject";

  propagatedBuildInputs = [
    setuptools
    numpy
    pip
  ];
}
