# Base Environment

## Updating this environment

Communities typically provide 2i2c with environments that are loosely pinned — there are no strong concerns about many package versions, only that the environment "works". However, once 2i2c deploys such an image, the expectation is typically that it won't majorly change such that content authored for one version still works on another. This implies that *users expect strongly pinned environments*.

Meanwhile, 2i2c engineers need to be able to update environments when new security fixes arrive. This implies that *we can't promise exact pinning to our communities*. Yet, without any kind of constraints, future work on released images may resolve and change the package versions.

The middle ground is to constrain only user-facing packages within some sensible compatibility bound. The tool `freeze-compatible-environment` does just this:

1. The file `environment.src.yml` contains the packages that users ask for. We prepare a "fresh" image by tweaking any depedencies before copying the file to `environment.yml`.
2. We build an image using `docker buildx bake ...`. This generates an image `<IMAGE>:<TAG>`
3. We run 
   ```bash
   ./freeze-compatible-environment <IMAGE>:<TAG> ./environment.src.yml > environment.yml
   ```
   to "freeze" the compatibility requirements[^req] of the image.
4. Future builds use these compatibility constraints.

In theory, the generated `environment.yml` can be used as input for future additions of packages, or package updates. 

[^req]: In Python and Conda, compatible release of the form `"pkg~=x.y.z"` implies `"pkg>=x.y.z,==x.y.*"`. We take any solved version `x.y.z` and generate `~x.y.z`. This assumption is not perfect; we may need to tweak the frozen environment by hand.

