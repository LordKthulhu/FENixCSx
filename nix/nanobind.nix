{ buildPythonPackage
, fetchurl
, clang
, cmake
, pip
}:

buildPythonPackage rec {
  pname = "nanobind";
  version = "1.9.2";
  format = "wheel";

  src = fetchurl {
    url = "https://files.pythonhosted.org/packages/62/e6/84bdfbf05913ec5b4a426e5ba614d4df669c66929376dde96d6d55da3199/nanobind-1.9.2-py3-none-any.whl";
    sha256 = "sha256-E3up51zGsuXZLCrLmBC+qgebnI5daMWBtPkNYm15NYw=";
  };

  buildInputs = [
    pip
  ];

  propagatedBuildInputs = [
    clang
  ];
}
