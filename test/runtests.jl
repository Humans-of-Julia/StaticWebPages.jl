using StaticWebPages

using Aqua
using ExplicitImports
using JET
using Test
using TestItemRunner

@testset "Package tests: StaticWebPages" begin
    include("internal.jl")
    include("Aqua.jl")
    include("ExplicitImports.jl")
    # include("JET.jl") # FIXME - update for julia 1.12
    include("TestItemRunner.jl")
end
