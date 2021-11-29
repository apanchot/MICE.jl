"""
mice main function



"""



module Mice
    import MLJ
    export mice
    include("models.jl")
    include("zero_impute.jl")
    include("dataset_create.jl")
    function mice(dat;
                m::Int = 1, # number of datasets
                n::Int = 10, # number of iterations for each dataset
                seed::Int = -1, # RNG seed / not used yet
                verbosity::Int=1,
                modelnames::Vector{String} = ["LinearRegressor", "MultinomialClassifier", "LogisticClassifier", "nothing"] # model type to use for imputation: numerical, categorical, binary, count
            )

        # originaldata = copy(dat) # keep original data untouched
        data = copy(dat) # keep original data untouched


        models = Modelload.modelload(modelnames)
        missingmatrix = ZeroImpute.missingmatrix(data) # 1 exists, 0 missing
        
        return DatasetCreate.createdataset(data,n,models,missingmatrix,verbosity)
        
    end

    
end
