{ buildPythonPackage
, fetchurl
, setuptools
}:

buildPythonPackage rec {
    pname = "dolfinx-materials";
    version = "0.2.1";

    src = fetchurl {
        url = "https://gitlab.enpc.fr/navier-fenics/dolfinx_materials/-/archive/v0.2.1/dolfinx_materials-v0.2.1.tar";
        sha256 = "sha256-5s5ayNPc5zRql8VMKp7pRyDKEJZWFYNYrmzDNGxxrVw=";
    };

    pyproject = true;

    propagatedBuildInputs = [
        setuptools
    ];
}
