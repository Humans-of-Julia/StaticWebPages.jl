@testset "Look for Explicit Imports" begin
    @test check_no_implicit_imports(
        StaticWebPages; allow_unanalyzable = (StaticWebPages,)) === nothing
end
