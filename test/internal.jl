@testset "StaticWebPages.jl" begin
    rm("build"; recursive = true, force = true)
    mkdir("build")
    include("run.jl")

    # Personal file existence
    @test isfile("build/index.html")
    @test isfile("build/publications.html")
    @test isfile("build/research.html")
    @test isfile("build/software.html")

    @test isfile("build/img/bmilp.png")
    @test isfile("build/img/cs.png")
    @test isfile("build/img/knowledge.png")
    @test isfile("build/img/pic.jpg")

    @test isfile("build/files/bae2018gapplanar.pdf")
    @test isfile("build/files/baffier2017hanabi.pdf")
    @test isfile("build/files/baffier2018experimental.pdf")
    @test isfile("build/files/cv.pdf")
    @test isfile("build/files/parmentier2019introducing.pdf")
    @test isfile("build/files/richoux2016ghost.pdf")

    # Template file existence
    @test isfile("build/css/app.css")
    @test isfile("build/css/foundation.min.css")

    @test isfile("build/js/app.js")
    @test isfile("build/js/vendor/foundation.min.js")
    @test isfile("build/js/vendor/jquery.js")
    @test isfile("build/js/vendor/what-input.js")

    index_html = read("build/index.html", String)
    @test occursin("class=\"avatar-item\"", index_html)
    @test occursin("class=\"social-links\"", index_html)
    @test occursin("class=\"generator-credit\"", index_html)

    app_css = read("build/css/app.css", String)
    @test occursin(".title-bar {\n        position: fixed;", app_css)
    @test occursin("grid-template-columns: repeat(4", app_css)

    rm("build"; recursive = true)
end

@testset "GitHub repository metadata cache" begin
    old_site = get(StaticWebPages.local_info, "site", nothing)
    mktempdir() do directory
        StaticWebPages.local_info["site"] = joinpath(directory, "site")
        cached = StaticWebPages.Git(
            "example/cached",
            String[];
            fetcher = (repository, filter) -> StaticWebPages.Git(
                "cached", "https://example.com/cached", "Julia", "Cached repository", 42,
                "Contributor"
            )
        )
        @test cached.name == "cached"
        @test isfile(StaticWebPages._github_cache_path())

        fallback = StaticWebPages.Git(
            "example/cached",
            String[];
            fetcher = (repository, filter) -> error("GitHub API rate limit exceeded")
        )
        @test fallback == cached

        @test_throws ErrorException StaticWebPages.Git(
            "example/cached",
            String[];
            fetcher = (repository, filter) -> error("GitHub authentication failed")
        )
    end
    if isnothing(old_site)
        delete!(StaticWebPages.local_info, "site")
    else
        StaticWebPages.local_info["site"] = old_site
    end
end
