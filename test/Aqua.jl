@testset "Aqua.jl" begin
    # TODO: Fix the broken tests and remove the `broken = true` flag
    Aqua.test_all(
        StaticWebPages;
        ambiguities = (broken = false,),
        deps_compat = false,
        piracies = (broken = false,)
    )

    @testset "Ambiguities: StaticWebPages" begin
        Aqua.test_ambiguities(StaticWebPages;)
    end

    @testset "Piracies: StaticWebPages" begin
        Aqua.test_piracies(StaticWebPages;)
    end

    @testset "Dependencies compatibility (no extras)" begin
        Aqua.test_deps_compat(
            StaticWebPages;
            check_extras = false            # ignore = [:Random]
        )
    end
end
