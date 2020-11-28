using StaticWebPages
using Documenter

@info "Makeing documentation..."
makedocs(;
    modules=[StaticWebPages],
    authors="Jean-François Baffier",
    repo="https://github.com/Azzaare/StaticWebPages.jl/blob/{commit}{path}#L{line}",
    sitename="StaticWebPages.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://Azzaare.github.io/StaticWebPages.jl",
        assets = ["assets/favicon.ico"; "assets/github_buttons.js"; "assets/custom.css"],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/Azzaare/StaticWebPages.jl.git",
    devbranch="main",
)