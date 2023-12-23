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
    version = "4.2.0";

    src = fetchFromGitHub {
        owner = "thelfer";
        repo = "tfel";
        rev = "TFEL-${version}";
        sha256 = "sha256-VfAck+D1zPpt45i1VdAn0ITulhzVY4kUFAoCW0LtjuE=";
    };

    nativeBuildInputs = [
        cmake
        ps
    ];

    propagatedBuildInputs = [
        python3
        pkgs.python311Packages.numpy
        gnuplot
    ];

    cmakeFlags = [
        "-Denable-python=ON"
    ];
}
