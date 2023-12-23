{ buildPythonPackage
, fetchgit
, setuptools
}:

buildPythonPackage rec {
    pname = "dolfinx-materials";
    version = "0.2.1";

    src = fetchgit {
        url = "https://gitlab.enpc.fr/navier-fenics/dolfinx_materials.git";
        rev = "v${version}";
        sha256 = "sha256-txWGfYDsuErFUY/g2jk2xcRJtSgHeiE6B99Cl9YKcuo=";
    };

    pyproject = true;

    propagatedBuildInputs = [
        setuptools
    ];
}
