@testset "Code linting (JET.jl)" begin
    JET.test_package(StaticWebPages; target_defined_modules = true)
end
