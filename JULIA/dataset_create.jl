"""
Create a filled dataset and impute until convergence
"""

module DatasetCreate
    include("zero_impute.jl")
    include("imputer.jl")
    import Random

    function createdataset(dat,n,models,missingmatrix; ord::Symbol = :left)
        data = copy(dat)
        ZeroImpute.zeroimpute!(data,method=:rand) # convert data into filled dataset, 0th iteration
        order = 1:length(data[1,:])
        if ord == :right
            order = length(data[1,:]):-1:1
        elseif ord == :rand
            order = Random.randperm(length(data[1,:]))
        end
        
        for iteration in 1:n
            cycle!(data, models, missingmatrix, order)
        end
        return data
    end


    function cycle!(data, models, missingmatrix, order) # control one full cycle in iteration
        for targetcol in order
            Impute.impute!(data, models, missingmatrix, targetcol)
        end
    end


end