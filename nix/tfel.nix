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
        rev = "91fb079fa8e9f10fe1c7c4e9b42218bf129321b5";
        sha256 = "sha256-DlRMST5MCyRChGaeekjsMtyHrbHQIxyA5dpTY+c02UA=";
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
