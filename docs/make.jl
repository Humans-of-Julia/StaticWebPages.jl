using StaticWebPages
using Bibliography
using Documenter

@info "Makeing documentation..."
makedocs(;
    modules = [StaticWebPages, Bibliography],
    authors = "Jean-François Baffier",
    repo = "https://github.com/Humans-of-Julia/StaticWebPages.jl/blob/{commit}{path}#L{line}",
    sitename = "StaticWebPages.jl",
    format = Documenter.HTML(;
        prettyurls = get(ENV, "CI", "false") == "true",
        canonical = "https://Humans-of-Julia.github.io/StaticWebPages.jl",
        assets = ["assets/favicon.ico"; "assets/github_buttons.js"; "assets/custom.css"]
    ),
    pages = [
        "Home" => "index.md",
        "Components" => [
            "Theming" => "themes.md",
            "Items" => "items.md",
            "Pages" => "pages.md"
        ],
        "Dependencies" => [
            "Bibliography.jl" => "bibliography.md"
        ],
        "Library" => [
            "public.md",
            "internal.md"
        ]
    ]
)

deploydocs(;
    repo = "github.com/Humans-of-Julia/StaticWebPages.jl.git", devbranch = "master")
