"""
Create a filled dataset and impute until convergence
"""

module DatasetCreate
    include("zero_impute.jl")
    include("imputer.jl")
    import Random

    function createdataset(dat,n,models,missingmatrix,verbosity; ord::Symbol = :left)
        data = copy(dat)
        ZeroImpute.zeroimpute!(data,method=:rand) # convert data into filled dataset, 0th iteration
        order = 1:length(data[1,:])
        if ord == :right
            order = length(data[1,:]):-1:1
        elseif ord == :rand
            order = Random.randperm(length(data[1,:]))
        end

        for iteration in 1:n
            if verbosity > 0
                println("iteration: ", iteration)
            end
            cycle!(data, models, missingmatrix, order, verbosity)
        end
        return data
    end


    function cycle!(data, models, missingmatrix, order, verbosity) # control one full cycle in iteration
        for targetcol in order
            if verbosity > 1
                println("column: ",targetcol)
            end
            Impute.impute!(data, models, missingmatrix, targetcol)
        end
    end


end