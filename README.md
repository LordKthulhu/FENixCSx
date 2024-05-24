# FENixCSx - FEniCSx and dolfinx-materials installed through Nix

Everything seems to install properly with:

```
nix develop
```

(Experimental features nix-command and flakes must be allowed in Nix)
Some python packages still need to be installed through pip:

```
pip install pyvista notebook jupyterlab ipywidgets trame trame-vtk trame-vuetify
```

Then, you can run the test notebooks for FEniCSx and dolfinx-materials found in `/test` (in `nonlinear_heat_transfer` when importing the MFront library, check the extention - it should be `.so` on linux and `.dylib` on osx)

# To-do list

- Add MUMPS support in PETSc
