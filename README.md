# MICE.jl
Multiple Imputation by Chained Equations

## Features
* MLJ linear regression models / only for numerical at the moment
* Only a single imputation dataset at the moment

## Notes
* Uses global RNG
* Supports matrix or dataframe although not tested thoroughly
* 0th iteration supports mean, median, mode and randomly sampled values
* Imputed column order can be selected as left to right, right to left, or random shuffle (keeps same shuffle for all iteration)

## Missing Features

* [] Multiple imputation datasets and method for combining them together
* [] More Models
* [] Categorical / Binary variables
* [] One-hot / multi-hot columns
* [] Count variables
* [] Use local seed(s) / reset global seed
* [] Add strict Tables (MLJ scientific types) vs matrix (variable type) support
* [] Multithread support
* [] Speed / memory optimization
* [] Expose model, 0th iteration, column order kwargs to user
* [] GPU support
* [] Standardizer / Normalizer / Box-Cox transform 
* [] Iteration convergence metrics
