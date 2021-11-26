"""
zero round of imputation / univariate imputation

"""

module ZeroImpute
    export missingmatrix
    export zeroimpute
    import Statistics
    import StatsBase
    import DataFrames
    function zeroimpute!(data; method::Symbol=:mean)
    """
    methods: mean, median, max, min, mode, random in range with distribution (rand), randomly selected from existing (randid)

    """
        for col in 1:length(data[1,:])
            nums = skipmissing(data[:,col])

            value = 0
            if method == :mean
                value = Statistics.mean(nums)
            elseif method == :median
                value = Statistics.median(nums)
            elseif method == :max
                value = maximum(nums)
            elseif method == :min
                value = minimum(nums)
            elseif method == :mode
                value = StatsBase.mode(nums)
            elseif method == :rand
                value = rand() * (maximum(nums) - minimum(nums)) + minimum(nums)
            elseif method == :randid
                value = rand(nums)
            end
            
            for i in 1:length(data[:,col])
                if ismissing(data[i,col])
                    data[i,col] = value
                end
            end

        end
        # data = Matrix{Float64}(data)
        DataFrames.disallowmissing!(data)
    end

    function missingmatrix(data) # 1 exists, 0 missing
        matrix = trues(size(data))
        for j in 1:length(data[1,:]), i in 1:length(data[:,1])
            if ismissing(data[i,j])
                matrix[i,j] = 0
            end
        end
        return matrix
    end

end
