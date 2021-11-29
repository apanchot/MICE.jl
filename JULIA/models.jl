"""
load models from MLJ / other depository

"""



module Modelload
    import MLJ
    export modelload

    function modelload(modelnames::Vector{String}; kwargs::Dict = Dict() )

        models = Vector{Any}(undef,length(modelnames))
        for modelid in 1:length(modelnames) # load models from MLJ 
            if modelnames[modelid] != "nothing"
                # modelload2(modelnames[modelid], kwargs)
                try
                    models[modelid] = modelload2(modelnames[modelid], kwargs)
                catch
                    error("Model loading failed: Check your MLJ / MLJ model packages installation and try again")
                end
            else
                models[modelid] = nothing
            end
        end
        return models
    end
    function modelload2(modelname::String, kwargs::Dict )
        if modelname == "nothing"
            return nothing
        elseif modelname == "LinearRegressor"
            MLJ.@load LinearRegressor pkg=MLJLinearModels verbosity=0
            return MLJLinearModels.LinearRegressor(;kwargs...)
        elseif modelname == "RidgeRegressor"
            MLJ.@load RidgeRegressor pkg=MLJLinearModels verbosity=0
            return MLJLinearModels.RidgeRegressor(;kwargs...)
        elseif modelname == "LassoRegressor"
            MLJ.@load LassoRegressor pkg=MLJLinearModels verbosity=0
            return MLJLinearModels.LassoRegressor(;kwargs...)
        elseif modelname == "ElasticNetRegressor"
            MLJ.@load ElasticNetRegressor pkg=MLJLinearModels verbosity=0
            return MLJLinearModels.ElasticNetRegressor(;kwargs...)
        elseif modelname == "RobustRegressor"
            MLJ.@load RobustRegressor pkg=MLJLinearModels verbosity=0
            return MLJLinearModels.RobustRegressor(;kwargs...)
        elseif modelname == "HuberRegressor"
            MLJ.@load HuberRegressor pkg=MLJLinearModels verbosity=0
            return MLJLinearModels.HuberRegressor(;kwargs...)
        elseif modelname == "QuantileRegressor"
            MLJ.@load QuantileRegressor pkg=MLJLinearModels verbosity=0
            return MLJLinearModels.QuantileRegressor(;kwargs...)
        elseif modelname == "LADRegressor"
            MLJ.@load LADRegressor pkg=MLJLinearModels verbosity=0
            return MLJLinearModels.LADRegressor(;kwargs...)
        elseif modelname == "LogisticClassifier"
            MLJ.@load LogisticClassifier pkg=MLJLinearModels verbosity=0
            return MLJLinearModels.LogisticClassifier(;kwargs...)
        elseif modelname == "MultinomialClassifier"
            MLJ.@load MultinomialClassifier pkg=MLJLinearModels verbosity=0
            return MLJLinearModels.MultinomialClassifier(;kwargs...)
        else
            error("Unknown model")
            return nothing
        end
    end
    

end