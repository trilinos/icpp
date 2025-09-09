# Trilinos tutorial at ICPP 2025

- [Slides](https://github.com/trilinos/icpp/blob/main/slides.pdf)
- [Tutorial for distributed linear algebra - Tpetra](https://docs.trilinos.org/dev/packages/tpetra/doc/html/index.html)
- [Hands-on instructions for linear solver - Belos, Ifpack2, MueLu](https://github.com/trilinos/icpp/blob/main/lesson/lesson.md)

# Images

This repository contains Dockerfiles for two images:

- [`dependencies-cuda`](https://github.com/users/trilinos/packages/container/package/dependencies-cuda): an image with dependencies for Trilinos
- [`trilinos-cuda`](https://github.com/users/trilinos/packages/container/package/trilinos-cuda): an image with pre-installed Trilinos

Both images can be pulled from the GitHub Container Registry or built locally.


## Running locally

To use the images locally, please install `podman` or `docker`.

To locally run a container using the image with pre-installed Trilinos, run
```
./containerLauncher.sh -c trilinos
```
In order to build Trilinos from scratch in the container, run
```
./containerLauncher.sh -c dependencies
```
This will
1) Build the image with Trilinos dependencies (unless it has been previously built or pulled).
2) Clone Trilinos (unless there already is a folder trilinos/source).
3) Launch a container with source and build directory mapped from host.

Once in the container Trilinos can be configured and built using
```
configure_trilinos
build_trilinos
```
The configuration for the build can be found in [trilinos-build.cmake](https://github.com/trilinos/pytrilinos2_container/blob/main/trilinos-build.cmake).


# License and Copyright

See LICENSE and COPYRIGHT in this repository.
