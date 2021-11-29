"""
main imputation with given models

"""

module Impute
    export impute!
    import MLJ

    function impute!(data, models, missingmatrix, targetcol)

        x = data[:,1:end .!= targetcol]
        y = data[:,targetcol]

        train = missingmatrix[:,targetcol] #trues(length(data[:,targetcol]))
        # for i in 1:length(data[:,targetcol])
        #     if missingmatrix[i,targetcol] == 0
        #         train[i] = 0
        #     end
        # end

        xtrain = x[train,:]
        ytrain = y[train]
        xtest = x[.~train,:]

        ids = 1:length(y)
        ids = ids[.~train]

        mdl = models[1]
        mach = MLJ.machine(mdl, xtrain, ytrain)
        MLJ.fit!(mach,verbosity=0)
        ypred = MLJ.predict(mach, xtest)

        for i in 1:length(ids)
            data[ids[i],targetcol] = ypred[i]
        end


    end
end
