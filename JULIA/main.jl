import CSV
using DataFrames
using MLJ

include("mice.jl")

# df = CSV.read("iris.csv",DataFrame)
# allowmissing!(df)
# del = []
# for i in 1:60
#     push!(del,(rand(1:150),rand(1:4)))
# end
# del
# for (i,j) in del
#     df[i,j] = missing
# end
# CSV.write("iris_missing.csv",df)
df = CSV.read("iris_missing.csv",DataFrame)[:,1:4]

df2 = Mice.mice(df,n=10)

df2
dfog = CSV.read("iris.csv",DataFrame)[:,1:4]

sum(Matrix(dfog.-df2))