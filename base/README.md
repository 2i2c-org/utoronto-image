# Base Environment

## Updating this environment

User environments should be easy to update when new security fixes arrive. However, we also want to avoid version drift where it is not necessary.

The file `environment.src.yml` contains the packages that users _want_. We then pin those at "update time" to a set of "compatible release" versions. In Python and Conda, compatible release of the form `"pkg~=x.y.z"` implies `"pkg>=x.y.z,==x.y.*"`. 

We impose the assumption that _all_ packages canreceive _patch_ updates. This can be seen in the generated constraints that all have three components.

To generate the solved spec, copy `environment.src.yml` into `environment.yml` and run `./partial-env-solve environment.yml 3.13` for Python 3.13. The Python version is fixed for a particular base image.
