using StaticWebPages
using Test

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

rm("build", recursive=true)
end
