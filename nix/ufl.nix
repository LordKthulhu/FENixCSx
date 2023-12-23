{ buildPythonPackage
, fetchFromGitHub
, setuptools
, numpy
}:

buildPythonPackage {
  pname = "ufl";
  version = "2023.2.0";

  src = fetchFromGitHub {
    owner = "FEniCS";
    repo = "ufl";
    rev = "2023.2.0";
    hash = "sha256-DdAD+FyZiPpUizaGwNrDDMSuoECbbgBrWPzm8V2XArI=";
  };

  format = "pyproject";

  propagatedBuildInputs = [
    setuptools
    numpy
  ];
}
