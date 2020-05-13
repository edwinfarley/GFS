# GFS Installation and Getting Started Instructions

1. Installing GFS: With devtools, use install_github to fetch and install the package from https://github.com/edwinfarley/GFS, or clone the repository yourself from the same link and then use install_local, passing the path to the local directory that contains the package. Now load the package with a call to library(GFS).

2. Installing Python components: Python component will be downloaded automatically when running permute_inputs for the first time. Alternatively, use the included py_setup() function in R. No input is required. This function clones the repository at https://github.com/edwinfarley/GFSpython to a directory named "python" at path.package("GFS").

3. Set up the Python environment: We recommend using an Anaconda distribution of Python 3.6+ for managing environments. Use the included create_python_environment() function to set up a Conda environment with all the required packages. This function takes a single argument, "conda_envname," the name of the environment to be created. The new environment will include the following packages: numpy, pandas, pymc3, mkl, theano, and mkl-service.

4. Ready to go: These are the required steps for preparing to run the permute_inputs function to sample permutations. Take a look at the documentation with ?permute\_inputs in R to see information about the arguments and sampling parameters. Be sure to pass the name of your Conda environment to the conda_env parameter.
