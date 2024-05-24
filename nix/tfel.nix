{ stdenv
, pkgs
, fetchFromGitHub
, ps
, cmake
, python3
, gnuplot
}:

stdenv.mkDerivation rec {
    pname = "tfel";
    version = "5.0.0-dev";

    src = fetchFromGitHub {
        owner = "thelfer";
        repo = "tfel";
        rev = "3bde236d1fbf0bbef561b2aedb95e69e350a5154";
        sha256 = "sha256-BTX6dldANIyc1f/fcDYWF1v0DKyq/J0wzP/h3luHfRU=";
    };

    nativeBuildInputs = [
        cmake
        ps
    ];

    propagatedBuildInputs = [
        python3
        pkgs.python311Packages.numpy
        pkgs.python311Packages.boost
        gnuplot
    ];

    cmakeFlags = [
        "-Denable-python-bindings=ON"
        "-Dlocal-castem-header=ON"
    ];
}
