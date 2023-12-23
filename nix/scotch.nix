{
stdenv
, fetchFromGitHub
, pkgs
, cmake
, gfortran
, bison
, flex
, mpi
, zlib
, ps
}:

stdenv.mkDerivation rec {
pname = "scotch";
version = "7.0.4";

src = fetchFromGitHub {
    owner = "live-clones";
    repo = "${pname}";
    rev = "v${version}";
    sha256 = "sha256-uaox4Q9pTF1r2BZjvnU2LE6XkZw3x9mGSKLdRVUobGU=";
};

nativeBuildInputs = [
cmake
gfortran
ps
];

buildInputs = [
bison
flex
mpi
zlib
];

}
