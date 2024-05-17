{
  inputs.nixpkgs.url = "github:nixos/nixpkgs";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { flake-utils, nixpkgs, self, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        core-python-packages = with pkgs.python311Packages; [
            python
            venvShellHook
            pip
            numpy
            ninja
            mpi4py
        ];
        local-packages = with self.packages.${system}; [
            # slepc
            nanobind
            petsc4py
            scotch
            tfel
            mgis
            ufl
            basix
            ffcx
            dolfinx-cpp
            dolfinx-python
            #dolfinx-materials
        ];
      in
      {
        # TFEL/MFront
        packages.tfel = pkgs.callPackage ./nix/tfel.nix { };

        # MFrontGenericInterfaceSupport (MGIS)
        packages.mgis = pkgs.callPackage ./nix/mgis.nix {
            tfel = self.packages.${system}.tfel;
        };

        # Dolfinx-Materials
        packages.dolfinx-materials = pkgs.python311Packages.callPackage ./nix/dolfinx-materials.nix { };

        # accessories for FEniCSx
        packages.petsc4py = pkgs.python311Packages.callPackage ./nix/petsc4py.nix { };
        packages.scotch = pkgs.python311Packages.callPackage ./nix/scotch.nix { };
        packages.slepc  = pkgs.callPackage ./nix/slepc.nix { };
        packages.slepc4py = pkgs.python311Packages.callPackage ./nix/slepc4py.nix {
            slepc = self.packages.${system}.slepc;
            petsc4py = self.packages.${system}.petsc4py;
        };
        packages.nanobind = pkgs.python311Packages.callPackage ./nix/nanobind.nix { };
        packages.adios2 = pkgs.python311Packages.callPackage ./nix/adios2.nix {};

        # FEniCSx components
        packages.ufl = pkgs.python311Packages.callPackage ./nix/ufl.nix { };
        packages.basix = pkgs.python311Packages.callPackage ./nix/basix.nix {
            ufl = self.packages.${system}.ufl;
            nanobind = self.packages.${system}.nanobind;
        };
        packages.ffcx = pkgs.python311Packages.callPackage ./nix/ffcx.nix {
            ufl = self.packages.${system}.ufl;
            basix = self.packages.${system}.basix;
        };
        packages.dolfinx-cpp = pkgs.callPackage ./nix/dolfinx-cpp.nix {
            scotch = self.packages.${system}.scotch;
            ufl = self.packages.${system}.ufl;
            basix = self.packages.${system}.basix;
            ffcx = self.packages.${system}.ffcx;
            adios2 = self.packages.${system}.adios2;
        };
        packages.dolfinx-python = pkgs.python311Packages.callPackage ./nix/dolfinx-python.nix {
            ufl = self.packages.${system}.ufl;
            basix = self.packages.${system}.basix;
            ffcx = self.packages.${system}.ffcx;
            dolfinx-cpp = self.packages.${system}.dolfinx-cpp;
            petsc4py = self.packages.${system}.petsc4py;
            slepc4py = self.packages.${system}.slepc4py;
            nanobind = self.packages.${system}.nanobind;
            adios2 = self.packages.${system}.adios2;
        };

        devShell = pkgs.mkShell {
          venvDir = "./.venv";
          buildInputs = core-python-packages ++ local-packages ++ [pkgs.openmpi];
        };
      }
    );
}
