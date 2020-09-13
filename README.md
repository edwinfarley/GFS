# GFS Installation and Getting Started Instructions

1. Installing GFS: With `devtools`, use `install_github` to fetch and install the package from https://github.com/edwinfarley/GFS, or clone the repository yourself from the same link and then use `install_local`, passing the path to the local directory that contains the package. Now load the package with a call to `library(GFS)`.

2. Installing Python components: Python component will be downloaded automatically when running permute_inputs for the first time. Alternatively, use the included `py_setup()` function in R. No input is required. This function clones the repository at https://github.com/edwinfarley/GFSpython to a directory named "python" at `path.package("GFS")`.

3. Set up the Python environment: We *recommend* using an Anaconda distribution of Python 3.6+ for managing environments. Use the included `create_python_environment()` function to set up a Conda environment with all the required packages. This function takes a single argument, `conda_envname`, the name of the environment to be created. The new environment will include the following packages: numpy, pandas, pymc3, mkl, theano, and mkl-service.

4. Ready to go: These are the required steps for preparing to run the `permute_inputs` function to sample permutations. Take a look at the documentation with `?permute_inputs` in **R** to see information about the arguments and sampling parameters. Be sure to pass the name of your Conda environment to the `conda_env` argument.

# Using permute_inputs to sample permutations

This example uses two small sample data set included in the package.

```
data("df1", package = "GFS")
data("df2", package = "GFS")

str(df_full)
'data.frame':	20 obs. of  6 variables:
 $ x1   : num  -1.476 -1.457 -1.472 -0.258 -0.773 ...
 $ x2   : num  1.475 0.611 -0.698 -0.327 1.072 ...
 $ x3   : num  1.507 0.17 0.842 0.816 -0.083 ...
 $ y1   : num  5.994 0.276 -0.341 1.538 1.122 ...
 $ y2   : num  0 0 0 0 0 1 1 0 0 0 ...
 $ block: num  1 2 2 2 3 1 2 3 3 3 ...

str(df1)
'data.frame':	19 obs. of  3 variables:
 $ x1   : num  -1.476 0.515 -1.367 -1.457 -1.472 ...
 $ x2   : num  1.475 -0.146 -1.846 0.611 -0.698 ...
 $ block: num  1 1 1 2 2 2 2 2 2 3 ...

str(df2)
'data.frame':	18 obs. of  4 variables:
 $ x3   : num  -1.142 1.507 1.101 0.17 0.141 ...
 $ y1   : num  -3.202 5.994 -1.754 0.276 4.756 ...
 $ y2   : num  1 0 0 0 1 0 1 0 0 0 ...
 $ block: num  1 1 1 2 2 2 2 3 3 3 ...
```
Use the provided utility function to set up Conda environment for GFS. Any distribution can be used, but we recommend Anaconda for its ease of package management, hence its support in the GFS package. If all the required packages are installed on your system's default python no environment argument to `permute_inputs` will be needed, but we offer this option for those who want to manage multiple python virtual environments using Anaconda's tools.

```
create_python_environment("gfs")
```

Initialize sampling parameters to suit your data. Larger data sets will require more iterations for sampling regression coefficients, but the parameters that will have the greatest impact on the performance of the sampled permutations in estimating population statistics will be the number of burn-in iterations and the sampling interval:

```
# N: number of samples
N = 5
# I: number of iterations for sampling regression coefficients
I = 50
# t: Metropolis-Hastings samples multiplier
t = 5
# burnin: number of burn-in samples
burnin = 200
# interval: number of iterations between samples, after burn-in
interval = 20
```

To sample permutations, a model must be specified between the variables in both data sets to construct a likelihood function over permutations. The `permute_inputs` function supports models from the Normal, Logistic, and Poisson families of distributions, and joint models combining multiple families. A model is specified with a string in the format of *R* regression models in the `formula` argument and the name of the family of the model in the `family` argument. A joint model is specified equivalently with a vector of formulas and a vector of family names. Run the sampling function and save the resulting data frame containing the permutation results to a variable:

```
P = permute_inputs(df1, df2, c("y1~x1+x2+x3", "y2~x1+x2"), c("Normal", "Logistic"),
	N, I, t, burnin, interval,
	conda_env = "gfs"
)
```

With the permutation results, we can calculate statistics over the combined data set using the `average_stat` function. For the sake of example, say we want to understand the correlation structure between the "y" variables and the "x" variables across `df1` and `df2`.
The average_stat function takes in a function to be applied to the data set that returns the desired statistic.
We define some functions to be applied to the completed data set:
```
cor_x1y1 = function(df){cor(df$x1, df$y1)}
cor_x2y1 = function(df){cor(df$x2, df$y1)}
cor_x1y2 = function(df){cor(df$x1, df$y2)}
cor_x2y2 = function(df){cor(df$x2, df$y2)}
```
Passing this function to the `stat` argument of the `average_stat` function will return the estimate, its variance (the function documentation gives more information about between- and within-imputation variance), and a confidence interval according to the given confidence level (default input `a = 0.95`).
```
x1y1 = average_stat(df1, df2, P, cor_x1y1)
x2y1 = average_stat(df1, df2, P, cor_x2y1)
x1y2 = average_stat(df1, df2, P, cor_x1y2)
x2y2 = average_stat(df1, df2, P, cor_x2y2)
```

The full data set from which the individual data sets were created is also included. This is not a realistic scenario, but it gives us an opportunity to understand the results of the permutation sampling.

Here is one example of how to visualize the results for the correlation between "x1" and "x2":
```
library(plotrix)

#Plot confidence intervals of correlation estimates using plotCI from plotrix
alpha = 0.95
z = qnorm(alpha + 0.5*(1-alpha))

plotCI(1, x1y1[[1]],
	min(1 - x1y1[[1]], z * sqrt(x1y1[[2]])),
	min(x1y1[[1]], z * sqrt(x1y1[[2]])),
	ylim = c(0, 1)
)
abline(cor_x1y1(df_full), 0, col="red")
```
